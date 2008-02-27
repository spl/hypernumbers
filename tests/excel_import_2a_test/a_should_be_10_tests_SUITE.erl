% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: a_should_be_10_tests.xls
% Generated on: Mon Feb 25 21:57:11 +0000 2008

-module(a_should_be_10_tests_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/a_should_be_10_tests.xls"),
    Fun =fun({{{sheet,Sheet},{row_index,RowIdx},{col_index,ColIdx}},Input}) ->
      io:format("Sheet is ~p RowIdx is ~p and ColIdx is ~p~n",[Sheet,RowIdx,ColIdx]),
      Data1 = case Input of
        {_,Data2}                                -> Data2;
        {_,number,Data2} when is_float(Data2)   -> float_to_list(Data2);
        {_,number,Data2} when is_integer(Data2) -> integer_to_list(Data2);
        {_,error,Error}                          -> Error;
        {_,boolean,true}                         -> "true";
        {_,boolean,false}                        -> "false"
      end,
      Path="/"++Sheet++"/",
      Cell=util2:make_b26(ColIdx+1)++integer_to_list(RowIdx+1),
      io:format("Cell is ~p~n",[Cell]),
      hn_post("http://127.0.0.1:9000",Path,Cell,Data1) end,
    lists:map(Fun,Data),
    io:format("in init_per_suite Data is ~p~n",[Data]),
    Config.
  
end_per_suite(_Config) ->
    production_boot:stop(),
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,a_should_be_10_tests_SUITE,{Sheet,Row,Col}).

%%% Helper functions.

hn_post(Site, Path, Cell, Data) ->
    Url=Site++Path++Cell,
    PostData = "action=create&value=" ++ yaws_api:url_encode(Data),
    Data2 = {Url, [], "text/plain", PostData},
    io:format("in hn_post Data is ~p~n",[Data2]),
    Return = http:request(post, Data2, [], []),
    io:format("in hn_post return from POST is ~p~n",[Return]),
    {ok, {{V, 200, R}, H, Body}} = Return.


hn_get(Site,Path,Cell) ->
    io:format("in hn_get Site is ~p Path is ~p and Cell is ~p~n",[Site,Path,Cell]),
    Url=Site++Path++Cell,
    io:format("in hn_get Url is ~p~n",[Url]),
    {ok, {{V, 200, R}, H, Body}} = http:request(get, {Url, []}, [], []),
    io:format("in hn_get body is ~p~n",[Body]),
    %%stdext:text2num(Body). %% Assume it's all numbers for now.
    Body.

assert_eql(X, Y) when is_integer(X) andalso is_float(Y) ->
    X * 1.0 == Y;
assert_eql(X, Y) when is_float(X) andalso is_integer(Y) ->
    X == Y * 1.0;
assert_eql(X, Y) ->
    X == Y.
    
sheet1_a1_test(doc) -> [{userdata,[{""}]}];
sheet1_a1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a1"),
  Expected="This spreadsheet should have 10 tests - it tests the alignment of the test generators and makes sure that it it pulling out the range correctly and not transposed",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_a2_test(doc) -> [{userdata,[{""}]}];
sheet1_a2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a2"),
  Expected="If this test fails there will only be two tests - this one and the introductary text - none of them will be for integers.",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b1_test(doc) -> [{userdata,[{""}]}];
sheet1_b1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b1"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b2_test(doc) -> [{userdata,[{""}]}];
sheet1_b2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b2"),
  Expected="7.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c1_test(doc) -> [{userdata,[{""}]}];
sheet1_c1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c1"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c2_test(doc) -> [{userdata,[{""}]}];
sheet1_c2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c2"),
  Expected="8.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d1_test(doc) -> [{userdata,[{""}]}];
sheet1_d1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d1"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d2_test(doc) -> [{userdata,[{""}]}];
sheet1_d2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d2"),
  Expected="9.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_e1_test(doc) -> [{userdata,[{""}]}];
sheet1_e1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e1"),
  Expected="9.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_e2_test(doc) -> [{userdata,[{""}]}];
sheet1_e2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e2"),
  Expected="33.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
all() -> 
    [sheet1_a1_test,
   sheet1_a2_test,
   sheet1_b1_test,
   sheet1_b2_test,
   sheet1_c1_test,
   sheet1_c2_test,
   sheet1_d1_test,
   sheet1_d2_test,
   sheet1_e1_test,
   sheet1_e2_test
    ].
  
