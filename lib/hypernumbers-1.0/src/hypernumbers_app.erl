%% @author Dale Harvey <dale@hypernumbers.com>
%% @copyright Hypernumbers Ltd.
-module(hypernumbers_app).
-behaviour(application).

-export([
         start/2,
         stop/1,
         local_hypernumbers/0
        ]).

-include("hypernumbers.hrl").
-include("spriki.hrl").

%% @spec start(Type,Args) -> {ok,Pid} | Error
%% @doc  Application callback
start(_Type, Args) ->
    ok = basic_start(),
    case Args of
        []      -> normal_start();
        [debug] -> io:format("Hypernumbers Debug: the hypernumbers "
                             ++ "application has not been started~n"),
                   {ok, self()}
    end.

basic_start() ->
    io:format("Hypernumbers Startup~n********************~n~n"),
    ok = ensure_dirs(),
    io:format("Hypernumbers Startup: directories inited...~n"),
    ok = init_tables(),
    io:format("Hypernumbers Debug Started: all good!~n"),
    ok.

normal_start() ->
    io:format("Hypernumbers Startup: tables initiated...~n"),
    ok = load_muin_modules(),
    io:format("Hypernumbers Startup: muin modules loaded...~n"),
    {ok, Pid} = hypernumbers_sup:start_link(),
    io:format("Hypernumbers Startup: hypernumbers supervisors started...~n"),
    ok = case application:get_env(hypernumbers, environment) of
             {ok,development} -> dev_tasks();
             {ok,production}  -> production_tasks()
         end,
    io:format("Hypernumbers Startup: environment variables read...~n"),
    ok = mochilog:start(),
    io:format("Hypernumbers Startup: mochilog started...~n"),
    io:format("Hypernumbers Startup: all good!, over and out~n"),
    {ok, Pid}.

%% @spec stop(State) -> ok
%% @doc  Application Callback
stop(_State) ->
    ok = mochilog:stop().

ensure_dirs() ->
    Dirs = [application:get_env(hypernumbers, dets_dir),
            application:get_env(mnesia, dir),
            application:get_env(sasl, error_logger_mf_dir)],
    [ok = filelib:ensure_dir(D++"/") || {ok, D} <- Dirs],
    ok.

% these need to be loaded for exported_function() to work
load_muin_modules() ->
    [ {module, Module} = code:ensure_loaded(Module)
      || Module <- muin:get_modules() ],
    ok.

init_tables() ->
    ok = ensure_schema(),
    Storage = disc_only_copies,

    %% Core system tables -- required to operate system
    CoreTbls = [ {core_site, record_info(fields, core_site), set, []}],

    [ok = hn_db_admin:create_table(N, N, F, Storage, T, true, I)
     || {N,F,T,I} <- CoreTbls],
    ok.

ensure_schema() ->
    case mnesia:system_info(tables) of
        [schema] ->
            build_schema();
        Tables ->
            mnesia:wait_for_tables(Tables, infinity)
    end.

build_schema() ->
    ok = application:stop(mnesia),
    ok = mnesia:delete_schema([node()]),
    ok = mnesia:create_schema([node()]),
    ok = application:start(mnesia).

dev_tasks() ->
    application:set_env(hypernumbers, sync_url,
                        "http://hypernumbers.dev:9000"),
    create_dev_zone(),
    local_hypernumbers().

create_dev_zone() ->
    Gen = fun() -> [crypto:rand_uniform($a, $z+1)] end,
    ok = hns:set_resource("127.0.0.1", 9000, node(), 1),
    hns:create_zone(?DEV_ZONE, 1, 26, Gen),
    ok.

local_hypernumbers() ->
    Site = "http://hypernumbers.dev:9000",
    {ok, _, Uid1} = passport:get_or_create_user("test@hypernumbers.com"),
    {ok, _, Uid2} = passport:get_or_create_user("guest@hypernumbers.com"),
    case hn_setup:site(Site, blank, [{creator, Uid1}]) of
        {initial_view, []} ->
            passport:validate_uid(Uid1),
            passport:validate_uid(Uid2),
            % make guest a member of group guest
            hn_groups:add_user(Site, "guest", Uid2),
            passport:set_password(Uid1, "i!am!secure"),
            passport:set_password(Uid2, "i!am!secure"),
            ok = hn_db_admin:disc_only(Site);
        {error, site_exists} ->
            io:format("Hypernumbers Local: Site ~p exists~n", [Site]),
            ok
    end.

production_tasks() ->
    % net_adm:world() depends on you being in $GITROOT
    {ok, CWD} = file:get_cwd(),
    Root = code:lib_dir(hypernumbers) ++ "/../../",
    file:set_cwd(Root),
    net_adm:world(),
    % play nice children, and reset the cwd, there, there
    file:set_cwd(CWD),
    ok.
