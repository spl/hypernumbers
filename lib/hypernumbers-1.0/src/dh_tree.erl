%%% @author Dale Harvey <dale@hypernumbers.com>
%%% @copyright Hypernumbers Ltd.
%%% @TODO write a module descriptor for this module
-module(dh_tree).

-include("hypernumbers.hrl").
-include_lib("eunit/include/eunit.hrl").

-export([
         new/0,
         create/1,
         add/2,
         set/3,
         erase/2,
         delete/2,
         flatlist/1,
         segments_below/2,
         update/3,
         is_member/2
        ]).

-spec create(List::list(list(string()))) -> any().
%% doc take a list of keys and generate a tree
new() ->
    create([]).

create(List) ->
    create(List,dict:new()).
create([],Dict) ->
    Dict;
create([H|T],Dict) ->
    create(T,add(H,Dict)).

-spec segments_below(List::list(), Dict::any()) ->
     List::list().
segments_below([H], Dict) ->
    case dict:is_key(H, Dict) of
        false -> [];
        true  -> dict:fetch_keys(dict:fetch(H, Dict))
    end;
segments_below([H | T], Dict) ->
    case dict:is_key(H, Dict) of
        false -> [];
        true  -> segments_below(T, dict:fetch(H, Dict))
    end.

-spec add(Key::list(string()),Dict::any()) -> any().
%% @doc Add a key in the form ["key1","key2"]
%%      to the tree
add([],Dict) ->
    Dict;
add([H],Dict) ->
    case dict:is_key(H,Dict) of
        true  -> Dict;
        false -> dict:store(H,dict:new(),Dict)
    end;
add([H|T],Dict) ->
    NDict = case dict:is_key(H,Dict) of
                true  -> dict:fetch(H,Dict);
                false -> dict:new()
            end,
    dict:store(H,add(T,NDict),Dict).

set([H], Val, Dict) ->
    dict:store(H, Val, Dict);
set([H|T], Val, Dict) ->
    NDict = case dict:is_key(H,Dict) of
                true  -> dict:fetch(H,Dict);
                false -> dict:new()
            end,
    dict:store(H,set(T, Val, NDict),Dict).

-spec erase(Key::list(string()),Dict::any()) -> any().
%% @doc erase a node from the tree
%%      (including children)
erase([H],Dict) ->
    dict:erase(H,Dict);
erase([H|T],Dict) ->
    dict:store(H,erase(T,dict:fetch(H,Dict)),Dict).

-spec delete(Key::list(string()),Dict::any()) -> any().
%% @doc delete a node from the tree
%%      (does not include children)
delete([H],Dict) ->
    Empty = dict:new(),
    case dict:fetch(H, Dict) of
        Empty -> dict:erase(H,Dict);
        _     -> Dict % sub-trees exist -don't delete!
    end;
delete([H|T],Dict) ->
    dict:store(H,delete(T,dict:fetch(H,Dict)),Dict).

update([H], Dict, F) ->
    NDict = case dict:is_key(H, Dict) of
                true  -> F(dict:fetch(H, Dict));
                false -> F(undefined)
            end,
    dict:store(H, NDict, Dict);

update([H|T], Dict, F) ->
    NDict = case dict:is_key(H,Dict) of
                true  -> dict:fetch(H,Dict);
                false -> dict:new()
            end,
    dict:store(H, update(T,NDict, F),Dict).


-spec flatlist(Dict::any()) -> {ok,list()}.
%% @doc Generate a flat list of all the nodes
%%      represented by the nested dict
flatlist(Dict) ->
    {ok,flatlist([],[],Dict)}.

-spec flatlist(List::list(), Acc::list(), Dict::any()) ->
    list(list(string())).
%% @doc Generate a flat list of all the nodes
%%      represented by the nested dict
flatlist(List,Acc,Dict) ->
    case dict:fetch_keys(Dict) of
        [] ->
            [Acc|List];
        Keys ->
            F = fun(X,NAcc) ->
                        flatlist(NAcc,Acc++[X],dict:fetch(X,Dict))
                end,
            lists:foldl(F,[Acc|List],Keys)
    end.

-spec is_member(List::list(), Dict::any()) -> true | false.
is_member([H], Dict) -> dict:is_key(H, Dict);
is_member([H | T], Dict) ->
    case dict:is_key(H, Dict) of
        false -> false;
        true -> is_member(T, dict:fetch(H, Dict))
            end.

%%%===================================================================
%% EUnit Tests
%%%===================================================================

