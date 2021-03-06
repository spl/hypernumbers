%%%-----------------------------------------------------------------------------
%%% File        : http_post_test_suite.erl
%%% Author      : Gordon Guthrie <gordon@vixo.com>
%%% Description : tests the general post security
%%%
%%% Created     : 31st March 2013 by Gordon Guthrie
%%%-----------------------------------------------------------------------------
-module(http_post_test_SUITE).

%% Note: This directive should only be used in test suites.
-compile(export_all).

-include("test_server.hrl").

-define(SITE, "http://tests.hypernumbers.dev:9000").

-define(test(Name, Path, Body, Expected, Status),
        Name(_Config) ->
               URL  = ?SITE ++ Path,
               Fn = case Status of
                        loggedinjson          ->
                            post_logged_in_TEST;
                        loggedinjsonnotadmin  ->
                            post_logged_in_notadmin_TEST;
                        loggedoutjson         ->
                            post_logged_out_TEST
                    end,
               Got = test:Fn(URL, Body),
               case Expected of
                   Got    -> {test, ok};
                   _Other -> io:format("EXPECTED:~n    ~p~nGOT:~n    ~p~n",
                                       [Expected, Got]),
                             exit("FAIL: Mismatch in " ++ atom_to_list(Name)
                                  ++ " of " ++ atom_to_list(?MODULE))
               end).

%% callbacks
init_per_suite(Config)               -> Config.
end_per_suite(_Config)               -> ok.
init_per_testcase(_TestCase, Config) -> Config.
end_per_testcase(_TestCase, _Config) -> ok.

read_config(Key) ->
    Root                   = code:lib_dir(hypernumbers)++"/../../",
    {ok, [Config]}         = file:consult([Root, "/var/", "sys.config"]),
    {hypernumbers, HNConf} = lists:keyfind(hypernumbers, 1, Config),
    {Key, Val}             = lists:keyfind(Key, 1, HNConf),
    Val.

%% tests to run
all2()->
    [
    ].

all() ->
    [
     % mark
     post_mark1a,
     post_mark2a,
     post_mark1b,
     post_mark2b,
     post_mark1c,
     post_mark2c,
     post_mark1d,
     post_mark2d,
     post_mark1e,
     post_mark2e,

     % jserr
     post_jserr1a,
     post_jserr2a,
     post_jserr1b,
     post_jserr2b,
     post_jserr1c,
     post_jserr2c,
     post_jserr1d,
     post_jserr2d,
     post_jserr1e,
     post_jserr2e,

     % loading templates
     post_loadtemplate1a,
     post_loadtemplate2a,
     post_loadtemplate1b,
     post_loadtemplate2b,
     post_loadtemplate1c,
     post_loadtemplate2c,
     post_loadtemplate1d,
     post_loadtemplate2d,
     post_loadtemplate1e,
     post_loadtemplate2e,

     % drag and drop
     post_drag_and_drop1a,
     post_drag_and_drop2a,
     post_drag_and_drop1b,
     post_drag_and_drop2b,
     post_drag_and_drop1c,
     post_drag_and_drop2c,
     post_drag_and_drop1d,
     post_drag_and_drop2d,
     post_drag_and_drop1e,
     post_drag_and_drop2e,

     % inserts
     post_insert1a,
     post_insert2a,
     post_insert1b,
     post_insert2b,
     post_insert1c,
     post_insert2c,
     post_insert1d,
     post_insert2d,
     post_insert1e,
     post_insert2e,
     post_insert1f,
     post_insert2f,
     post_insert1g,
     post_insert2g,
     post_insert1h,
     post_insert2h,
     post_insert1i,
     post_insert2i,
     post_insert1j,
     post_insert2j,
     post_insert1k,
     post_insert2k,
     post_insert1l,
     post_insert2l,
     post_insert1m,
     post_insert2m,
     post_insert1n,
     post_insert2n,
     post_insert1o,
     post_insert2o,
     post_insert1p,
     post_insert2p,

     % deletes
     post_delete1a,
     post_delete2a,
     post_delete1b,
     post_delete2b,
     post_delete1c,
     post_delete2c,
     post_delete1d,
     post_delete2d,
     post_delete1e,
     post_delete2e,
     post_delete1f,
     post_delete2f,
     post_delete1g,
     post_delete2g,
     post_delete1h,
     post_delete2h,
     post_delete1i,
     post_delete2i,

     % 3 kinds of copy
     post_copy1a,
     post_copy2a,
     post_copy1b,
     post_copy2b,
     post_copy1c,
     post_copy2c,
     post_copy1d,
     post_copy2d,
     post_copy1e,
     post_copy2e,
     post_copy1f,
     post_copy2f,
     post_copy1g,
     post_copy2g,
     post_copy1h,
     post_copy2h,
     post_copy1i,
     post_copy2i,
     post_copy1j,
     post_copy2j,
     post_copy1k,
     post_copy2k,
     post_copy1l,
     post_copy2l,
     post_copy1m,
     post_copy2m,
     post_copy1n,
     post_copy2n,
     post_copy1o,
     post_copy2o,
     post_copy1p,
     post_copy2p,
     post_copy1q,
     post_copy2q,
     post_copy1r,
     post_copy2r,
     post_copy1s,
     post_copy2s,
     post_copy1t,
     post_copy2t,

     post_copystyle1a,
     post_copystyle2a,
     post_copystyle1b,
     post_copystyle2b,
     post_copystyle1c,
     post_copystyle2c,
     post_copystyle1d,
     post_copystyle2d,
     post_copystyle1e,
     post_copystyle2e,
     post_copystyle1f,
     post_copystyle2f,
     post_copystyle1g,
     post_copystyle2g,
     post_copystyle1h,
     post_copystyle2h,
     post_copystyle1i,
     post_copystyle2i,
     post_copystyle1j,
     post_copystyle2j,
     post_copystyle1k,
     post_copystyle2k,
     post_copystyle1l,
     post_copystyle2l,
     post_copystyle1m,
     post_copystyle2m,
     post_copystyle1n,
     post_copystyle2n,
     post_copystyle1o,
     post_copystyle2o,
     post_copystyle1p,
     post_copystyle2p,
     post_copystyle1q,
     post_copystyle2q,
     post_copystyle1r,
     post_copystyle2r,
     post_copystyle1s,
     post_copystyle2s,
     post_copystyle1t,
     post_copystyle2t,

     post_copyvalue1a,
     post_copyvalue2a,
     post_copyvalue1b,
     post_copyvalue2b,
     post_copyvalue1c,
     post_copyvalue2c,
     post_copyvalue1d,
     post_copyvalue2d,
     post_copyvalue1e,
     post_copyvalue2e,
     post_copyvalue1f,
     post_copyvalue2f,
     post_copyvalue1g,
     post_copyvalue2g,
     post_copyvalue1h,
     post_copyvalue2h,
     post_copyvalue1i,
     post_copyvalue2i,
     post_copyvalue1j,
     post_copyvalue2j,
     post_copyvalue1k,
     post_copyvalue2k,
     post_copyvalue1l,
     post_copyvalue2l,
     post_copyvalue1m,
     post_copyvalue2m,
     post_copyvalue1n,
     post_copyvalue2n,
     post_copyvalue1o,
     post_copyvalue2o,
     post_copyvalue1p,
     post_copyvalue2p,
     post_copyvalue1q,
     post_copyvalue2q,
     post_copyvalue1r,
     post_copyvalue2r,
     post_copyvalue1s,
     post_copyvalue2s,
     post_copyvalue1t,
     post_copyvalue2t,

     % inline
     post_inline1a,
     post_inline2a,
     post_inline1b,
     post_inline2b,
     post_inline1c,
     post_inline2c,
     post_inline1d,
     post_inline2d,
     post_inline1e,
     post_inline2e,

     % inline
     post_inlineclear1a,
     post_inlineclear2a,
     post_inlineclear1b,
     post_inlineclear2b,
     post_inlineclear1c,
     post_inlineclear2c,
     post_inlineclear1d,
     post_inlineclear2d,
     post_inlineclear1e,
     post_inlineclear2e,

     % forms
     post_form1a,
     post_form2a,
     post_form1b,
     post_form2b,
     post_form1c,
     post_form2c,
     post_form1d,
     post_form2d,
     post_form1e,
     post_form2e,

     % webcontrols
     post_webcontrol1a,
     post_webcontrol2a,
     post_webcontrol1b,
     post_webcontrol2b,
     post_webcontrol1c,
     post_webcontrol2c,
     post_webcontrol1d,
     post_webcontrol2d,
     post_webcontrol1e,
     post_webcontrol2e,

     % reverts
     post_revert1a,
     post_revert2a,
     post_revert1b,
     post_revert2b,
     post_revert1c,
     post_revert2c,
     post_revert1d,
     post_revert2d,
     post_revert1e,
     post_revert2e,

     % setting the default view
     post_default_view1a,
     post_default_view2a,
     post_default_view1b,
     post_default_view2b,
     post_default_view1c,
     post_default_view2c,
     post_default_view1d,
     post_default_view2d,
     post_default_view1e,
     post_default_view2e,

     % setting other aspects of the view
     post_set_view1a,
     post_set_view2a,
     post_set_view1b,
     post_set_view2b,
     post_set_view1c,
     post_set_view2c,
     post_set_view1d,
     post_set_view2d,
     post_set_view1e,
     post_set_view2e,

     % save pages as templates
     post_save_template1a,
     post_save_template2a,
     post_save_template3a,
     post_save_template1b,
     post_save_template2b,
     post_save_template3b,
     post_save_template1c,
     post_save_template2c,
     post_save_template3c,
     post_save_template1d,
     post_save_template2d,
     post_save_template3d,
     post_save_template1e,
     post_save_template2e,
     post_save_template3e,

     % adding groups
     post_add_group1a,
     post_add_group2a,
     post_add_group3a,
     post_add_group1b,
     post_add_group2b,
     post_add_group3b,
     post_add_group1c,
     post_add_group2c,
     post_add_group3c,
     post_add_group1d,
     post_add_group2d,
     post_add_group3d,
     post_add_group1e,
     post_add_group2e,
     post_add_group3e,

     % add users
     post_add_user1a,
     post_add_user2a,
     post_add_user3a,
     post_add_user1b,
     post_add_user2b,
     post_add_user3b,
     post_add_user1c,
     post_add_user2c,
     post_add_user3c,
     post_add_user1d,
     post_add_user2d,
     post_add_user3d,
     post_add_user1e,
     post_add_user2e,
     post_add_user3e,

     % invite users
     post_invite_user1a,
     post_invite_user2a,
     post_invite_user3a,
     post_invite_user1b,
     post_invite_user2b,
     post_invite_user3b,
     post_invite_user1c,
     post_invite_user2c,
     post_invite_user3c,
     post_invite_user1d,
     post_invite_user2d,
     post_invite_user3d,
     post_invite_user1e,
     post_invite_user2e,
     post_invite_user3e

    ].

