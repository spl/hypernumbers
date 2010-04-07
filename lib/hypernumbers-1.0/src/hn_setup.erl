-module(hn_setup).

-export([
         site/3, site/4,
         delete_site/1, 
         update/0, update/1, update/3,
         site_exists/1,
         get_sites/0,
         get_site_type/1,
         create_path_from_name/2,
         is_path/1
        ]).

-include("spriki.hrl").
-include("hypernumbers.hrl").

%% Setup a new site from scratch
-spec site(string(), atom(), [{atom(), any()}]) -> ok.
site(Site, Type, Opts) when is_list(Site), is_atom(Type) ->
    site(Site, Type, Opts, [corefiles, sitefiles, json, groups, 
                            permissions, script]).

-spec site(string(), atom(), [{atom(), any()}], [atom()]) -> ok.
site(Site, Type, Opts, ToLoad) when is_list(Site), is_atom(Type) ->
    hn_setup:site_exists(Site) andalso
        throw({site_exists, Site}),
    error_logger:info_msg("Setting up: ~p as ~p~n", [Site, Type]),
    ok = create_site_tables(Site, Type),
    ok = sitemaster_sup:add_site(Site),
    ok = update(Site, Type, Opts, ToLoad).

%% Delete a site
%% Todo: Does not currently remove DNS entries.
-spec delete_site(string()) -> ok.
delete_site(Site) ->
    Dest = code:lib_dir(hypernumbers) ++ "/../../var/sites/"
        ++ hn_util:site_to_fs(Site) ++ "/",
    ok = hn_util:delete_directory(Dest),
    ok = auth_srv:delete_site(Site),
    ok = sitemaster_sup:delete_site(Site),
    ok = mnesia:activity(transaction, 
                         fun mnesia:delete/3, 
                         [core_site, Site, write]),
    [ {atomic, ok}  = mnesia:delete_table(hn_db_wu:trans(Site, Table))
      || {Table, _F, _T, _I} <- tables()],
    ok.

%% Update all existing sites with default options
-spec update() -> ok. 
update() ->
    update([], [corefiles]).

-spec update(list()) -> ok. 
update(Opts) ->
    update([], Opts).


