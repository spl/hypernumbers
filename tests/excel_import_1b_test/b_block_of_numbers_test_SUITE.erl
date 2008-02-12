% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_block_of_numbers.xls
% Generated on: Mon Feb 11 00:19:27 +0000 2008

-module(b_block_of_numbers_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_block_of_numbers.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    lists:merge([Config, [{b_block_of_numbers_test_SUITE, Data}]]).
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_block_of_numbers_test_SUITE,{Sheet,Row,Col}).

sheet1_a5_test(doc) -> [{userdata,[{""}]}];
sheet1_a5_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,123456789.0},read_from_excel_data(Config,{"Sheet1",4,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",4,0}), {number,123456789.0}).
  
sheet1_a1_test(doc) -> [{userdata,[{""}]}];
sheet1_a1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,1.0},read_from_excel_data(Config,{"Sheet1",0,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,0}), {number,1.0}).
  
sheet1_a2_test(doc) -> [{userdata,[{""}]}];
sheet1_a2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,11.0},read_from_excel_data(Config,{"Sheet1",1,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,0}), {number,11.0}).
  
sheet1_a3_test(doc) -> [{userdata,[{""}]}];
sheet1_a3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,111.0},read_from_excel_data(Config,{"Sheet1",2,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,0}), {number,111.0}).
  
sheet1_a4_test(doc) -> [{userdata,[{""}]}];
sheet1_a4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,1111.0},read_from_excel_data(Config,{"Sheet1",3,0})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,0}), {number,1111.0}).
  
sheet1_b1_test(doc) -> [{userdata,[{""}]}];
sheet1_b1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,2.0},read_from_excel_data(Config,{"Sheet1",0,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,1}), {number,2.0}).
  
sheet1_b2_test(doc) -> [{userdata,[{""}]}];
sheet1_b2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,22.0},read_from_excel_data(Config,{"Sheet1",1,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,1}), {number,22.0}).
  
sheet1_b3_test(doc) -> [{userdata,[{""}]}];
sheet1_b3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,222.0},read_from_excel_data(Config,{"Sheet1",2,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,1}), {number,222.0}).
  
sheet1_b4_test(doc) -> [{userdata,[{""}]}];
sheet1_b4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,2222.0},read_from_excel_data(Config,{"Sheet1",3,1})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,1}), {number,2222.0}).
  
sheet1_c1_test(doc) -> [{userdata,[{""}]}];
sheet1_c1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,3.0},read_from_excel_data(Config,{"Sheet1",0,2})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,2}), {number,3.0}).
  
sheet1_c2_test(doc) -> [{userdata,[{""}]}];
sheet1_c2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,33.0},read_from_excel_data(Config,{"Sheet1",1,2})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,2}), {number,33.0}).
  
sheet1_c3_test(doc) -> [{userdata,[{""}]}];
sheet1_c3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,333.0},read_from_excel_data(Config,{"Sheet1",2,2})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,2}), {number,333.0}).
  
sheet1_c4_test(doc) -> [{userdata,[{""}]}];
sheet1_c4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,3333.0},read_from_excel_data(Config,{"Sheet1",3,2})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,2}), {number,3333.0}).
  
sheet1_d1_test(doc) -> [{userdata,[{""}]}];
sheet1_d1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,4.0},read_from_excel_data(Config,{"Sheet1",0,3})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,3}), {number,4.0}).
  
sheet1_d2_test(doc) -> [{userdata,[{""}]}];
sheet1_d2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,44.0},read_from_excel_data(Config,{"Sheet1",1,3})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,3}), {number,44.0}).
  
sheet1_d3_test(doc) -> [{userdata,[{""}]}];
sheet1_d3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,444.0},read_from_excel_data(Config,{"Sheet1",2,3})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,3}), {number,444.0}).
  
sheet1_d4_test(doc) -> [{userdata,[{""}]}];
sheet1_d4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,4444.0},read_from_excel_data(Config,{"Sheet1",3,3})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,3}), {number,4444.0}).
  
sheet1_e1_test(doc) -> [{userdata,[{""}]}];
sheet1_e1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,5.0},read_from_excel_data(Config,{"Sheet1",0,4})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,4}), {number,5.0}).
  