testA1([]) ->
    Path = ["bleh", "blah", "bloh"],
    Dict = dh_tree:new(),
    IsMember = dh_tree:is_member(Path, Dict),
    ?assertEqual(false, IsMember).

testA2([]) ->
    Path = ["blah", "blah", "bleh"],
    NDict = dh_tree:add(Path, dh_tree:new()),
    ?assertEqual(true, dh_tree:is_member(Path, NDict)).

testA3([]) ->
    Path = ["bleh", "blah", "bloh"],
    Dict = dh_tree:add(Path, dh_tree:new()),
    IsMember = dh_tree:is_member(["bleh", "blah"], Dict),
    ?assertEqual(true, IsMember).

testA4([]) ->
    Path = ["bleh", "blah", "bloh"],
    Dict = dh_tree:add(Path, dh_tree:new()),
    NDict = dh_tree:delete(["bleh", "blah"], Dict),
    IsMember = dh_tree:is_member(Path, NDict),
    ?assertEqual(true, IsMember).

testA5([]) ->
    Path = ["bleh", "blah", "bloh"],
    Dict = dh_tree:add(Path, dh_tree:new()),
    NDict = dh_tree:delete(Path, Dict),
    IsMember = dh_tree:is_member(Path, NDict),
    ?assertEqual(false, IsMember).

testB1([]) ->
    Path1 = ["bleh", "blah", "bloh"],
    Path2 = ["blooh", "blerp", "blop"],
    Dict = dh_tree:new(),
    NDict = dh_tree:add(Path2, Dict),
    IsMember = dh_tree:is_member(Path1, NDict),
    ?assertEqual(false, IsMember).

testB2([]) ->
    Path1 = ["bleh", "blah", "bloh"],
    Path2 = ["blooh", "blerp", "blop"],
    NDict = dh_tree:add(Path1, dh_tree:new()),
    NDict2 = dh_tree:add(Path2, NDict),
    ?assertEqual(true, dh_tree:is_member(Path1, NDict2)).

testB3([]) ->
    Path1 = ["bleh", "blah", "bloh"],
    Path2 = ["blooh", "blerp", "blop"],
    NDict = dh_tree:add(Path1, dh_tree:new()),
    NDict2 = dh_tree:add(Path2, NDict),
    IsMember = dh_tree:is_member(["bleh", "blah"], NDict2),
    ?assertEqual(true, IsMember).

testB4([]) ->
    Path1 = ["bleh", "blah", "bloh"],
    Path2 = ["blooh", "blerp", "blop"],
    Dict = dh_tree:add(Path1, dh_tree:new()),
    NDict2 = dh_tree:add(Path2, Dict),
    NDict3 = dh_tree:delete(["bleh", "blah"], NDict2),
    IsMember = dh_tree:is_member(Path1, NDict3),
    ?assertEqual(true, IsMember).

testB5([]) ->
    Path1 = ["bleh", "blah", "bloh"],
    Path2 = ["blooh", "blerp", "blop"],
    Dict = dh_tree:add(Path1, dh_tree:new()),
    NDict2 = dh_tree:add(Path2, Dict),
    NDict3 = dh_tree:delete(Path1, NDict2),
    IsMember = dh_tree:is_member(Path1, NDict3),
    ?assertEqual(false, IsMember).

testB6([]) ->
    Path1  = ["bleh", "blah", "bloh"],
    Path1a = ["bleh", "blerph", "bloh"],
    Path1b = ["bleh", "blatterh", "bloh"],
    Path2  = ["blooh", "blerp", "blop"],
    Dict = dh_tree:add(Path1, dh_tree:new()),
    NDict2 = dh_tree:add(Path2, Dict),
    NDict3 = dh_tree:add(Path1a, NDict2),
    NDict4 = dh_tree:add(Path1b, NDict3),
    Segs = dh_tree:segments_below(["bleh"], NDict4),
    ?assertEqual(lists:sort(["blah", "blerph", "blatterh"]), lists:sort(Segs)).

unit_test_() ->
    Setup   = fun()  -> ok end,
    Cleanup = fun(_) -> ok end,
    SeriesA = [
               fun testA1/1,
               fun testA2/1,
               fun testA3/1,
               fun testA4/1,
               fun testA5/1
              ],

    SeriesB = [
               fun testB1/1,
               fun testB2/1,
               fun testB3/1,
               fun testB4/1,
               fun testB5/1,
               fun testB6/1
              ],


    {setup, Setup, Cleanup,
     [{with, [], SeriesA},
      {with, [], SeriesB}]
    }.