%% Test cases starts here.
%%------------------------------------------------------------------------------
% mark
?test(post_mark1a, "/some/page/a1", "{\"mark\": \"leper face\"}", 200, loggedinjson).
?test(post_mark2a, "/some/page/a1", "{\"mark\": \"leper face\"}", 401, loggedoutjson).

?test(post_mark1b, "/some/page/a1:b5", "{\"mark\": \"leper face\"}", 200, loggedinjson).
?test(post_mark2b, "/some/page/a1:b5", "{\"mark\": \"leper face\"}", 401, loggedoutjson).

?test(post_mark1c, "/some/page/c:d", "{\"mark\": \"leper face\"}", 200, loggedinjson).
?test(post_mark2c, "/some/page/c:d", "{\"mark\": \"leper face\"}", 401, loggedoutjson).

?test(post_mark1d, "/some/page/10:11", "{\"mark\": \"leper face\"}", 200, loggedinjson).
?test(post_mark2d, "/some/page/10:11", "{\"mark\": \"leper face\"}", 401, loggedoutjson).

?test(post_mark1e, "/some/page/", "{\"mark\": \"leper face\"}", 200, loggedinjson).
?test(post_mark2e, "/some/page/", "{\"mark\": \"leper face\"}", 401, loggedoutjson).

-define(JSERR, "{
        \"jserr\": {
            \"msg\": \"Msg\",
            \"cookies\": \"cookie\",
            \"pageurl\": \"http://example.com\",
            \"lineno\": \"1234\",
            \"errorfileurl\": \"http://example.com/javascript.js\"
        }
}").
% jserror
?test(post_jserr1a, "/some/page/a1", ?JSERR, 200, loggedinjson).
?test(post_jserr2a, "/some/page/a1", ?JSERR, 200, loggedoutjson).

?test(post_jserr1b, "/some/page/a1:b2", ?JSERR, 200, loggedinjson).
?test(post_jserr2b, "/some/page/a1:b2", ?JSERR, 200, loggedoutjson).

?test(post_jserr1c, "/some/page/c:d", ?JSERR, 200, loggedinjson).
?test(post_jserr2c, "/some/page/c:d", ?JSERR, 200, loggedoutjson).

