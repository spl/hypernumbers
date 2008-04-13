% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_just_numbers.xls
% Generated on: Sun Apr 13 20:22:25 +0100 2008

-module(b_just_numbers_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    io:format("dumping current path next: "),
    c:pwd(),
    Data = test_util:read_excel_file("../../excel_files/Win Excel 2007 (as 97)/b_just_numbers.xls"),
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
  test_util:read_from_excel_data(Config,b_just_numbers_SUITE,{Sheet,Row,Col}).

%%% Helper functions.

hn_post(Site, Path, Cell, Data) ->
    Url=Site++Path++Cell,
    PostData = "<create><value>" ++Data++"</value></create>",
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
    
sheet1_a5_test(doc) -> [{userdata,[{""}]}];
sheet1_a5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a5"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a11_test(doc) -> [{userdata,[{""}]}];
sheet1_a11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a11"),
  Expected="10.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a6_test(doc) -> [{userdata,[{""}]}];
sheet1_a6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a6"),
  Expected="5.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a1_test(doc) -> [{userdata,[{""}]}];
sheet1_a1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a1"),
  Expected="0.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a7_test(doc) -> [{userdata,[{""}]}];
sheet1_a7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a7"),
  Expected="6.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a2_test(doc) -> [{userdata,[{""}]}];
sheet1_a2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a2"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a8_test(doc) -> [{userdata,[{""}]}];
sheet1_a8_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a8"),
  Expected="7.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a3_test(doc) -> [{userdata,[{""}]}];
sheet1_a3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a3"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a9_test(doc) -> [{userdata,[{""}]}];
sheet1_a9_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a9"),
  Expected="8.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a4_test(doc) -> [{userdata,[{""}]}];
sheet1_a4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a4"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a10_test(doc) -> [{userdata,[{""}]}];
sheet1_a10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a10"),
  Expected="9.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c11_test(doc) -> [{userdata,[{""}]}];
sheet1_c11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c11"),
  Expected="777.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c1_test(doc) -> [{userdata,[{""}]}];
sheet1_c1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c1"),
  Expected="1.1",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c2_test(doc) -> [{userdata,[{""}]}];
sheet1_c2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c2"),
  Expected="0.12",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c3_test(doc) -> [{userdata,[{""}]}];
sheet1_c3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c3"),
  Expected="-0.99",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e2_test(doc) -> [{userdata,[{""}]}];
sheet1_e2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e2"),
  Expected="0.123",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e3_test(doc) -> [{userdata,[{""}]}];
sheet1_e3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e3"),
  Expected="123.123456789012",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g5_test(doc) -> [{userdata,[{""}]}];
sheet1_g5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g5"),
  Expected="4294967296.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g6_test(doc) -> [{userdata,[{""}]}];
sheet1_g6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g6"),
  Expected="4294967297.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g1_test(doc) -> [{userdata,[{""}]}];
sheet1_g1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g1"),
  Expected="0.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g7_test(doc) -> [{userdata,[{""}]}];
sheet1_g7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g7"),
  Expected="1.84467440737095e+019",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g2_test(doc) -> [{userdata,[{""}]}];
sheet1_g2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g2"),
  Expected="256.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g3_test(doc) -> [{userdata,[{""}]}];
sheet1_g3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g3"),
  Expected="65535.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g4_test(doc) -> [{userdata,[{""}]}];
sheet1_g4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g4"),
  Expected="16777216.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
all() -> 
    [sheet1_a5_test,
   sheet1_a11_test,
   sheet1_a6_test,
   sheet1_a1_test,
   sheet1_a7_test,
   sheet1_a2_test,
   sheet1_a8_test,
   sheet1_a3_test,
   sheet1_a9_test,
   sheet1_a4_test,
   sheet1_a10_test,
   sheet1_c11_test,
   sheet1_c1_test,
   sheet1_c2_test,
   sheet1_c3_test,
   sheet1_e2_test,
   sheet1_e3_test,
   sheet1_g5_test,
   sheet1_g6_test,
   sheet1_g1_test,
   sheet1_g7_test,
   sheet1_g2_test,
   sheet1_g3_test,
   sheet1_g4_test
    ].
  
