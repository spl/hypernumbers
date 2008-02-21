% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_three_dee_ref.xls
% Generated on: Sun Feb 17 21:42:39 +0000 2008

-module(b_three_dee_ref_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_three_dee_ref.xls"),
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
  test_util:read_from_excel_data(Config,b_three_dee_ref_SUITE,{Sheet,Row,Col}).

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
    
tom_a6_test(doc) -> [{userdata,[{""}]}];
tom_a6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","a6"),
  Expected="And now some errors - the sheet bob has been deleted",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_a1_test(doc) -> [{userdata,[{""}]}];
tom_a1_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","a1"),
  Expected="This Spreadsheet tests 3D references",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_a7_test(doc) -> [{userdata,[{""}]}];
tom_a7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","a7"),
  Expected="Simple Ref",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_a2_test(doc) -> [{userdata,[{""}]}];
tom_a2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","a2"),
  Expected="Simple Ref",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_a8_test(doc) -> [{userdata,[{""}]}];
tom_a8_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","a8"),
  Expected="Simple Range",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_a3_test(doc) -> [{userdata,[{""}]}];
tom_a3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","a3"),
  Expected="Simple Range",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_a4_test(doc) -> [{userdata,[{""}]}];
tom_a4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","a4"),
  Expected="3D Range",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_b7_test(doc) -> [{userdata,[{""}]}];
tom_b7_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","b7"),
  Expected="-2146826265",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_b2_test(doc) -> [{userdata,[{""}]}];
tom_b2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","b2"),
  Expected="444.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_b8_test(doc) -> [{userdata,[{""}]}];
tom_b8_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","b8"),
  Expected="-2146826265",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_b3_test(doc) -> [{userdata,[{""}]}];
tom_b3_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","b3"),
  Expected="10.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
tom_b4_test(doc) -> [{userdata,[{""}]}];
tom_b4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Tom/","b4"),
  Expected="999.0",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
all() -> 
    [tom_a6_test,
   tom_a1_test,
   tom_a7_test,
   tom_a2_test,
   tom_a8_test,
   tom_a3_test,
   tom_a4_test,
   tom_b7_test,
   tom_b2_test,
   tom_b8_test,
   tom_b3_test,
   tom_b4_test
    ].
  