?test(post_jserr1d, "/some/page/10:11", ?JSERR, 200, loggedinjson).
?test(post_jserr2d, "/some/page/10:11", ?JSERR, 200, loggedoutjson).

?test(post_jserr1e, "/some/page/", ?JSERR, 200, loggedinjson).
?test(post_jserr2e, "/some/page/", ?JSERR, 200, loggedoutjson).

% load template
-define(LOADTEMPLATE, "{\"load_template\":{\"name\":\"blank\"}}").
?test(post_loadtemplate1a, "/some/page/a1", ?LOADTEMPLATE, 401, loggedinjson).
?test(post_loadtemplate2a, "/some/page/a1", ?LOADTEMPLATE, 401, loggedoutjson).

?test(post_loadtemplate1b, "/some/page/a1:b5", ?LOADTEMPLATE, 401, loggedinjson).
?test(post_loadtemplate2b, "/some/page/a1:b5", ?LOADTEMPLATE, 401, loggedoutjson).

?test(post_loadtemplate1c, "/some/page/c:d", ?LOADTEMPLATE, 401, loggedinjson).
?test(post_loadtemplate2c, "/some/page/c:d", ?LOADTEMPLATE, 401, loggedoutjson).

?test(post_loadtemplate1d, "/some/page/10:11", ?LOADTEMPLATE, 401, loggedinjson).
?test(post_loadtemplate2d, "/some/page/10:11", ?LOADTEMPLATE, 401, loggedoutjson).

?test(post_loadtemplate1e, "/some/page/", ?LOADTEMPLATE, 200, loggedinjson).
?test(post_loadtemplate2e, "/some/page/", ?LOADTEMPLATE, 401, loggedoutjson).

% drag and drop
-define(DRAG, "{\"drag\":{\"range\":\"A6:A6\"}}").
?test(post_drag_and_drop1a, "/some/page/a5", ?DRAG, 200, loggedinjson).
?test(post_drag_and_drop2a, "/some/page/a5", ?DRAG, 401, loggedoutjson).

?test(post_drag_and_drop1b, "/some/page/a5:b5", ?DRAG, 401, loggedinjson).
?test(post_drag_and_drop2b, "/some/page/a5:b5", ?DRAG, 401, loggedoutjson).

?test(post_drag_and_drop1c, "/some/page/c:d", ?DRAG, 401, loggedinjson).
?test(post_drag_and_drop2c, "/some/page/c:d", ?DRAG, 401, loggedoutjson).

?test(post_drag_and_drop1d, "/some/page/10:11", ?DRAG, 401, loggedinjson).
?test(post_drag_and_drop2d, "/some/page/10:11", ?DRAG, 401, loggedoutjson).

?test(post_drag_and_drop1e, "/some/page/", ?DRAG, 401, loggedinjson).
?test(post_drag_and_drop2e, "/some/page/", ?DRAG, 401, loggedoutjson).

% insert stuff
-define(INSERTa, "{\"insert\":\"after\"}").
-define(INSERTb, "{\"insert\":\"before\"}").
-define(INSERTc, "{\"insert\":\"horizontal\"}").
-define(INSERTd, "{\"insert\":\"vertical\"}").

% cells
?test(post_insert1a, "/some/page/a5", ?INSERTa, 200, loggedinjson).
?test(post_insert2a, "/some/page/a5", ?INSERTa, 401, loggedoutjson).

?test(post_insert1b, "/some/page/a5", ?INSERTb, 200, loggedinjson).
?test(post_insert2b, "/some/page/a5", ?INSERTb, 401, loggedoutjson).

?test(post_insert1c, "/some/page/a5", ?INSERTc, 200, loggedinjson).
?test(post_insert2c, "/some/page/a5", ?INSERTc, 401, loggedoutjson).

?test(post_insert1d, "/some/page/a5", ?INSERTd, 200, loggedinjson).
?test(post_insert2d, "/some/page/a5", ?INSERTd, 401, loggedoutjson).

% ranges
?test(post_insert1e, "/some/page/a5:b6", ?INSERTa, 200, loggedinjson).
?test(post_insert2e, "/some/page/a5:b6", ?INSERTa, 401, loggedoutjson).

?test(post_insert1f, "/some/page/a5:b6", ?INSERTb, 200, loggedinjson).
?test(post_insert2f, "/some/page/a5:b6", ?INSERTb, 401, loggedoutjson).

?test(post_insert1g, "/some/page/a5:b6", ?INSERTc, 200, loggedinjson).
?test(post_insert2g, "/some/page/a5:b6", ?INSERTc, 401, loggedoutjson).

?test(post_insert1h, "/some/page/a5:b6", ?INSERTd, 200, loggedinjson).
?test(post_insert2h, "/some/page/a5:b6", ?INSERTd, 401, loggedoutjson).

% columns
?test(post_insert1i, "/some/page/b:e", ?INSERTa, 200, loggedinjson).
?test(post_insert2i, "/some/page/b:e", ?INSERTa, 401, loggedoutjson).

?test(post_insert1j, "/some/page/b:e", ?INSERTb, 200, loggedinjson).
?test(post_insert2j, "/some/page/b:e", ?INSERTb, 401, loggedoutjson).

?test(post_insert1k, "/some/page/b:e", ?INSERTc, 401, loggedinjson).
?test(post_insert2k, "/some/page/b:e", ?INSERTc, 401, loggedoutjson).

?test(post_insert1l, "/some/page/b:e", ?INSERTd, 401, loggedinjson).
?test(post_insert2l, "/some/page/b:e", ?INSERTd, 401, loggedoutjson).

% rows
?test(post_insert1m, "/some/page/6:8", ?INSERTa, 200, loggedinjson).
?test(post_insert2m, "/some/page/6:8", ?INSERTa, 401, loggedoutjson).

?test(post_insert1n, "/some/page/6:8", ?INSERTb, 200, loggedinjson).
?test(post_insert2n, "/some/page/6:8", ?INSERTb, 401, loggedoutjson).

?test(post_insert1o, "/some/page/6:8", ?INSERTc, 401, loggedinjson).
?test(post_insert2o, "/some/page/6:8", ?INSERTc, 401, loggedoutjson).

?test(post_insert1p, "/some/page/6:8", ?INSERTd, 401, loggedinjson).
?test(post_insert2p, "/some/page/6:8", ?INSERTd, 401, loggedoutjson).

% try page deletes
?test(post_insert1q, "/some/page/", ?INSERTd, 401, loggedinjson).
?test(post_insert2q, "/some/page/", ?INSERTd, 401, loggedoutjson).


