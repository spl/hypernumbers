% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_sum_with_one_arg.xls
% Generated on: Sun Apr 13 20:22:32 +0100 2008

-module(b_sum_with_one_arg_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    io:format("dumping current path next: "),
    c:pwd(),
    Data = test_util:read_excel_file("../../excel_files/Win Excel 2007 (as 97)/b_sum_with_one_arg.xls"),
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
  test_util:read_from_excel_data(Config,b_sum_with_one_arg_SUITE,{Sheet,Row,Col}).

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
  Expected="21.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a6_test(doc) -> [{userdata,[{""}]}];
sheet1_a6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a6"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a1_test(doc) -> [{userdata,[{""}]}];
sheet1_a1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a1"),
  Expected="Special Test For Sum With 1 Parameter",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a12_test(doc) -> [{userdata,[{""}]}];
sheet1_a12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a12"),
  Expected="-2146826288",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a7_test(doc) -> [{userdata,[{""}]}];
sheet1_a7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a7"),
  Expected="10.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a2_test(doc) -> [{userdata,[{""}]}];
sheet1_a2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a2"),
  Expected="See Section 3.10 of the excelfileformat.v1.40.pdf",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a8_test(doc) -> [{userdata,[{""}]}];
sheet1_a8_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a8"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a3_test(doc) -> [{userdata,[{""}]}];
sheet1_a3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a3"),
  Expected="When sum has a single parameter is is converted into an attribute token",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a9_test(doc) -> [{userdata,[{""}]}];
sheet1_a9_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a9"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a4_test(doc) -> [{userdata,[{""}]}];
sheet1_a4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a4"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_a10_test(doc) -> [{userdata,[{""}]}];
sheet1_a10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","a10"),
  Expected="20.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b5_test(doc) -> [{userdata,[{""}]}];
sheet1_b5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b5"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b11_test(doc) -> [{userdata,[{""}]}];
sheet1_b11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b11"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b12_test(doc) -> [{userdata,[{""}]}];
sheet1_b12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b12"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b9_test(doc) -> [{userdata,[{""}]}];
sheet1_b9_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b9"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_b10_test(doc) -> [{userdata,[{""}]}];
sheet1_b10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","b10"),
  Expected="1.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c11_test(doc) -> [{userdata,[{""}]}];
sheet1_c11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c11"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c12_test(doc) -> [{userdata,[{""}]}];
sheet1_c12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c12"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c9_test(doc) -> [{userdata,[{""}]}];
sheet1_c9_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c9"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_c10_test(doc) -> [{userdata,[{""}]}];
sheet1_c10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","c10"),
  Expected="2.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_d11_test(doc) -> [{userdata,[{""}]}];
sheet1_d11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d11"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_d12_test(doc) -> [{userdata,[{""}]}];
sheet1_d12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d12"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_d10_test(doc) -> [{userdata,[{""}]}];
sheet1_d10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","d10"),
  Expected="3.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e11_test(doc) -> [{userdata,[{""}]}];
sheet1_e11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e11"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e12_test(doc) -> [{userdata,[{""}]}];
sheet1_e12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e12"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_e10_test(doc) -> [{userdata,[{""}]}];
sheet1_e10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","e10"),
  Expected="4.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_f11_test(doc) -> [{userdata,[{""}]}];
sheet1_f11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","f11"),
  Expected="5.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_f12_test(doc) -> [{userdata,[{""}]}];
sheet1_f12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","f12"),
  Expected="5.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_f10_test(doc) -> [{userdata,[{""}]}];
sheet1_f10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","f10"),
  Expected="5.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g11_test(doc) -> [{userdata,[{""}]}];
sheet1_g11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g11"),
  Expected="6.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g12_test(doc) -> [{userdata,[{""}]}];
sheet1_g12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g12"),
  Expected="6.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_g10_test(doc) -> [{userdata,[{""}]}];
sheet1_g10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","g10"),
  Expected="6.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_h11_test(doc) -> [{userdata,[{""}]}];
sheet1_h11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","h11"),
  Expected="7.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_h12_test(doc) -> [{userdata,[{""}]}];
sheet1_h12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","h12"),
  Expected="7.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_h10_test(doc) -> [{userdata,[{""}]}];
sheet1_h10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","h10"),
  Expected="7.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_i11_test(doc) -> [{userdata,[{""}]}];
sheet1_i11_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","i11"),
  Expected="8.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_i12_test(doc) -> [{userdata,[{""}]}];
sheet1_i12_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","i12"),
  Expected="8.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
sheet1_i10_test(doc) -> [{userdata,[{""}]}];
sheet1_i10_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Sheet1/","i10"),
  Expected="8.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
all() -> 
    [sheet1_a5_test,
   sheet1_a11_test,
   sheet1_a6_test,
   sheet1_a1_test,
   sheet1_a12_test,
   sheet1_a7_test,
   sheet1_a2_test,
   sheet1_a8_test,
   sheet1_a3_test,
   sheet1_a9_test,
   sheet1_a4_test,
   sheet1_a10_test,
   sheet1_b5_test,
   sheet1_b11_test,
   sheet1_b12_test,
   sheet1_b9_test,
   sheet1_b10_test,
   sheet1_c11_test,
   sheet1_c12_test,
   sheet1_c9_test,
   sheet1_c10_test,
   sheet1_d11_test,
   sheet1_d12_test,
   sheet1_d10_test,
   sheet1_e11_test,
   sheet1_e12_test,
   sheet1_e10_test,
   sheet1_f11_test,
   sheet1_f12_test,
   sheet1_f10_test,
   sheet1_g11_test,
   sheet1_g12_test,
   sheet1_g10_test,
   sheet1_h11_test,
   sheet1_h12_test,
   sheet1_h10_test,
   sheet1_i11_test,
   sheet1_i12_test,
   sheet1_i10_test
    ].
  
