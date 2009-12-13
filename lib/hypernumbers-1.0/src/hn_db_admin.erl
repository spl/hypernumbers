%%% @author    Gordon Guthrie 
%%% @copyright (C) 2009, Hypernumbers Ltd
%%% @doc       functions for mnesia administration
%%%
%%% @end
%%% Created : 13 Dec 2009 by gordon@hypernumbers.com

-module(hn_db_admin).

-define(CACHEABLE_TABLES, ["local_objs", "local_cell_link", "item"]).

-export([
         create_table/6,
         into_mem/1,
         outof_mem/1
        ]).

-spec create_table(atom(), atom(),
                   any(),
                   disc_only_copies | disc_copies | ram_copies,
                   set | bag | ordered_set,
                   [atom()]) -> ok. 
create_table(TblName, Rec, Fields, Storage, Type, Indicies) ->
    R = mnesia:create_table(TblName, [{record_name, Rec},
                                      {attributes, Fields},
                                      {Storage, [node()]},
                                      {type, Type},
                                      {index, Indicies}]),
    case R of 
        {atomic, ok}                   -> ok;
        {aborted, {already_exists, _}} -> ok;
        {aborted, Reason}              -> throw(Reason)
    end.

-spec into_mem(list()) -> ok.
into_mem("http://" ++ SiteAndPort) ->
    [Site, Port] = string:tokens(SiteAndPort, ":"),
    [{atomic, ok} = chg_copy_type(Site, Port, X, disc_copies)
     || X <- ?CACHEABLE_TABLES],
    ok.

-spec outof_mem(list()) -> ok.
outof_mem("http://" ++ SiteAndPort) ->
    [Site, Port] = string:tokens(SiteAndPort, ":"),
    [{atomic, ok} = chg_copy_type(Site, Port, X, disc_only_copies)
     || X <- ?CACHEABLE_TABLES],
    ok.

chg_copy_type(Site, Port, Table, Mode) ->
    ActualTable = list_to_existing_atom(Site ++ "&"
                                        ++ Port ++ "&"
                                        ++ Table),
    mnesia:change_table_copy_type(ActualTable, node(), Mode).