%% Update all sites
-spec update(list(), list()) -> ok. 
update(Opaque, Opts) ->
    F = fun(#core_site{site=Site, type=Type}, _Acc) ->
                update(Site, Type, Opaque, Opts)
        end,
    Trans = fun() -> mnesia:foldl(F, nil, core_site) end,
    {atomic, _} = mnesia:transaction(Trans),
    ok.


-spec update(string(), list(), list()) -> ok.
update(Site, Opaque, Opts) ->
    update(Site, get_site_type(Site), Opaque, Opts).


-spec update(string(), atom(), list(), list()) -> ok.
update(Site, Type, Opaque, Opts) ->
    [ ok = setup(Site, Type, Opaque, X) || X <- Opts ],
    ok.

%% Quick and dirty test to see if a site exists
-spec site_exists(string()) -> boolean().
site_exists(Site) ->
    case mnesia:dirty_read(core_site, Site) of
        [_] -> true; 
        []  -> false
    end.
    
-spec get_sites() -> list().
get_sites() -> 
    mnesia:activity(transaction, fun mnesia:all_keys/1, [core_site]).

-spec get_site_type(string()) -> atom().
get_site_type(Site) ->
    [#core_site{type=Type}] = mnesia:dirty_read(core_site, Site),
    Type.

-spec setup(string(), atom(), list(), atom()) -> ok.
setup(Site, _Type, _Opts, corefiles) ->
    ok = filelib:ensure_dir(sitedir(Site)),
    % first copy over the standard type
    ok = hn_util:recursive_copy(coreinstalldir(), sitedir(Site));
setup(Site, Type, _Opts, sitefiles) ->
    ok = filelib:ensure_dir(sitedir(Site)),
    % first copy over the standard type
    ok = hn_util:recursive_copy(moddir(Type), sitedir(Site));
setup(Site, _Type, _Opts, batch) ->
    ok = batch_import(Site);
setup(Site, Type, _Opts, json) ->
    ok = import_json(Site, moddir(Type));
setup(Site, _Type, Opts, groups) ->
    {ok, Terms} = file:consult([sitedir(Site),"/","groups.script"]),
    Terms2 = [group_transform(T, Opts) || T <- Terms],
    ok = hn_groups:load_script(Site, Terms2);
setup(Site, _Type, _Opts, permissions) ->
    {ok, Terms} = file:consult([sitedir(Site),"/","permissions.script"]),
    ok = auth_srv:load_script(Site, Terms);
setup(Site, _Type, Opts, script) ->
    {ok, Terms} = file:consult([sitedir(Site),"/","setup.script"]),
    [ok = run_script(T, Site, Opts) || T <- Terms],
    ok.

%% -spec resave_views() -> ok.
%% resave_views() ->
%%     ViewsPath = "/../../var/sites/*/docroot/views/*/*/*.meta",
%%     [ resave_view(X)
%%       || X <- filelib:wildcard(code:lib_dir(hypernumbers) ++ ViewsPath) ],
%%     ok.

%% -spec resave_view(string()) -> ok.
%% resave_view(Path) ->
%%     [FileName, User, Type, "views", "docroot", Site | _ ]
%%         = lists:reverse(string:tokens(Path, "/")),
%%     [Domain, Port] = string:tokens(Site, "&"),
%%     NSite          = "http://"++Domain++":"++Port,
%%     ViewName     = [Type, "/", User, "/", filename:basename(FileName, ".meta")],
%%     {ok, [Data]} = file:consult(Path),
%%     ok           = hn_mochi:save_view(NSite, ViewName, Data).

-spec create_site_tables(string(), atom()) -> ok.
create_site_tables(Site, Type)->
    %% Seems sensible to keep this restricted
    %% to disc_copies for now
    Storage = disc_copies,
    [ok = hn_db_admin:create_table(hn_db_wu:trans(Site, N),
                                   N, F, Storage, T, true, I)
     || {N,F,T,I} <- tables()],
    Trans = fun() ->
                    mnesia:write(#core_site{site = Site, type = Type})
            end,
    {atomic, ok} = mnesia:transaction(Trans),
    ok.


-define(TBL(N, T, I), {N, record_info(fields, N), T, I}).
tables() ->
    [ ?TBL(dirty_queue,           ordered_set, []),
      ?TBL(dirty_notify_in,       set,     	   []),         
      ?TBL(dirty_inc_hn_create,   set,    	   []),         
      ?TBL(dirty_notify_back_in,  set,    	   []),         
      ?TBL(dirty_notify_out,      set,    	   []),         
      ?TBL(dirty_notify_back_out, set,    	   []),         
      ?TBL(item,                  bag,    	   [key]),      
      ?TBL(local_objs,            bag,    	   [obj,idx]), 
      ?TBL(local_cell_link,       bag,    	   [childidx]), 
      ?TBL(relation,              set,    	   []),
      ?TBL(group,                 set,    	   []),         
      ?TBL(remote_objs,           set,    	   []),         
      ?TBL(remote_cell_link,      bag,    	   []),         
      ?TBL(incoming_hn,           set,    	   []),         
      ?TBL(outgoing_hn,           set,    	   []),         
      ?TBL(styles,                bag,    	   []),         
      ?TBL(style_counters,        set,    	   []),         
      ?TBL(page_vsn,              set,    	   []),         
      ?TBL(page_history,          bag,    	   []) ].


%% Import files on a batch basis
batch_import(Site) ->
    Files = code:lib_dir(hypernumbers) ++ "/../../var/sites/"
        ++ hn_util:site_to_fs(Site) ++ "/import/*.csv",
    OverWild    = filelib:wildcard(Files ++ ".replace"),
    AppendWild  = filelib:wildcard(Files ++ ".append"),
    OverFiles   = lists:filter(fun is_path/1, OverWild),
    AppendFiles = lists:filter(fun is_path/1, AppendWild),
    [ ok = hn_import:csv_file(Site ++ create_path_from_name(X, ".csv.replace"), X) || X <- OverFiles],
    [ ok = hn_import:csv_append(Site ++ create_path_from_name(X, ".csv.append"), X) || X <- AppendFiles],
    ok.

%% Import a set of json files into the live spreadsheet
import_json(Site, Dir) ->
    Files = filelib:wildcard(Dir++"/data/*.json"),
    JsonFiles = lists:filter(fun is_path/1, Files),
    [ ok = hn_import:json_file(Site ++ create_path_from_name(Json, ".json"),
                               Json)
      || Json <- JsonFiles],
    ok.

is_path(L) ->
    Tokens = string:tokens(L, "/"),
    File = hd(lists:reverse(Tokens)),
    case string:tokens(File, ".") of
        ["path" | _T] -> true;
        _Other        -> false
    end.

create_path_from_name(Name, FileType) ->
    [ "path" | Rest ]
        = string:tokens(filename:basename(Name, FileType), "."),
    hn_util:list_to_path(Rest).

-spec group_transform(tuple(), [tuple()]) -> [tuple()].
group_transform({add_user, Terms}, Opts) -> 
    {add_user, substitute('$creator', pget(creator, Opts), Terms)};
group_transform(X, _Opts) -> 
    X.

-spec run_script(tuple(), string(), [tuple()]) -> ok. 
run_script({Path, '$email'}, Site, Opts) ->
    write_cell(Path, Site, pget(email, Opts));
run_script({Path, '$name'}, Site, Opts) ->
    write_cell(Path, Site, pget(name, Opts));
run_script({Path, '$site'}, Site, _Opts) ->
    write_cell(Path, Site, Site);
%% run_script({Path, '$expiry'}, Site, _Opts) ->
%%     {Date, _Time} = calendar:now_to_datetime(now()),
%%     NewDays = calendar:date_to_gregorian_days(Date) + 31,
%%     NewDate = calendar:gregorian_days_to_date(NewDays),
%%     Expr = "This site will expire on "
%%         ++ dh_date:format("D d M Y", {NewDate, {0, 0, 0}}),
%%     write_cell(Path, Site, Expr);
run_script({Path, Var}, Site, _Opts) when is_atom(Var) ->
    Expr = lists:flatten(io_lib:format("no binding for '~s'", [Var])),
    write_cell(Path, Site, Expr);
run_script({Path, Expr}, Site, _Opts) ->
    write_cell(Path, Site, Expr).

write_cell(Path, Site, Expr) ->
    RefX = hn_util:parse_url(Site++Path), 
    hn_db_api:write_attributes([{RefX, [{"formula", Expr}]}]).


substitute(Var, Val, Var) ->
    Val;
substitute(Var, Val, Terms) when is_list(Terms) andalso 
                                 not(is_integer(hd(Terms))) ->
    [substitute(Var, Val, T) || T <- Terms];
substitute(Var, Val, Term) when is_tuple(Term) ->
    list_to_tuple(substitute(Var, Val, tuple_to_list(Term)));
substitute(_Var, _Val, Term) ->
    Term.

%% add_u(Site, User, {champion, C}) ->
%%     UserName = hn_users:name(User),
%%     Path     = replace('$user', UserName, pget(path, C)),
%%     auth_srv:set_champion(Site, Path, pget(view, C));

%% add_u(Site, User, {add_view, C}) -> 
%%     UserName = hn_users:name(User),
%%     Perms    = replace('$user', UserName, pget(perms, C)),
%%     Path     = replace('$user', UserName, pget(path, C)),
%%     auth_srv:add_view(Site, Path, Perms, pget(view, C));

%% add_u(Site, User, {import, P}) ->
%%     UserName = hn_users:name(User),
%%     P2 = replace('$user', "$user", pget(path, P)),
%%     Path = replace('$user', UserName, pget(path, P)),
%%     FileName = re:replace(hn_util:path_to_json_path(P2), "^path.",
%%                           "template.", [{return, list}]),
%%     Dest = code:lib_dir(hypernumbers) ++ "/../../var/sites/"
%%         ++ hn_util:site_to_fs(Site) ++ "/data/",
%%     Url = Site ++ hn_util:list_to_path(Path),
%%     ok = hn_import:json_file(Url, Dest ++ FileName).

-spec coreinstalldir() -> string().
coreinstalldir() ->
    code:priv_dir(hypernumbers) ++ "/core_install".

-spec moddir(atom()) -> string(). 
moddir(Type) ->
    code:priv_dir(hypernumbers) ++ "/site_types/" ++ atom_to_list(Type).

-spec sitedir(string()) -> string(). 
sitedir(Site) ->
    code:lib_dir(hypernumbers) ++ "/../../var/sites/"
        ++ hn_util:site_to_fs(Site) ++ "/".

pget(Key, List) ->
    pget(Key, List, "").
pget(Key, List, Default) ->
    proplists:get_value(Key, List, Default).