% delete stuff
-define(DELETEa, "{\"delete\":\"all\"}").
-define(DELETEb, "{\"delete\":\"horizontal\"}").
-define(DELETEc, "{\"delete\":\"vertical\"}").

% cells
?test(post_delete1a, "/some/page/a5", ?DELETEa, 200, loggedinjson).
?test(post_delete2a, "/some/page/a5", ?DELETEa, 401, loggedoutjson).

?test(post_delete1b, "/some/page/a5", ?DELETEb, 200, loggedinjson).
?test(post_delete2b, "/some/page/a5", ?DELETEb, 401, loggedoutjson).

?test(post_delete1c, "/some/page/a5", ?DELETEc, 200, loggedinjson).
?test(post_delete2c, "/some/page/a5", ?DELETEc, 401, loggedoutjson).

% ranges
?test(post_delete1d, "/some/page/a5:b6", ?DELETEa, 200, loggedinjson).
?test(post_delete2d, "/some/page/a5:b6", ?DELETEa, 401, loggedoutjson).

?test(post_delete1e, "/some/page/a5:b6", ?DELETEb, 200, loggedinjson).
?test(post_delete2e, "/some/page/a5:b6", ?DELETEb, 401, loggedoutjson).

?test(post_delete1f, "/some/page/a5:b6", ?DELETEc, 200, loggedinjson).
?test(post_delete2f, "/some/page/a5:b6", ?DELETEc, 401, loggedoutjson).

% columns
?test(post_delete1g, "/some/page/b:e", ?DELETEa, 200, loggedinjson).
?test(post_delete2g, "/some/page/b:e", ?DELETEa, 401, loggedoutjson).

?test(post_delete1h, "/some/page/b:e", ?DELETEb, 401, loggedinjson).
?test(post_delete2h, "/some/page/b:e", ?DELETEb, 401, loggedoutjson).

?test(post_delete1i, "/some/page/b:e", ?DELETEc, 401, loggedinjson).
?test(post_delete2i, "/some/page/b:e", ?DELETEc, 401, loggedoutjson).

% rows
?test(post_delete1m, "/some/page/6:8", ?DELETEa, 200, loggedinjson).
?test(post_delete2m, "/some/page/6:8", ?DELETEa, 401, loggedoutjson).

?test(post_delete1n, "/some/page/6:8", ?DELETEb, 401, loggedinjson).
?test(post_delete2n, "/some/page/6:8", ?DELETEb, 401, loggedoutjson).

?test(post_delete1o, "/some/page/6:8", ?DELETEc, 401, loggedinjson).
?test(post_delete2o, "/some/page/6:8", ?DELETEc, 401, loggedoutjson).

-define(COPYa, "{\"copy\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/A1:A1\"}}").
-define(COPYb, "{\"copy\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/A1:A2\"}}").
-define(COPYc, "{\"copy\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/g:g\"}}").
-define(COPYd, "{\"copy\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/10:10\"}}").
?test(post_copy1a, "/some/page/B4", ?COPYa, 200, loggedinjson).
?test(post_copy2a, "/some/page/B4", ?COPYa, 401, loggedoutjson).

?test(post_copy1b, "/some/page/B4:b5", ?COPYa, 200, loggedinjson).
?test(post_copy2b, "/some/page/B4:b5", ?COPYa, 401, loggedoutjson).

?test(post_copy1c, "/some/page/B:c", ?COPYa, 401, loggedinjson).
?test(post_copy2c, "/some/page/B:c", ?COPYa, 401, loggedoutjson).

?test(post_copy1d, "/some/page/3:4", ?COPYa, 401, loggedinjson).
?test(post_copy2d, "/some/page/3:4", ?COPYa, 401, loggedoutjson).

?test(post_copy1e, "/some/page/", ?COPYa, 401, loggedinjson).
?test(post_copy2e, "/some/page/", ?COPYa, 401, loggedoutjson).

?test(post_copy1f, "/some/page/B4", ?COPYb, 200, loggedinjson).
?test(post_copy2f, "/some/page/B4", ?COPYb, 401, loggedoutjson).

?test(post_copy1g, "/some/page/B4:b5", ?COPYb, 200, loggedinjson).
?test(post_copy2g, "/some/page/B4:b5", ?COPYb, 401, loggedoutjson).

?test(post_copy1h, "/some/page/B:c", ?COPYb, 401, loggedinjson).
?test(post_copy2h, "/some/page/B:c", ?COPYb, 401, loggedoutjson).

?test(post_copy1i, "/some/page/3:4", ?COPYb, 401, loggedinjson).
?test(post_copy2i, "/some/page/3:4", ?COPYb, 401, loggedoutjson).

?test(post_copy1j, "/some/page/", ?COPYb, 401, loggedinjson).
?test(post_copy2j, "/some/page/", ?COPYb, 401, loggedoutjson).

?test(post_copy1k, "/some/page/B4", ?COPYc, 401, loggedinjson).
?test(post_copy2k, "/some/page/B4", ?COPYc, 401, loggedoutjson).

?test(post_copy1l, "/some/page/B4:b5", ?COPYc, 401, loggedinjson).
?test(post_copy2l, "/some/page/B4:b5", ?COPYc, 401, loggedoutjson).

?test(post_copy1m, "/some/page/B:c", ?COPYc, 401, loggedinjson).
?test(post_copy2m, "/some/page/B:c", ?COPYc, 401, loggedoutjson).

?test(post_copy1n, "/some/page/3:4", ?COPYc, 401, loggedinjson).
?test(post_copy2n, "/some/page/3:4", ?COPYc, 401, loggedoutjson).

?test(post_copy1o, "/some/page/", ?COPYc, 401, loggedinjson).
?test(post_copy2o, "/some/page/", ?COPYc, 401, loggedoutjson).

?test(post_copy1p, "/some/page/B4", ?COPYd, 401, loggedinjson).
?test(post_copy2p, "/some/page/B4", ?COPYd, 401, loggedoutjson).

?test(post_copy1q, "/some/page/B4:b5", ?COPYd, 401, loggedinjson).
?test(post_copy2q, "/some/page/B4:b5", ?COPYd, 401, loggedoutjson).

?test(post_copy1r, "/some/page/B:c", ?COPYd, 401, loggedinjson).
?test(post_copy2r, "/some/page/B:c", ?COPYd, 401, loggedoutjson).

?test(post_copy1s, "/some/page/3:4", ?COPYd, 401, loggedinjson).
?test(post_copy2s, "/some/page/3:4", ?COPYd, 401, loggedoutjson).

