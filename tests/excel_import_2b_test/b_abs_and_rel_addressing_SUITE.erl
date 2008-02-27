% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_abs_and_rel_addressing.xls
% Generated on: Mon Feb 25 21:57:12 +0000 2008

-module(b_abs_and_rel_addressing_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_abs_and_rel_addressing.xls"),
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
  test_util:read_from_excel_data(Config,b_abs_and_rel_addressing_SUITE,{Sheet,Row,Col}).

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
    
sheet1_b5_test(doc) -> [{userdata,[{""}]}];
sheet1_b5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b5"),
  Expected="22.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b16_test(doc) -> [{userdata,[{""}]}];
sheet1_b16_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b16"),
  Expected="230.6",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b11_test(doc) -> [{userdata,[{""}]}];
sheet1_b11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b11"),
  Expected="71.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b6_test(doc) -> [{userdata,[{""}]}];
sheet1_b6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b6"),
  Expected="33.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b17_test(doc) -> [{userdata,[{""}]}];
sheet1_b17_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b17"),
  Expected="943.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b12_test(doc) -> [{userdata,[{""}]}];
sheet1_b12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b12"),
  Expected="82.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b7_test(doc) -> [{userdata,[{""}]}];
sheet1_b7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b7"),
  Expected="44.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b18_test(doc) -> [{userdata,[{""}]}];
sheet1_b18_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b18"),
  Expected="832.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b13_test(doc) -> [{userdata,[{""}]}];
sheet1_b13_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b13"),
  Expected="49.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b19_test(doc) -> [{userdata,[{""}]}];
sheet1_b19_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b19"),
  Expected="777.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b14_test(doc) -> [{userdata,[{""}]}];
sheet1_b14_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b14"),
  Expected="16.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b4_test(doc) -> [{userdata,[{""}]}];
sheet1_b4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b4"),
  Expected="11.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b15_test(doc) -> [{userdata,[{""}]}];
sheet1_b15_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b15"),
  Expected="46.2",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_b10_test(doc) -> [{userdata,[{""}]}];
sheet1_b10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b10"),
  Expected="60.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c5_test(doc) -> [{userdata,[{""}]}];
sheet1_c5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c5"),
  Expected="22.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c16_test(doc) -> [{userdata,[{""}]}];
sheet1_c16_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c16"),
  Expected="33.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c11_test(doc) -> [{userdata,[{""}]}];
sheet1_c11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c11"),
  Expected="66.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c6_test(doc) -> [{userdata,[{""}]}];
sheet1_c6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c6"),
  Expected="33.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c17_test(doc) -> [{userdata,[{""}]}];
sheet1_c17_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c17"),
  Expected="999.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c12_test(doc) -> [{userdata,[{""}]}];
sheet1_c12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c12"),
  Expected="77.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c7_test(doc) -> [{userdata,[{""}]}];
sheet1_c7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c7"),
  Expected="44.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c18_test(doc) -> [{userdata,[{""}]}];
sheet1_c18_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c18"),
  Expected="888.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c13_test(doc) -> [{userdata,[{""}]}];
sheet1_c13_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c13"),
  Expected="88.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c19_test(doc) -> [{userdata,[{""}]}];
sheet1_c19_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c19"),
  Expected="777.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c14_test(doc) -> [{userdata,[{""}]}];
sheet1_c14_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c14"),
  Expected="11.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c4_test(doc) -> [{userdata,[{""}]}];
sheet1_c4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c4"),
  Expected="11.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c15_test(doc) -> [{userdata,[{""}]}];
sheet1_c15_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c15"),
  Expected="22.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_c10_test(doc) -> [{userdata,[{""}]}];
sheet1_c10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c10"),
  Expected="55.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d16_test(doc) -> [{userdata,[{""}]}];
sheet1_d16_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d16"),
  Expected="66.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d11_test(doc) -> [{userdata,[{""}]}];
sheet1_d11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d11"),
  Expected="222.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d17_test(doc) -> [{userdata,[{""}]}];
sheet1_d17_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d17"),
  Expected="777.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d12_test(doc) -> [{userdata,[{""}]}];
sheet1_d12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d12"),
  Expected="333.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d18_test(doc) -> [{userdata,[{""}]}];
sheet1_d18_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d18"),
  Expected="888.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d13_test(doc) -> [{userdata,[{""}]}];
sheet1_d13_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d13"),
  Expected="444.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d19_test(doc) -> [{userdata,[{""}]}];
sheet1_d19_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d19"),
  Expected="999.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d14_test(doc) -> [{userdata,[{""}]}];
sheet1_d14_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d14"),
  Expected="44.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d15_test(doc) -> [{userdata,[{""}]}];
sheet1_d15_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d15"),
  Expected="55.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
sheet1_d10_test(doc) -> [{userdata,[{""}]}];
sheet1_d10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d10"),
  Expected="111.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected2(Expected,Got).
  
all() -> 
    [sheet1_b5_test,
   sheet1_b16_test,
   sheet1_b11_test,
   sheet1_b6_test,
   sheet1_b17_test,
   sheet1_b12_test,
   sheet1_b7_test,
   sheet1_b18_test,
   sheet1_b13_test,
   sheet1_b19_test,
   sheet1_b14_test,
   sheet1_b4_test,
   sheet1_b15_test,
   sheet1_b10_test,
   sheet1_c5_test,
   sheet1_c16_test,
   sheet1_c11_test,
   sheet1_c6_test,
   sheet1_c17_test,
   sheet1_c12_test,
   sheet1_c7_test,
   sheet1_c18_test,
   sheet1_c13_test,
   sheet1_c19_test,
   sheet1_c14_test,
   sheet1_c4_test,
   sheet1_c15_test,
   sheet1_c10_test,
   sheet1_d16_test,
   sheet1_d11_test,
   sheet1_d17_test,
   sheet1_d12_test,
   sheet1_d18_test,
   sheet1_d13_test,
   sheet1_d19_test,
   sheet1_d14_test,
   sheet1_d15_test,
   sheet1_d10_test
    ].
  
