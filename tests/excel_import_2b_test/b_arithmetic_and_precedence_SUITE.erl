% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_arithmetic_and_precedence.xls
% Generated on: Sun Feb 17 21:42:28 +0000 2008

-module(b_arithmetic_and_precedence_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_arithmetic_and_precedence.xls"),
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
  test_util:read_from_excel_data(Config,b_arithmetic_and_precedence_SUITE,{Sheet,Row,Col}).

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
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a16_test(doc) -> [{userdata,[{""}]}];
sheet1_a16_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a16"),
  Expected="4.99992855509831",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a27_test(doc) -> [{userdata,[{""}]}];
sheet1_a27_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a27"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a22_test(doc) -> [{userdata,[{""}]}];
sheet1_a22_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a22"),
  Expected="10.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a33_test(doc) -> [{userdata,[{""}]}];
sheet1_a33_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a33"),
  Expected="111.4",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a6_test(doc) -> [{userdata,[{""}]}];
sheet1_a6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a6"),
  Expected="-1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a17_test(doc) -> [{userdata,[{""}]}];
sheet1_a17_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a17"),
  Expected="-12.6",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a28_test(doc) -> [{userdata,[{""}]}];
sheet1_a28_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a28"),
  Expected="2224.9999285551",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a1_test(doc) -> [{userdata,[{""}]}];
sheet1_a1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a1"),
  Expected="This spreadsheet tests basic arithmetic operations",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a12_test(doc) -> [{userdata,[{""}]}];
sheet1_a12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a12"),
  Expected="Precedence and brackets",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a23_test(doc) -> [{userdata,[{""}]}];
sheet1_a23_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a23"),
  Expected="32.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a34_test(doc) -> [{userdata,[{""}]}];
sheet1_a34_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a34"),
  Expected="-187391.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a7_test(doc) -> [{userdata,[{""}]}];
sheet1_a7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a7"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a18_test(doc) -> [{userdata,[{""}]}];
sheet1_a18_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a18"),
  Expected="15625.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a29_test(doc) -> [{userdata,[{""}]}];
sheet1_a29_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a29"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a13_test(doc) -> [{userdata,[{""}]}];
sheet1_a13_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a13"),
  Expected="Formula",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a24_test(doc) -> [{userdata,[{""}]}];
sheet1_a24_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a24"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a35_test(doc) -> [{userdata,[{""}]}];
sheet1_a35_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a35"),
  Expected="117608.060801556",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a8_test(doc) -> [{userdata,[{""}]}];
sheet1_a8_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a8"),
  Expected="0.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a19_test(doc) -> [{userdata,[{""}]}];
sheet1_a19_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a19"),
  Expected="5.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a30_test(doc) -> [{userdata,[{""}]}];
sheet1_a30_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a30"),
  Expected="109.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a3_test(doc) -> [{userdata,[{""}]}];
sheet1_a3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a3"),
  Expected="Simple Arithmetic",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a14_test(doc) -> [{userdata,[{""}]}];
sheet1_a14_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a14"),
  Expected="4.99992855509831",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a25_test(doc) -> [{userdata,[{""}]}];
sheet1_a25_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a25"),
  Expected="7.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a36_test(doc) -> [{userdata,[{""}]}];
sheet1_a36_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a36"),
  Expected="0.03",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a9_test(doc) -> [{userdata,[{""}]}];
sheet1_a9_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a9"),
  Expected="-2146826281",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a20_test(doc) -> [{userdata,[{""}]}];
sheet1_a20_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a20"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a31_test(doc) -> [{userdata,[{""}]}];
sheet1_a31_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a31"),
  Expected="112.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a4_test(doc) -> [{userdata,[{""}]}];
sheet1_a4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a4"),
  Expected="Formula",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a15_test(doc) -> [{userdata,[{""}]}];
sheet1_a15_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a15"),
  Expected="11.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a26_test(doc) -> [{userdata,[{""}]}];
sheet1_a26_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a26"),
  Expected="9.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a10_test(doc) -> [{userdata,[{""}]}];
sheet1_a10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a10"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a21_test(doc) -> [{userdata,[{""}]}];
sheet1_a21_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a21"),
  Expected="10.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a32_test(doc) -> [{userdata,[{""}]}];
sheet1_a32_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a32"),
  Expected="97.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b5_test(doc) -> [{userdata,[{""}]}];
sheet1_b5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b5"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b16_test(doc) -> [{userdata,[{""}]}];
sheet1_b16_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b16"),
  Expected="4.99992855509831",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b27_test(doc) -> [{userdata,[{""}]}];
sheet1_b27_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b27"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b22_test(doc) -> [{userdata,[{""}]}];
sheet1_b22_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b22"),
  Expected="10.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b33_test(doc) -> [{userdata,[{""}]}];
sheet1_b33_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b33"),
  Expected="1.4",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b6_test(doc) -> [{userdata,[{""}]}];
sheet1_b6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b6"),
  Expected="-1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b17_test(doc) -> [{userdata,[{""}]}];
sheet1_b17_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b17"),
  Expected="-12.6",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b28_test(doc) -> [{userdata,[{""}]}];
sheet1_b28_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b28"),
  Expected="4.99992855509831",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b23_test(doc) -> [{userdata,[{""}]}];
sheet1_b23_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b23"),
  Expected="32.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b34_test(doc) -> [{userdata,[{""}]}];
sheet1_b34_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b34"),
  Expected="-187501.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b7_test(doc) -> [{userdata,[{""}]}];
sheet1_b7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b7"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b18_test(doc) -> [{userdata,[{""}]}];
sheet1_b18_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b18"),
  Expected="15625.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b29_test(doc) -> [{userdata,[{""}]}];
sheet1_b29_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b29"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b13_test(doc) -> [{userdata,[{""}]}];
sheet1_b13_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b13"),
  Expected="Answer",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b24_test(doc) -> [{userdata,[{""}]}];
sheet1_b24_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b24"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b35_test(doc) -> [{userdata,[{""}]}];
sheet1_b35_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b35"),
  Expected="117608.060801556",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b8_test(doc) -> [{userdata,[{""}]}];
sheet1_b8_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b8"),
  Expected="0.5",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b19_test(doc) -> [{userdata,[{""}]}];
sheet1_b19_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b19"),
  Expected="5.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b30_test(doc) -> [{userdata,[{""}]}];
sheet1_b30_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b30"),
  Expected="-1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b14_test(doc) -> [{userdata,[{""}]}];
sheet1_b14_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b14"),
  Expected="4.99992855509831",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b25_test(doc) -> [{userdata,[{""}]}];
sheet1_b25_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b25"),
  Expected="7.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b36_test(doc) -> [{userdata,[{""}]}];
sheet1_b36_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b36"),
  Expected="0.03",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b9_test(doc) -> [{userdata,[{""}]}];
sheet1_b9_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b9"),
  Expected="-2146826281",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b20_test(doc) -> [{userdata,[{""}]}];
sheet1_b20_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b20"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b31_test(doc) -> [{userdata,[{""}]}];
sheet1_b31_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b31"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b4_test(doc) -> [{userdata,[{""}]}];
sheet1_b4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b4"),
  Expected="Answer",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b15_test(doc) -> [{userdata,[{""}]}];
sheet1_b15_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b15"),
  Expected="11.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b26_test(doc) -> [{userdata,[{""}]}];
sheet1_b26_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b26"),
  Expected="9.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b10_test(doc) -> [{userdata,[{""}]}];
sheet1_b10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b10"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b21_test(doc) -> [{userdata,[{""}]}];
sheet1_b21_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b21"),
  Expected="10.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b32_test(doc) -> [{userdata,[{""}]}];
sheet1_b32_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b32"),
  Expected="-13.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
all() -> 
    [sheet1_a5_test,
   sheet1_a16_test,
   sheet1_a27_test,
   sheet1_a22_test,
   sheet1_a33_test,
   sheet1_a6_test,
   sheet1_a17_test,
   sheet1_a28_test,
   sheet1_a1_test,
   sheet1_a12_test,
   sheet1_a23_test,
   sheet1_a34_test,
   sheet1_a7_test,
   sheet1_a18_test,
   sheet1_a29_test,
   sheet1_a13_test,
   sheet1_a24_test,
   sheet1_a35_test,
   sheet1_a8_test,
   sheet1_a19_test,
   sheet1_a30_test,
   sheet1_a3_test,
   sheet1_a14_test,
   sheet1_a25_test,
   sheet1_a36_test,
   sheet1_a9_test,
   sheet1_a20_test,
   sheet1_a31_test,
   sheet1_a4_test,
   sheet1_a15_test,
   sheet1_a26_test,
   sheet1_a10_test,
   sheet1_a21_test,
   sheet1_a32_test,
   sheet1_b5_test,
   sheet1_b16_test,
   sheet1_b27_test,
   sheet1_b22_test,
   sheet1_b33_test,
   sheet1_b6_test,
   sheet1_b17_test,
   sheet1_b28_test,
   sheet1_b23_test,
   sheet1_b34_test,
   sheet1_b7_test,
   sheet1_b18_test,
   sheet1_b29_test,
   sheet1_b13_test,
   sheet1_b24_test,
   sheet1_b35_test,
   sheet1_b8_test,
   sheet1_b19_test,
   sheet1_b30_test,
   sheet1_b14_test,
   sheet1_b25_test,
   sheet1_b36_test,
   sheet1_b9_test,
   sheet1_b20_test,
   sheet1_b31_test,
   sheet1_b4_test,
   sheet1_b15_test,
   sheet1_b26_test,
   sheet1_b10_test,
   sheet1_b21_test,
   sheet1_b32_test
    ].
  
