%%%-------------------------------------------------------------------
%%% @author     Gordon Guthrie 
%%% @copyright (C) 2009, Hypernumbers Ltd
%%% @doc       code to manage backup and restore etc as well
%%%            as 'grabbing' sites and applications
%%%
%%% @end
%%% Created : 18 Dec 2009 by Gordon Guthrie gordon@hypernumbers.com
%%%
%%%-------------------------------------------------------------------
-module(server_mgt).

-include("spriki.hrl").

-export([export/1, export/2,
         import/1, import/2,
         export_as_sitemod/2 ]).

%% Auxillary functions.
%-export([backup, move, delete, etc...]).

%% Exports a site as a sitemod that can be loaded by a factory
-spec export_as_sitemod(atom(), list()) -> ok.
export_as_sitemod(NewType, Site) ->
    SiteType = join([code:lib_dir(sitemods), "priv", "site_types"]),
    OldType  = hn_setup:get_site_type(Site),

    % TODO, this might be ok, but need support for exporting
    % and importing users (dont copy if the same file)
    (OldType =/= NewType) andalso
        file:copy(join([SiteType, OldType, "users.script"]),
                  join([SiteType, NewType, "users.script"])),
    
    ok = export_site(join([SiteType, NewType]), Site),
    ok = hn_util:recursive_copy(join([SiteType, NewType,"etf"]),
                                join([SiteType, NewType, "data"])),
    
    % Delete backup things
    [ file:delete( join([SiteType, NewType,  File]) )
      || File <- ["type", "mnesia.backup"] ],
    [ hn_util:delete_directory( join([SiteType, NewType, join(Dir)]) )
      || Dir <- [["etf"], ["views", "_g", "core"]] ],
    ok. 
    
%% Export sites to the given directory.
export(Dest) ->
    Sites = hn_setup:get_sites(),
    export(Dest, Sites).
%% Export the provided subset of sites to the destination directory.
%% Sites are expected in leading protocol form.
export(Dest, Sites) ->
    [ ok = export_site(join([Dest, hn_util:site_to_fs(S)]), S)
      || S <- Sites, hn_setup:site_exists(S)],
    ok.

export_site(Dest, Site) ->
    filelib:ensure_dir([Dest,"/"]),
    ok = dump_type(Site, Dest),
    ok = dump_etf(Site, Dest),
    ok = dump_mnesia(Site, Dest),
    ok = dump_users(Site, Dest),
    ok = dump_perms(Site, Dest),
    ok = dump_views(Site, Dest).

dump_type(Site, SiteDest) ->
    Type = hn_setup:get_site_type(Site),
    {ok, F} = file:open(join([SiteDest, "type"]), [write]),
    io:format(F, "~p.", [Type]),
    file:close(F).

dump_etf(Site, SiteDest) -> 
    EtfDest = filename:join(SiteDest, "etf"),
    filelib:ensure_dir([EtfDest,"/"]),  
    Ref = hn_util:parse_url(Site),
    Encoder = mochijson:encoder([{input_encoding, utf8}]),
    Paths = hn_db_api:read_pages(Ref),
    Pages = [Encoder(hn_mochi:page_attributes(Ref#refX{path = P}, anonymous))
             || P <- Paths],
    [ok = file:write_file(
            filename:join(EtfDest, hn_util:path_to_json_path(Path)), 
            io_lib:format("~s", [lists:flatten(Page)])) || 
        {Path, Page} <- lists:zip(Paths, Pages)],
    ok.

dump_mnesia(Site, SiteDest) -> 
    SiteFs = hn_util:site_to_fs(Site),
    Tables = [T || T <- mnesia:system_info(tables),
                   lists:prefix(SiteFs, atom_to_list(T))],
    ok = hn_db_admin:backup(Tables, SiteDest, "mnesia.backup").

dump_users(Site, SiteDest) ->
    Users = hn_users:dump_script(Site),
    ok = file:write_file(filename:join(SiteDest, "users.script"), Users).

dump_perms(Site, SiteDest) ->
    Perms = auth_srv2:dump_script(Site),
    ok = file:write_file(filename:join(SiteDest, "permissions.script"), 
                         Perms).

dump_views(Site, SiteDest) -> 
    ViewDest = join([SiteDest, "views"]),
    SiteFs   = hn_util:site_to_fs(Site),
    Source   = join(["var", "sites", SiteFs, "views"]),
    hn_util:recursive_copy(Source, ViewDest).


%% Import all sites found in the given directory.
import(Src) ->
    Sites = [hn_util:site_from_fs(F) || 
                F <- filelib:wildcard("*", Src),
                hd(F) /= ".",
                filelib:is_dir(filename:join(Src,F))],
    import(Src, Sites).
%% Import the subset of sites found within the source directory.
%% Sites are expected in leading protocol form.
import(Src, Sites) ->
    [ok = import_site(Src, S) || S <- Sites],
    ok.
import_site(Src, Site) ->
    SiteSrc = join([Src, hn_util:site_to_fs(Site)]),
    Type    = load_type(SiteSrc),
    ok = hn_setup:site(Site, Type, []),
    ok = load_etf(Site, SiteSrc),
    ok = load_users(Site, SiteSrc),
    ok = load_views(Site, SiteSrc),
    ok = load_perms(Site, SiteSrc).

load_type(SiteSrc) ->
    {ok, [Type]} = file:consult(join([SiteSrc, "type"])),
    Type.

load_etf(Site, SiteSrc) ->
    EtfSrc = join([SiteSrc, "etf"]),
    Jsons  = filelib:wildcard("path.*.json", EtfSrc),
    Paths  = [hn_util:list_to_path(
                string:tokens(
                  filename:basename(P, ".json"), 
                  "."
                 )) || "path."++P <- Jsons],
    [ok = hn_import:json_file(Site++Path, join([EtfSrc, Json])) ||
        {Json, Path} <- lists:zip(Jsons, Paths)],
    ok.

-define(pget(Key, List), (proplists:get_value(Key, List))).
load_users(Site, SiteSrc) ->
    {ok, Users} = file:consult(filename:join(SiteSrc, "users.script")),
    [ok = hn_users:create_raw(Site, 
                    ?pget(name, U), ?pget(groups, U),
                    ?pget(password, U), ?pget(data, U)) 
     || U <- Users],
    ok.

load_views(Site, SiteSrc) ->
    SiteFs = hn_util:site_to_fs(Site),
    Source = join([SiteSrc, "views"]),
    Dest   = join(["var", "sites", SiteFs, "views"]),
    hn_util:recursive_copy(Source, Dest).

load_perms(Site, SiteSrc) ->
    {ok, Perms} = file:consult(filename:join(SiteSrc, "permissions.script")),
    auth_srv2:load_script(Site, Perms).

join(FileName) ->
    filename:join(FileName).