?test(post_copy1t, "/some/page/", ?COPYd, 401, loggedinjson).
?test(post_copy2t, "/some/page/", ?COPYd, 401, loggedoutjson).

-define(COPYSTYLEa, "{\"copystyle\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/A1:A1\"}}").
-define(COPYSTYLEb, "{\"copystyle\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/A1:A2\"}}").
-define(COPYSTYLEc, "{\"copystyle\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/g:g\"}}").
-define(COPYSTYLEd, "{\"copystyle\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/10:10\"}}").
?test(post_copystyle1a, "/some/page/B4", ?COPYSTYLEa, 200, loggedinjson).
?test(post_copystyle2a, "/some/page/B4", ?COPYSTYLEa, 401, loggedoutjson).

?test(post_copystyle1b, "/some/page/B4:b5", ?COPYSTYLEa, 200, loggedinjson).
?test(post_copystyle2b, "/some/page/B4:b5", ?COPYSTYLEa, 401, loggedoutjson).

?test(post_copystyle1c, "/some/page/B:c", ?COPYSTYLEa, 401, loggedinjson).
?test(post_copystyle2c, "/some/page/B:c", ?COPYSTYLEa, 401, loggedoutjson).

?test(post_copystyle1d, "/some/page/3:4", ?COPYSTYLEa, 401, loggedinjson).
?test(post_copystyle2d, "/some/page/3:4", ?COPYSTYLEa, 401, loggedoutjson).

?test(post_copystyle1e, "/some/page/", ?COPYSTYLEa, 401, loggedinjson).
?test(post_copystyle2e, "/some/page/", ?COPYSTYLEa, 401, loggedoutjson).

?test(post_copystyle1f, "/some/page/B4", ?COPYSTYLEb, 200, loggedinjson).
?test(post_copystyle2f, "/some/page/B4", ?COPYSTYLEb, 401, loggedoutjson).

?test(post_copystyle1g, "/some/page/B4:b5", ?COPYSTYLEb, 200, loggedinjson).
?test(post_copystyle2g, "/some/page/B4:b5", ?COPYSTYLEb, 401, loggedoutjson).

?test(post_copystyle1h, "/some/page/B:c", ?COPYSTYLEb, 401, loggedinjson).
?test(post_copystyle2h, "/some/page/B:c", ?COPYSTYLEb, 401, loggedoutjson).

?test(post_copystyle1i, "/some/page/3:4", ?COPYSTYLEb, 401, loggedinjson).
?test(post_copystyle2i, "/some/page/3:4", ?COPYSTYLEb, 401, loggedoutjson).

?test(post_copystyle1j, "/some/page/", ?COPYSTYLEb, 401, loggedinjson).
?test(post_copystyle2j, "/some/page/", ?COPYSTYLEb, 401, loggedoutjson).

?test(post_copystyle1k, "/some/page/B4", ?COPYSTYLEc, 401, loggedinjson).
?test(post_copystyle2k, "/some/page/B4", ?COPYSTYLEc, 401, loggedoutjson).

?test(post_copystyle1l, "/some/page/B4:b5", ?COPYSTYLEc, 401, loggedinjson).
?test(post_copystyle2l, "/some/page/B4:b5", ?COPYSTYLEc, 401, loggedoutjson).

?test(post_copystyle1m, "/some/page/B:c", ?COPYSTYLEc, 401, loggedinjson).
?test(post_copystyle2m, "/some/page/B:c", ?COPYSTYLEc, 401, loggedoutjson).

?test(post_copystyle1n, "/some/page/3:4", ?COPYSTYLEc, 401, loggedinjson).
?test(post_copystyle2n, "/some/page/3:4", ?COPYSTYLEc, 401, loggedoutjson).

?test(post_copystyle1o, "/some/page/", ?COPYSTYLEc, 401, loggedinjson).
?test(post_copystyle2o, "/some/page/", ?COPYSTYLEc, 401, loggedoutjson).

?test(post_copystyle1p, "/some/page/B4", ?COPYSTYLEd, 401, loggedinjson).
?test(post_copystyle2p, "/some/page/B4", ?COPYSTYLEd, 401, loggedoutjson).

?test(post_copystyle1q, "/some/page/B4:b5", ?COPYSTYLEd, 401, loggedinjson).
?test(post_copystyle2q, "/some/page/B4:b5", ?COPYSTYLEd, 401, loggedoutjson).

?test(post_copystyle1r, "/some/page/B:c", ?COPYSTYLEd, 401, loggedinjson).
?test(post_copystyle2r, "/some/page/B:c", ?COPYSTYLEd, 401, loggedoutjson).

?test(post_copystyle1s, "/some/page/3:4", ?COPYSTYLEd, 401, loggedinjson).
?test(post_copystyle2s, "/some/page/3:4", ?COPYSTYLEd, 401, loggedoutjson).

?test(post_copystyle1t, "/some/page/", ?COPYSTYLEd, 401, loggedinjson).
?test(post_copystyle2t, "/some/page/", ?COPYSTYLEd, 401, loggedoutjson).

-define(COPYVALUEa, "{\"copyvalue\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/A1:A1\"}}").
-define(COPYVALUEb, "{\"copyvalue\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/A1:A2\"}}").
-define(COPYVALUEc, "{\"copyvalue\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/g:g\"}}").
-define(COPYVALUEd, "{\"copyvalue\":{\"src\":\"http://tests.hypernumbers.dev:9000/some/page/10:10\"}}").
?test(post_copyvalue1a, "/some/page/B4", ?COPYVALUEa, 200, loggedinjson).
?test(post_copyvalue2a, "/some/page/B4", ?COPYVALUEa, 401, loggedoutjson).

?test(post_copyvalue1b, "/some/page/B4:b5", ?COPYVALUEa, 200, loggedinjson).
?test(post_copyvalue2b, "/some/page/B4:b5", ?COPYVALUEa, 401, loggedoutjson).

?test(post_copyvalue1c, "/some/page/B:c", ?COPYVALUEa, 401, loggedinjson).
?test(post_copyvalue2c, "/some/page/B:c", ?COPYVALUEa, 401, loggedoutjson).

?test(post_copyvalue1d, "/some/page/3:4", ?COPYVALUEa, 401, loggedinjson).
?test(post_copyvalue2d, "/some/page/3:4", ?COPYVALUEa, 401, loggedoutjson).

?test(post_copyvalue1e, "/some/page/", ?COPYVALUEa, 401, loggedinjson).
?test(post_copyvalue2e, "/some/page/", ?COPYVALUEa, 401, loggedoutjson).

