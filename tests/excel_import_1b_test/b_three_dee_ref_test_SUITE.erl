% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_three_dee_ref.xls
% Generated on: Mon Feb 11 00:19:32 +0000 2008

-module(b_three_dee_ref_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_three_dee_ref.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    lists:merge([Config, [{b_three_dee_ref_test_SUITE, Data}]]).
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_three_dee_ref_test_SUITE,{Sheet,Row,Col}).

tom_a6_test(doc) -> [{userdata,[{""}]}];
tom_a6_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{string,"And now some errors - the sheet bob has been deleted"},read_from_excel_data(Config,{"Tom",5,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",5,0}), {string,"And now some errors - the sheet bob has been deleted"}).
  
tom_a1_test(doc) -> [{userdata,[{""}]}];
tom_a1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{string,"This Spreadsheet tests 3D references"},read_from_excel_data(Config,{"Tom",0,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",0,0}), {string,"This Spreadsheet tests 3D references"}).
  
tom_a7_test(doc) -> [{userdata,[{""}]}];
tom_a7_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{string,"Simple Ref"},read_from_excel_data(Config,{"Tom",6,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",6,0}), {string,"Simple Ref"}).
  
tom_a2_test(doc) -> [{userdata,[{""}]}];
tom_a2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{string,"Simple Ref"},read_from_excel_data(Config,{"Tom",1,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",1,0}), {string,"Simple Ref"}).
  
tom_a8_test(doc) -> [{userdata,[{""}]}];
tom_a8_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{string,"Simple Range"},read_from_excel_data(Config,{"Tom",7,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",7,0}), {string,"Simple Range"}).
  
tom_a3_test(doc) -> [{userdata,[{""}]}];
tom_a3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{string,"Simple Range"},read_from_excel_data(Config,{"Tom",2,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",2,0}), {string,"Simple Range"}).
  
tom_a4_test(doc) -> [{userdata,[{""}]}];
tom_a4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{string,"3D Range"},read_from_excel_data(Config,{"Tom",3,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",3,0}), {string,"3D Range"}).
  
tom_b7_test(doc) -> [{userdata,[{""}]}];
tom_b7_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{formula,"=#REF!A1"},read_from_excel_data(Config,{"Tom",6,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",6,1}), {formula,"=#REF!A1"}).
  
tom_b2_test(doc) -> [{userdata,[{""}]}];
tom_b2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{formula,"=Dick!A1"},read_from_excel_data(Config,{"Tom",1,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",1,1}), {formula,"=Dick!A1"}).
  
tom_b8_test(doc) -> [{userdata,[{""}]}];
tom_b8_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{formula,"=SUM(#REF!A1:D1)"},read_from_excel_data(Config,{"Tom",7,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",7,1}), {formula,"=SUM(#REF!A1:D1)"}).
  
tom_b3_test(doc) -> [{userdata,[{""}]}];
tom_b3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{formula,"=SUM(Dick!A2:D2)"},read_from_excel_data(Config,{"Tom",2,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",2,1}), {formula,"=SUM(Dick!A2:D2)"}).
  
tom_b4_test(doc) -> [{userdata,[{""}]}];
tom_b4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{formula,"=SUM(Dick:Harry!A1)"},read_from_excel_data(Config,{"Tom",3,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Tom",3,1}), {formula,"=SUM(Dick:Harry!A1)"}).
  
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
  
