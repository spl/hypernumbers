% This module has been generated by gen_full_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: e_gnumeric_trig.xls
% Generated on: Tue Mar 11 09:11:37 +0000 2008

-module(e_gnumeric_trig_SUITE).
-compile(export_all).
-include("ct.hrl").

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    test_util:wait(),
    io:format("dumping current path next: "),
    c:pwd(),
    Data = test_util:read_excel_file("../../excel_files/Win Excel 2007 (as 97)/e_gnumeric_trig.xls"),
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
  test_util:read_from_excel_data(Config,e_gnumeric_trig_SUITE,{Sheet,Row,Col}).

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
    
summary_a5_test(doc) -> [{userdata,[{""}]}];
summary_a5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","a5"),
  Expected="<cell><value>"++"ATan2"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_a6_test(doc) -> [{userdata,[{""}]}];
summary_a6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","a6"),
  Expected="<cell><value>"++"PI"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_a4_test(doc) -> [{userdata,[{""}]}];
summary_a4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","a4"),
  Expected="<cell><value>"++"Trigonometry"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_b5_test(doc) -> [{userdata,[{""}]}];
summary_b5_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","b5"),
  Expected="<cell><value>"++"Success"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_b6_test(doc) -> [{userdata,[{""}]}];
summary_b6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","b6"),
  Expected="<cell><value>"++"3.14159265358979"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_b4_test(doc) -> [{userdata,[{""}]}];
summary_b4_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","b4"),
  Expected="<cell><value>"++"Success"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_c6_test(doc) -> [{userdata,[{""}]}];
summary_c6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","c6"),
  Expected="<cell><value>"++"PI"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_d6_test(doc) -> [{userdata,[{""}]}];
summary_d6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","d6"),
  Expected="<cell><value>"++"3.14159265358979"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_d2_test(doc) -> [{userdata,[{""}]}];
summary_d2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","d2"),
  Expected="<cell><value>"++"Tolerance"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_e6_test(doc) -> [{userdata,[{""}]}];
summary_e6_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","e6"),
  Expected="<cell><value>"++"Success"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
summary_e2_test(doc) -> [{userdata,[{""}]}];
summary_e2_test(_Config) -> 
  Got=hn_get("http://127.0.0.1:9000","/Summary/","e2"),
  Expected="<cell><value>"++"1.0e-006"++"</value></cell>",
  io:format("Expected : ~p~nGot      : ~p~n",[Expected,Got]),
  test_util:expected(Expected,Got).
  
all() -> 
    [summary_a5_test,
   summary_a6_test,
   summary_a4_test,
   summary_b5_test,
   summary_b6_test,
   summary_b4_test,
   summary_c6_test,
   summary_d6_test,
   summary_d2_test,
   summary_e6_test,
   summary_e2_test
    ].
  