?test(post_copyvalue1f, "/some/page/B4", ?COPYVALUEb, 200, loggedinjson).
?test(post_copyvalue2f, "/some/page/B4", ?COPYVALUEb, 401, loggedoutjson).

?test(post_copyvalue1g, "/some/page/B4:b5", ?COPYVALUEb, 200, loggedinjson).
?test(post_copyvalue2g, "/some/page/B4:b5", ?COPYVALUEb, 401, loggedoutjson).

?test(post_copyvalue1h, "/some/page/B:c", ?COPYVALUEb, 401, loggedinjson).
?test(post_copyvalue2h, "/some/page/B:c", ?COPYVALUEb, 401, loggedoutjson).

?test(post_copyvalue1i, "/some/page/3:4", ?COPYVALUEb, 401, loggedinjson).
?test(post_copyvalue2i, "/some/page/3:4", ?COPYVALUEb, 401, loggedoutjson).

?test(post_copyvalue1j, "/some/page/", ?COPYVALUEb, 401, loggedinjson).
?test(post_copyvalue2j, "/some/page/", ?COPYVALUEb, 401, loggedoutjson).

?test(post_copyvalue1k, "/some/page/B4", ?COPYVALUEc, 401, loggedinjson).
?test(post_copyvalue2k, "/some/page/B4", ?COPYVALUEc, 401, loggedoutjson).

?test(post_copyvalue1l, "/some/page/B4:b5", ?COPYVALUEc, 401, loggedinjson).
?test(post_copyvalue2l, "/some/page/B4:b5", ?COPYVALUEc, 401, loggedoutjson).

?test(post_copyvalue1m, "/some/page/B:c", ?COPYVALUEc, 401, loggedinjson).
?test(post_copyvalue2m, "/some/page/B:c", ?COPYVALUEc, 401, loggedoutjson).

?test(post_copyvalue1n, "/some/page/3:4", ?COPYVALUEc, 401, loggedinjson).
?test(post_copyvalue2n, "/some/page/3:4", ?COPYVALUEc, 401, loggedoutjson).

?test(post_copyvalue1o, "/some/page/", ?COPYVALUEc, 401, loggedinjson).
?test(post_copyvalue2o, "/some/page/", ?COPYVALUEc, 401, loggedoutjson).

?test(post_copyvalue1p, "/some/page/B4", ?COPYVALUEd, 401, loggedinjson).
?test(post_copyvalue2p, "/some/page/B4", ?COPYVALUEd, 401, loggedoutjson).

?test(post_copyvalue1q, "/some/page/B4:b5", ?COPYVALUEd, 401, loggedinjson).
?test(post_copyvalue2q, "/some/page/B4:b5", ?COPYVALUEd, 401, loggedoutjson).

?test(post_copyvalue1r, "/some/page/B:c", ?COPYVALUEd, 401, loggedinjson).
?test(post_copyvalue2r, "/some/page/B:c", ?COPYVALUEd, 401, loggedoutjson).

?test(post_copyvalue1s, "/some/page/3:4", ?COPYVALUEd, 401, loggedinjson).
?test(post_copyvalue2s, "/some/page/3:4", ?COPYVALUEd, 401, loggedoutjson).

?test(post_copyvalue1t, "/some/page/", ?COPYVALUEd, 401, loggedinjson).
?test(post_copyvalue2t, "/some/page/", ?COPYVALUEd, 401, loggedoutjson).

%% inline won't work because there is no inline formula there
-define(INLINE, "{\"postinline\": {\"formula\": \"=1+2\"}}").
?test(post_inline1a, "/some/page/B4", ?INLINE, 403, loggedinjson).
?test(post_inline2a, "/some/page/B4", ?INLINE, 401, loggedoutjson).

?test(post_inline1b, "/some/page/B4:b5", ?INLINE, 401, loggedinjson).
?test(post_inline2b, "/some/page/B4:b5", ?INLINE, 401, loggedoutjson).

?test(post_inline1c, "/some/page/B:c", ?INLINE, 401, loggedinjson).
?test(post_inline2c, "/some/page/B:c", ?INLINE, 401, loggedoutjson).

?test(post_inline1d, "/some/page/3:4", ?INLINE, 401, loggedinjson).
?test(post_inline2d, "/some/page/3:4", ?INLINE, 401, loggedoutjson).

?test(post_inline1e, "/some/page/", ?INLINE, 401, loggedinjson).
?test(post_inline2e, "/some/page/", ?INLINE, 401, loggedoutjson).

%% inlineclear won't work because there is no inlineclear formula there
-define(INLINECLEAR, "{\"postinline\": {\"clear\": \"contents\"}}").
?test(post_inlineclear1a, "/some/page/B4", ?INLINECLEAR, 403, loggedinjson).
?test(post_inlineclear2a, "/some/page/B4", ?INLINECLEAR, 401, loggedoutjson).

?test(post_inlineclear1b, "/some/page/B4:b5", ?INLINECLEAR, 401, loggedinjson).
?test(post_inlineclear2b, "/some/page/B4:b5", ?INLINECLEAR, 401, loggedoutjson).

?test(post_inlineclear1c, "/some/page/B:c", ?INLINECLEAR, 401, loggedinjson).
?test(post_inlineclear2c, "/some/page/B:c", ?INLINECLEAR, 401, loggedoutjson).

?test(post_inlineclear1d, "/some/page/3:4", ?INLINECLEAR, 401, loggedinjson).
?test(post_inlineclear2d, "/some/page/3:4", ?INLINECLEAR, 401, loggedoutjson).

?test(post_inlineclear1e, "/some/page/", ?INLINECLEAR, 401, loggedinjson).
?test(post_inlineclear2e, "/some/page/", ?INLINECLEAR, 401, loggedoutjson).

-define(POSTFORM, "{\"postform\": {\"results\": \"./_replies/\", \"values\":" ++
        "[{\"label\":\"Question 1\", \"formula\": \"erk\"}]}}").
?test(post_form1a, "/some/page/B4", ?POSTFORM, 401, loggedinjson).
?test(post_form2a, "/some/page/B4", ?POSTFORM, 401, loggedoutjson).

?test(post_form1b, "/some/page/B4:b5", ?POSTFORM, 401, loggedinjson).
?test(post_form2b, "/some/page/B4:b5", ?POSTFORM, 401, loggedoutjson).

?test(post_form1c, "/some/page/B:c", ?POSTFORM, 401, loggedinjson).
?test(post_form2c, "/some/page/B:c", ?POSTFORM, 401, loggedoutjson).

