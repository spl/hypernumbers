%%% -*- mode: erlang -*-
-module(~s).
-compile(export_all).

-include_lib("hypernumbers/include/hypernumbers.hrl").
-include_lib("hypernumbers/include/spriki.hrl").
-include("ct.hrl").

-include(~p).

init_per_suite(Config) ->
    Init = fun(S) ->
                   reset_perms(S),
                   hn_db_api:wait_for_dirty(S)
           end,
    [Init(S) || S <- sites()], 
    testsys:restore(~p, ~p),
    actions(),
    timer:sleep(2000),
    [hn_db_api:wait_for_dirty(S) || S <- sites()], 
    Config.

reset_perms(S) ->
    auth_srv:clear_all_perms_DEBUG(S),

    % the home page
    auth_srv:add_controls(S, [{user, "*"}, {group, "*"}],
                      ["[**]"],[read, write],
                      "_global/spreadsheet", ["_global/spreadsheet", "_global/pagebuilder"]),

    auth_srv:add_controls(S, [{user, "*"}, {group, "*"}],
                      [],[read, write],
                      "_global/spreadsheet", ["_global/spreadsheet", "_global/pagebuilder"]).

end_per_suite(_Config) ->
    ok.

init_per_testcase(_TestCase, Config) -> Config.
end_per_testcase(_TestCase, _Config) -> ok.

get_val(Ref) ->
    case hn_db_api:read_attributes(Ref#refX{site=~p},["value"]) of
        [{_Ref, {"value", Val}}]           -> Val; 
        _Else                              -> "" 
    end.

all() ->
    [~s].

~s