sheet1_e2_test(doc) -> [{userdata,[{""}]}];
sheet1_e2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,55.0},read_from_excel_data(Config,{"Sheet1",1,4})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,4}), {number,55.0}).
  
sheet1_e3_test(doc) -> [{userdata,[{""}]}];
sheet1_e3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,555.0},read_from_excel_data(Config,{"Sheet1",2,4})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,4}), {number,555.0}).
  
sheet1_e4_test(doc) -> [{userdata,[{""}]}];
sheet1_e4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,5555.0},read_from_excel_data(Config,{"Sheet1",3,4})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,4}), {number,5555.0}).
  
sheet1_f1_test(doc) -> [{userdata,[{""}]}];
sheet1_f1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,6.0},read_from_excel_data(Config,{"Sheet1",0,5})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,5}), {number,6.0}).
  
sheet1_f2_test(doc) -> [{userdata,[{""}]}];
sheet1_f2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,66.0},read_from_excel_data(Config,{"Sheet1",1,5})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,5}), {number,66.0}).
  
sheet1_f3_test(doc) -> [{userdata,[{""}]}];
sheet1_f3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,666.0},read_from_excel_data(Config,{"Sheet1",2,5})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,5}), {number,666.0}).
  
sheet1_f4_test(doc) -> [{userdata,[{""}]}];
sheet1_f4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,6666.0},read_from_excel_data(Config,{"Sheet1",3,5})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,5}), {number,6666.0}).
  
sheet1_g1_test(doc) -> [{userdata,[{""}]}];
sheet1_g1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,7.0},read_from_excel_data(Config,{"Sheet1",0,6})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,6}), {number,7.0}).
  
sheet1_g2_test(doc) -> [{userdata,[{""}]}];
sheet1_g2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,77.0},read_from_excel_data(Config,{"Sheet1",1,6})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,6}), {number,77.0}).
  
sheet1_g3_test(doc) -> [{userdata,[{""}]}];
sheet1_g3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,777.0},read_from_excel_data(Config,{"Sheet1",2,6})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,6}), {number,777.0}).
  
sheet1_g4_test(doc) -> [{userdata,[{""}]}];
sheet1_g4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,7777.0},read_from_excel_data(Config,{"Sheet1",3,6})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,6}), {number,7777.0}).
  
sheet1_h1_test(doc) -> [{userdata,[{""}]}];
sheet1_h1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,8.0},read_from_excel_data(Config,{"Sheet1",0,7})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,7}), {number,8.0}).
  
sheet1_h2_test(doc) -> [{userdata,[{""}]}];
sheet1_h2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,88.0},read_from_excel_data(Config,{"Sheet1",1,7})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,7}), {number,88.0}).
  
sheet1_h3_test(doc) -> [{userdata,[{""}]}];
sheet1_h3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,888.0},read_from_excel_data(Config,{"Sheet1",2,7})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,7}), {number,888.0}).
  
sheet1_h4_test(doc) -> [{userdata,[{""}]}];
sheet1_h4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,8888.0},read_from_excel_data(Config,{"Sheet1",3,7})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,7}), {number,8888.0}).
  
sheet1_i1_test(doc) -> [{userdata,[{""}]}];
sheet1_i1_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,9.0},read_from_excel_data(Config,{"Sheet1",0,8})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",0,8}), {number,9.0}).
  
sheet1_i2_test(doc) -> [{userdata,[{""}]}];
sheet1_i2_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,99.0},read_from_excel_data(Config,{"Sheet1",1,8})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",1,8}), {number,99.0}).
  
sheet1_i3_test(doc) -> [{userdata,[{""}]}];
sheet1_i3_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,999.0},read_from_excel_data(Config,{"Sheet1",2,8})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",2,8}), {number,999.0}).
  
sheet1_i4_test(doc) -> [{userdata,[{""}]}];
sheet1_i4_test(Config) -> 
  io:format("Expected : ~p~nGot      : ~p~n",[{number,9999.0},read_from_excel_data(Config,{"Sheet1",3,8})]),
  test_util:expected2(read_from_excel_data(Config,{"Sheet1",3,8}), {number,9999.0}).
  
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
  