?test(post_form1d, "/some/page/3:4", ?POSTFORM, 401, loggedinjson).
?test(post_form2d, "/some/page/3:4", ?POSTFORM, 401, loggedoutjson).

?test(post_form1e, "/some/page/", ?POSTFORM, 403, loggedinjson).
?test(post_form2e, "/some/page/", ?POSTFORM, 401, loggedoutjson).

-define(POSTWEBCONTROL, "{\"postwebcontrols\": {\"chaos\": [{\"leper\":\"face\"}]}}").
?test(post_webcontrol1a, "/some/page/B4", ?POSTWEBCONTROL, 500, loggedinjson).
?test(post_webcontrol2a, "/some/page/B4", ?POSTWEBCONTROL, 401, loggedoutjson).

?test(post_webcontrol1b, "/some/page/B4:b5", ?POSTWEBCONTROL, 401, loggedinjson).
?test(post_webcontrol2b, "/some/page/B4:b5", ?POSTWEBCONTROL, 401, loggedoutjson).

?test(post_webcontrol1c, "/some/page/B:c", ?POSTWEBCONTROL, 401, loggedinjson).
?test(post_webcontrol2c, "/some/page/B:c", ?POSTWEBCONTROL, 401, loggedoutjson).

?test(post_webcontrol1d, "/some/page/3:4", ?POSTWEBCONTROL, 401, loggedinjson).
?test(post_webcontrol2d, "/some/page/3:4", ?POSTWEBCONTROL, 401, loggedoutjson).

?test(post_webcontrol1e, "/some/page/", ?POSTWEBCONTROL, 401, loggedinjson).
?test(post_webcontrol2e, "/some/page/", ?POSTWEBCONTROL, 401, loggedoutjson).

-define(POSTREVERT, "{\"revert_to\": \"yardle\"}").
?test(post_revert1a, "/some/page/B4", ?POSTREVERT, 500, loggedinjson).
?test(post_revert2a, "/some/page/B4", ?POSTREVERT, 401, loggedoutjson).

?test(post_revert1b, "/some/page/B4:b5", ?POSTREVERT, 401, loggedinjson).
?test(post_revert2b, "/some/page/B4:b5", ?POSTREVERT, 401, loggedoutjson).

?test(post_revert1c, "/some/page/B:c", ?POSTREVERT, 401, loggedinjson).
?test(post_revert2c, "/some/page/B:c", ?POSTREVERT, 401, loggedoutjson).

?test(post_revert1d, "/some/page/3:4", ?POSTREVERT, 401, loggedinjson).
?test(post_revert2d, "/some/page/3:4", ?POSTREVERT, 401, loggedoutjson).

?test(post_revert1e, "/some/page/", ?POSTREVERT, 401, loggedinjson).
?test(post_revert2e, "/some/page/", ?POSTREVERT, 401, loggedoutjson).

-define(POSTDEFAULT_VIEW, "{\"default_view\": {\"view\": \"table\"}}").
?test(post_default_view1a, "/some/page/B4", ?POSTDEFAULT_VIEW, 401, loggedinjson).
?test(post_default_view2a, "/some/page/B4", ?POSTDEFAULT_VIEW, 401, loggedoutjson).

?test(post_default_view1b, "/some/page/B4:b5", ?POSTDEFAULT_VIEW, 401, loggedinjson).
?test(post_default_view2b, "/some/page/B4:b5", ?POSTDEFAULT_VIEW, 401, loggedoutjson).

?test(post_default_view1c, "/some/page/B:c", ?POSTDEFAULT_VIEW, 401, loggedinjson).
?test(post_default_view2c, "/some/page/B:c", ?POSTDEFAULT_VIEW, 401, loggedoutjson).

?test(post_default_view1d, "/some/page/3:4", ?POSTDEFAULT_VIEW, 401, loggedinjson).
?test(post_default_view2d, "/some/page/3:4", ?POSTDEFAULT_VIEW, 401, loggedoutjson).

?test(post_default_view1e, "/some/page/", ?POSTDEFAULT_VIEW, 200, loggedinjson).
?test(post_default_view2e, "/some/page/", ?POSTDEFAULT_VIEW, 401, loggedoutjson).

-define(POSTSET_VIEW, "{\"set_view\": {\"view\": \"table\", \"everyone\": false, \"groups\": [\"admin\"]}}").
?test(post_set_view1a, "/some/page/B4", ?POSTSET_VIEW, 401, loggedinjson).
?test(post_set_view2a, "/some/page/B4", ?POSTSET_VIEW, 401, loggedoutjson).

?test(post_set_view1b, "/some/page/B4:b5", ?POSTSET_VIEW, 401, loggedinjson).
?test(post_set_view2b, "/some/page/B4:b5", ?POSTSET_VIEW, 401, loggedoutjson).

?test(post_set_view1c, "/some/page/B:c", ?POSTSET_VIEW, 401, loggedinjson).
?test(post_set_view2c, "/some/page/B:c", ?POSTSET_VIEW, 401, loggedoutjson).

?test(post_set_view1d, "/some/page/3:4", ?POSTSET_VIEW, 401, loggedinjson).
?test(post_set_view2d, "/some/page/3:4", ?POSTSET_VIEW, 401, loggedoutjson).

?test(post_set_view1e, "/some/page/", ?POSTSET_VIEW, 200, loggedinjson).
?test(post_set_view2e, "/some/page/", ?POSTSET_VIEW, 401, loggedoutjson).

-define(POSTSAVE_TEMPLATE, "{\"save_template\": {\"name\": \"banjolele\"}}").
?test(post_save_template1a, "/some/page/B4", ?POSTSAVE_TEMPLATE, 401, loggedinjson).
?test(post_save_template2a, "/some/page/B4", ?POSTSAVE_TEMPLATE, 401, loggedoutjson).
?test(post_save_template3a, "/some/page/B4", ?POSTSAVE_TEMPLATE, 401, loggedinjsonnotadmin).

?test(post_save_template1b, "/some/page/B4:b5", ?POSTSAVE_TEMPLATE, 401, loggedinjson).
?test(post_save_template2b, "/some/page/B4:b5", ?POSTSAVE_TEMPLATE, 401, loggedoutjson).
?test(post_save_template3b, "/some/page/B4:b5", ?POSTSAVE_TEMPLATE, 401, loggedinjsonnotadmin).

?test(post_save_template1c, "/some/page/B:c", ?POSTSAVE_TEMPLATE, 401, loggedinjson).
?test(post_save_template2c, "/some/page/B:c", ?POSTSAVE_TEMPLATE, 401, loggedoutjson).
?test(post_save_template3c, "/some/page/B:c", ?POSTSAVE_TEMPLATE, 401, loggedinjsonnotadmin).

