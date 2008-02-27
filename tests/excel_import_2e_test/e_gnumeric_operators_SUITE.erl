% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: e_gnumeric_operators.xls
% Generated on: Mon Feb 25 21:57:40 +0000 2008

-module(e_gnumeric_operators_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/e_gnumeric_operators.xls"),
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
  test_util:read_from_excel_data(Config,e_gnumeric_operators_SUITE,{Sheet,Row,Col}).

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
    
result_a5_test(doc) -> [{userdata,[{""}]}];
result_a5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a5"),
  Expected="LTE",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a16_test(doc) -> [{userdata,[{""}]}];
result_a16_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a16"),
  Expected="Epsilon :",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a11_test(doc) -> [{userdata,[{""}]}];
result_a11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a11"),
  Expected="EXP",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a6_test(doc) -> [{userdata,[{""}]}];
result_a6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a6"),
  Expected="NOT_EQUAL",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a1_test(doc) -> [{userdata,[{""}]}];
result_a1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a1"),
  Expected="EQUAL",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a12_test(doc) -> [{userdata,[{""}]}];
result_a12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a12"),
  Expected="CONCAT",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a7_test(doc) -> [{userdata,[{""}]}];
result_a7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a7"),
  Expected="ADD",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a2_test(doc) -> [{userdata,[{""}]}];
result_a2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a2"),
  Expected="GT",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a8_test(doc) -> [{userdata,[{""}]}];
result_a8_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a8"),
  Expected="SUB",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a3_test(doc) -> [{userdata,[{""}]}];
result_a3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a3"),
  Expected="LT",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a9_test(doc) -> [{userdata,[{""}]}];
result_a9_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a9"),
  Expected="MULT",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a4_test(doc) -> [{userdata,[{""}]}];
result_a4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a4"),
  Expected="GTE",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_a10_test(doc) -> [{userdata,[{""}]}];
result_a10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","a10"),
  Expected="DIV",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_b16_test(doc) -> [{userdata,[{""}]}];
result_b16_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","b16"),
  Expected="1.0e-006",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c5_test(doc) -> [{userdata,[{""}]}];
result_c5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c5"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c11_test(doc) -> [{userdata,[{""}]}];
result_c11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c11"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c6_test(doc) -> [{userdata,[{""}]}];
result_c6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c6"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c1_test(doc) -> [{userdata,[{""}]}];
result_c1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c1"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c12_test(doc) -> [{userdata,[{""}]}];
result_c12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c12"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c7_test(doc) -> [{userdata,[{""}]}];
result_c7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c7"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c2_test(doc) -> [{userdata,[{""}]}];
result_c2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c2"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c8_test(doc) -> [{userdata,[{""}]}];
result_c8_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c8"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c3_test(doc) -> [{userdata,[{""}]}];
result_c3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c3"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c9_test(doc) -> [{userdata,[{""}]}];
result_c9_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c9"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c4_test(doc) -> [{userdata,[{""}]}];
result_c4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c4"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
result_c10_test(doc) -> [{userdata,[{""}]}];
result_c10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Result/","c10"),
  Expected="Success",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
all() -> 
    [result_a5_test,
   result_a16_test,
   result_a11_test,
   result_a6_test,
   result_a1_test,
   result_a12_test,
   result_a7_test,
   result_a2_test,
   result_a8_test,
   result_a3_test,
   result_a9_test,
   result_a4_test,
   result_a10_test,
   result_b16_test,
   result_c5_test,
   result_c11_test,
   result_c6_test,
   result_c1_test,
   result_c12_test,
   result_c7_test,
   result_c2_test,
   result_c8_test,
   result_c3_test,
   result_c9_test,
   result_c4_test,
   result_c10_test
    ].
  
