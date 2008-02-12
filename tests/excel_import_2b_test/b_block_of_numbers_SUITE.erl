% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_block_of_numbers.xls
% Generated on: Mon Feb 11 06:23:51 +0000 2008

-module(b_block_of_numbers_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_block_of_numbers.xls"),
    Fun =fun({{{sheet,Sheet},{row_index,RowIdx},{col_index,ColIdx}},Input}) ->
      io:format("Sheet is ~p RowIdx is ~p and ColIdx is ~p~n",[Sheet,RowIdx,ColIdx]),
      Data1 = case Input of
        {_,Data2}                                -> Data2;
        {_,number,Data2} when is_float(Data2)   -> float_to_list(Data2);
        {_,number,Data2} when is_integer(Data2) -> integer_to_list(Data2);
        {_,boolean,true}                        -> "true";
        {_,boolean,false}                       -> "false"
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
  test_util:read_from_excel_data(Config,b_block_of_numbers_SUITE,{Sheet,Row,Col}).

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
    
sheet1_a5_test(doc) -> [{userdata,[{""}]}];
sheet1_a5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a5"),
  Expected="123456789.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a1_test(doc) -> [{userdata,[{""}]}];
sheet1_a1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a1"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a2_test(doc) -> [{userdata,[{""}]}];
sheet1_a2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a2"),
  Expected="11.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a3_test(doc) -> [{userdata,[{""}]}];
sheet1_a3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a3"),
  Expected="111.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a4_test(doc) -> [{userdata,[{""}]}];
sheet1_a4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a4"),
  Expected="1111.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b1_test(doc) -> [{userdata,[{""}]}];
sheet1_b1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b1"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b2_test(doc) -> [{userdata,[{""}]}];
sheet1_b2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b2"),
  Expected="22.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b3_test(doc) -> [{userdata,[{""}]}];
sheet1_b3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b3"),
  Expected="222.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b4_test(doc) -> [{userdata,[{""}]}];
sheet1_b4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b4"),
  Expected="2222.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c1_test(doc) -> [{userdata,[{""}]}];
sheet1_c1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c1"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c2_test(doc) -> [{userdata,[{""}]}];
sheet1_c2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c2"),
  Expected="33.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c3_test(doc) -> [{userdata,[{""}]}];
sheet1_c3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c3"),
  Expected="333.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c4_test(doc) -> [{userdata,[{""}]}];
sheet1_c4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c4"),
  Expected="3333.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_d1_test(doc) -> [{userdata,[{""}]}];
sheet1_d1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d1"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_d2_test(doc) -> [{userdata,[{""}]}];
sheet1_d2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d2"),
  Expected="44.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_d3_test(doc) -> [{userdata,[{""}]}];
sheet1_d3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d3"),
  Expected="444.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_d4_test(doc) -> [{userdata,[{""}]}];
sheet1_d4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d4"),
  Expected="4444.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e1_test(doc) -> [{userdata,[{""}]}];
sheet1_e1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e1"),
  Expected="5.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e2_test(doc) -> [{userdata,[{""}]}];
sheet1_e2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e2"),
  Expected="55.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e3_test(doc) -> [{userdata,[{""}]}];
sheet1_e3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e3"),
  Expected="555.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e4_test(doc) -> [{userdata,[{""}]}];
sheet1_e4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e4"),
  Expected="5555.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_f1_test(doc) -> [{userdata,[{""}]}];
sheet1_f1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","f1"),
  Expected="6.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_f2_test(doc) -> [{userdata,[{""}]}];
sheet1_f2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","f2"),
  Expected="66.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_f3_test(doc) -> [{userdata,[{""}]}];
sheet1_f3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","f3"),
  Expected="666.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_f4_test(doc) -> [{userdata,[{""}]}];
sheet1_f4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","f4"),
  Expected="6666.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g1_test(doc) -> [{userdata,[{""}]}];
sheet1_g1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g1"),
  Expected="7.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g2_test(doc) -> [{userdata,[{""}]}];
sheet1_g2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g2"),
  Expected="77.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g3_test(doc) -> [{userdata,[{""}]}];
sheet1_g3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g3"),
  Expected="777.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g4_test(doc) -> [{userdata,[{""}]}];
sheet1_g4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g4"),
  Expected="7777.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_h1_test(doc) -> [{userdata,[{""}]}];
sheet1_h1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","h1"),
  Expected="8.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_h2_test(doc) -> [{userdata,[{""}]}];
sheet1_h2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","h2"),
  Expected="88.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_h3_test(doc) -> [{userdata,[{""}]}];
sheet1_h3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","h3"),
  Expected="888.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_h4_test(doc) -> [{userdata,[{""}]}];
sheet1_h4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","h4"),
  Expected="8888.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_i1_test(doc) -> [{userdata,[{""}]}];
sheet1_i1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","i1"),
  Expected="9.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_i2_test(doc) -> [{userdata,[{""}]}];
sheet1_i2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","i2"),
  Expected="99.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_i3_test(doc) -> [{userdata,[{""}]}];
sheet1_i3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","i3"),
  Expected="999.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_i4_test(doc) -> [{userdata,[{""}]}];
sheet1_i4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","i4"),
  Expected="9999.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
all() -> 
    [sheet1_a5_test,
   sheet1_a1_test,
   sheet1_a2_test,
   sheet1_a3_test,
   sheet1_a4_test,
   sheet1_b1_test,
   sheet1_b2_test,
   sheet1_b3_test,
   sheet1_b4_test,
   sheet1_c1_test,
   sheet1_c2_test,
   sheet1_c3_test,
   sheet1_c4_test,
   sheet1_d1_test,
   sheet1_d2_test,
   sheet1_d3_test,
   sheet1_d4_test,
   sheet1_e1_test,
   sheet1_e2_test,
   sheet1_e3_test,
   sheet1_e4_test,
   sheet1_f1_test,
   sheet1_f2_test,
   sheet1_f3_test,
   sheet1_f4_test,
   sheet1_g1_test,
   sheet1_g2_test,
   sheet1_g3_test,
   sheet1_g4_test,
   sheet1_h1_test,
   sheet1_h2_test,
   sheet1_h3_test,
   sheet1_h4_test,
   sheet1_i1_test,
   sheet1_i2_test,
   sheet1_i3_test,
   sheet1_i4_test
    ].
  