?test(post_save_template1d, "/some/page/3:4", ?POSTSAVE_TEMPLATE, 401, loggedinjson).
?test(post_save_template2d, "/some/page/3:4", ?POSTSAVE_TEMPLATE, 401, loggedoutjson).
?test(post_save_template3d, "/some/page/3:4", ?POSTSAVE_TEMPLATE, 401, loggedinjsonnotadmin).

?test(post_save_template1e, "/some/page/", ?POSTSAVE_TEMPLATE, 200, loggedinjson).
?test(post_save_template2e, "/some/page/", ?POSTSAVE_TEMPLATE, 401, loggedoutjson).
?test(post_save_template3e, "/some/page/", ?POSTSAVE_TEMPLATE, 401, loggedinjsonnotadmin).

-define(POSTADD_GROUP, "{\"add_group\": {\"views\": [\"spreadsheet\"], \"group\": \"bernie inn\"}}").
?test(post_add_group1a, "/some/page/B4", ?POSTADD_GROUP, 401, loggedinjson).
?test(post_add_group2a, "/some/page/B4", ?POSTADD_GROUP, 401, loggedoutjson).
?test(post_add_group3a, "/some/page/B4", ?POSTADD_GROUP, 401, loggedinjsonnotadmin).

?test(post_add_group1b, "/some/page/B4:b5", ?POSTADD_GROUP, 401, loggedinjson).
?test(post_add_group2b, "/some/page/B4:b5", ?POSTADD_GROUP, 401, loggedoutjson).
?test(post_add_group3b, "/some/page/B4:b5", ?POSTADD_GROUP, 401, loggedinjsonnotadmin).

?test(post_add_group1c, "/some/page/B:c", ?POSTADD_GROUP, 401, loggedinjson).
?test(post_add_group2c, "/some/page/B:c", ?POSTADD_GROUP, 401, loggedoutjson).
?test(post_add_group3c, "/some/page/B:c", ?POSTADD_GROUP, 401, loggedinjsonnotadmin).

?test(post_add_group1d, "/some/page/3:4", ?POSTADD_GROUP, 401, loggedinjson).
?test(post_add_group2d, "/some/page/3:4", ?POSTADD_GROUP, 401, loggedoutjson).
?test(post_add_group3d, "/some/page/3:4", ?POSTADD_GROUP, 401, loggedinjsonnotadmin).

?test(post_add_group1e, "/some/page/", ?POSTADD_GROUP, 200, loggedinjson).
?test(post_add_group2e, "/some/page/", ?POSTADD_GROUP, 401, loggedoutjson).
?test(post_add_group3e, "/some/page/", ?POSTADD_GROUP, 401, loggedinjsonnotadmin).

-define(POSTADD_USER, "{\"add_user\": {\"email\": \"yanko@example.com\", \"groups\": [\"berko\"], \"msg\": \"Hey, Black Jesus!\"}}").
?test(post_add_user1a, "/some/page/B4", ?POSTADD_USER, 401, loggedinjson).
?test(post_add_user2a, "/some/page/B4", ?POSTADD_USER, 401, loggedoutjson).
?test(post_add_user3a, "/some/page/B4", ?POSTADD_USER, 401, loggedinjsonnotadmin).

?test(post_add_user1b, "/some/page/B4:b5", ?POSTADD_USER, 401, loggedinjson).
?test(post_add_user2b, "/some/page/B4:b5", ?POSTADD_USER, 401, loggedoutjson).
?test(post_add_user3b, "/some/page/B4:b5", ?POSTADD_USER, 401, loggedinjsonnotadmin).

?test(post_add_user1c, "/some/page/B:c", ?POSTADD_USER, 401, loggedinjson).
?test(post_add_user2c, "/some/page/B:c", ?POSTADD_USER, 401, loggedoutjson).
?test(post_add_user3c, "/some/page/B:c", ?POSTADD_USER, 401, loggedinjsonnotadmin).

?test(post_add_user1d, "/some/page/3:4", ?POSTADD_USER, 401, loggedinjson).
?test(post_add_user2d, "/some/page/3:4", ?POSTADD_USER, 401, loggedoutjson).
?test(post_add_user3d, "/some/page/3:4", ?POSTADD_USER, 401, loggedinjsonnotadmin).

?test(post_add_user1e, "/some/page/", ?POSTADD_USER, 200, loggedinjson).
?test(post_add_user2e, "/some/page/", ?POSTADD_USER, 401, loggedoutjson).
?test(post_add_user3e, "/some/page/", ?POSTADD_USER, 401, loggedinjsonnotadmin).

-define(POSTINVITE_USER, "{\"invite_user\": {\"email\": \"yanko@example.com\", \"view\": \"spreadsheet\", \"msg\": \"Hey, Black Jesus!\"}}").
?test(post_invite_user1a, "/some/page/B4", ?POSTINVITE_USER, 401, loggedinjson).
?test(post_invite_user2a, "/some/page/B4", ?POSTINVITE_USER, 401, loggedoutjson).
?test(post_invite_user3a, "/some/page/B4", ?POSTINVITE_USER, 401, loggedinjsonnotadmin).

?test(post_invite_user1b, "/some/page/B4:b5", ?POSTINVITE_USER, 401, loggedinjson).
?test(post_invite_user2b, "/some/page/B4:b5", ?POSTINVITE_USER, 401, loggedoutjson).
?test(post_invite_user3b, "/some/page/B4:b5", ?POSTINVITE_USER, 401, loggedinjsonnotadmin).

?test(post_invite_user1c, "/some/page/B:c", ?POSTINVITE_USER, 401, loggedinjson).
?test(post_invite_user2c, "/some/page/B:c", ?POSTINVITE_USER, 401, loggedoutjson).
?test(post_invite_user3c, "/some/page/B:c", ?POSTINVITE_USER, 401, loggedinjsonnotadmin).

?test(post_invite_user1d, "/some/page/3:4", ?POSTINVITE_USER, 401, loggedinjson).
?test(post_invite_user2d, "/some/page/3:4", ?POSTINVITE_USER, 401, loggedoutjson).
?test(post_invite_user3d, "/some/page/3:4", ?POSTINVITE_USER, 401, loggedinjsonnotadmin).

?test(post_invite_user1e, "/some/page/", ?POSTINVITE_USER, 200, loggedinjson).
?test(post_invite_user2e, "/some/page/", ?POSTINVITE_USER, 401, loggedoutjson).
?test(post_invite_user3e, "/some/page/", ?POSTINVITE_USER, 200, loggedinjsonnotadmin).
