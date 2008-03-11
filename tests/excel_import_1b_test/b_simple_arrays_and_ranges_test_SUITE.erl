% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_simple_arrays_and_ranges.xls
% Generated on: Tue Mar 11 09:10:02 +0000 2008

-module(b_simple_arrays_and_ranges_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("../../../../excel_files/Win Excel 2007 (as 97)/b_simple_arrays_and_ranges.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    Pid=spawn(test_util,test_state,[Data]),
    io:format("in init_per_suite Pid is ~p~n",[Pid]),
    [{?MODULE,Pid}|Config].
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_simple_arrays_and_ranges_test_SUITE,{Sheet,Row,Col}).

sheet1_a8_test(doc) -> [{userdata,[{""}]}];
sheet1_a8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",7,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",7,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Bruk ->"}]),
      test_util:expected2(Msg, {string,"Bruk ->"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a9_test(doc) -> [{userdata,[{""}]}];
sheet1_a9_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",8,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",8,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Bruk ->"}]),
      test_util:expected2(Msg, {string,"Bruk ->"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b5_test(doc) -> [{userdata,[{""}]}];
sheet1_b5_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",4,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",4,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Multiple Element Array"}]),
      test_util:expected2(Msg, {string,"Multiple Element Array"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b11_test(doc) -> [{userdata,[{""}]}];
sheet1_b11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Complex I"}]),
      test_util:expected2(Msg, {string,"Complex I"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b6_test(doc) -> [{userdata,[{""}]}];
sheet1_b6_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",5,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",5,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"2D Array"}]),
      test_util:expected2(Msg, {string,"2D Array"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b1_test(doc) -> [{userdata,[{""}]}];
sheet1_b1_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",0,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",0,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Single Element Array I"}]),
      test_util:expected2(Msg, {string,"Single Element Array I"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b7_test(doc) -> [{userdata,[{""}]}];
sheet1_b7_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",6,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",6,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"3D Array"}]),
      test_util:expected2(Msg, {string,"3D Array"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b2_test(doc) -> [{userdata,[{""}]}];
sheet1_b2_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",1,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",1,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Single Element Array 2"}]),
      test_util:expected2(Msg, {string,"Single Element Array 2"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b8_test(doc) -> [{userdata,[{""}]}];
sheet1_b8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",7,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",7,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Range"}]),
      test_util:expected2(Msg, {string,"Range"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b3_test(doc) -> [{userdata,[{""}]}];
sheet1_b3_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",2,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",2,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Single Element Array 3"}]),
      test_util:expected2(Msg, {string,"Single Element Array 3"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b9_test(doc) -> [{userdata,[{""}]}];
sheet1_b9_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",8,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",8,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Intersection"}]),
      test_util:expected2(Msg, {string,"Intersection"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b4_test(doc) -> [{userdata,[{""}]}];
sheet1_b4_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",3,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",3,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Single Element Array 4"}]),
      test_util:expected2(Msg, {string,"Single Element Array 4"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b10_test(doc) -> [{userdata,[{""}]}];
sheet1_b10_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",9,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",9,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Union"}]),
      test_util:expected2(Msg, {string,"Union"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c5_test(doc) -> [{userdata,[{""}]}];
sheet1_c5_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",4,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",4,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"={2,1,\"old son\",#NULL!,TRUE,\"\"}"}]),
      test_util:expected2(Msg, {formula,"={2,1,\"old son\",#NULL!,TRUE,\"\"}"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c11_test(doc) -> [{userdata,[{""}]}];
sheet1_c11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(D11:E11,F11:G11 E11:I11,{4})"}]),
      test_util:expected2(Msg, {formula,"=SUM(D11:E11,F11:G11 E11:I11,{4})"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c6_test(doc) -> [{userdata,[{""}]}];
sheet1_c6_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",5,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",5,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"={33,44,55;66,77,88}"}]),
      test_util:expected2(Msg, {formula,"={33,44,55;66,77,88}"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c1_test(doc) -> [{userdata,[{""}]}];
sheet1_c1_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",0,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",0,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"={1}"}]),
      test_util:expected2(Msg, {formula,"={1}"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c7_test(doc) -> [{userdata,[{""}]}];
sheet1_c7_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",6,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",6,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"={44,55;66,77;88,99}"}]),
      test_util:expected2(Msg, {formula,"={44,55;66,77;88,99}"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c2_test(doc) -> [{userdata,[{""}]}];
sheet1_c2_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",1,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",1,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"={\"2\"}"}]),
      test_util:expected2(Msg, {formula,"={\"2\"}"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c8_test(doc) -> [{userdata,[{""}]}];
sheet1_c8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",7,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",7,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(D8:F8)"}]),
      test_util:expected2(Msg, {formula,"=SUM(D8:F8)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c3_test(doc) -> [{userdata,[{""}]}];
sheet1_c3_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",2,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",2,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"={TRUE}"}]),
      test_util:expected2(Msg, {formula,"={TRUE}"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c9_test(doc) -> [{userdata,[{""}]}];
sheet1_c9_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",8,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",8,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(D9:E9 E9:G9)"}]),
      test_util:expected2(Msg, {formula,"=SUM(D9:E9 E9:G9)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c4_test(doc) -> [{userdata,[{""}]}];
sheet1_c4_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",3,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",3,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"={#NULL!}"}]),
      test_util:expected2(Msg, {formula,"={#NULL!}"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_c10_test(doc) -> [{userdata,[{""}]}];
sheet1_c10_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",9,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",9,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(D10:E10,F10:G10)"}]),
      test_util:expected2(Msg, {formula,"=SUM(D10:E10,F10:G10)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_d11_test(doc) -> [{userdata,[{""}]}];
sheet1_d11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,3}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,3}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,9.0}]),
      test_util:expected2(Msg, {number,9.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_d8_test(doc) -> [{userdata,[{""}]}];
sheet1_d8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",7,3}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",7,3}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.0}]),
      test_util:expected2(Msg, {number,1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_d9_test(doc) -> [{userdata,[{""}]}];
sheet1_d9_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",8,3}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",8,3}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.0}]),
      test_util:expected2(Msg, {number,1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_d10_test(doc) -> [{userdata,[{""}]}];
sheet1_d10_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",9,3}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",9,3}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,444.0}]),
      test_util:expected2(Msg, {number,444.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_e11_test(doc) -> [{userdata,[{""}]}];
sheet1_e11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,4}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,4}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,8.0}]),
      test_util:expected2(Msg, {number,8.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_e8_test(doc) -> [{userdata,[{""}]}];
sheet1_e8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",7,4}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",7,4}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,2.0}]),
      test_util:expected2(Msg, {number,2.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_e9_test(doc) -> [{userdata,[{""}]}];
sheet1_e9_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",8,4}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",8,4}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,555.0}]),
      test_util:expected2(Msg, {number,555.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_e10_test(doc) -> [{userdata,[{""}]}];
sheet1_e10_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",9,4}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",9,4}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,555.0}]),
      test_util:expected2(Msg, {number,555.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_f11_test(doc) -> [{userdata,[{""}]}];
sheet1_f11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,5}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,5}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,7.0}]),
      test_util:expected2(Msg, {number,7.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_f8_test(doc) -> [{userdata,[{""}]}];
sheet1_f8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",7,5}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",7,5}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,3.0}]),
      test_util:expected2(Msg, {number,3.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_f9_test(doc) -> [{userdata,[{""}]}];
sheet1_f9_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",8,5}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",8,5}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.0}]),
      test_util:expected2(Msg, {number,1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_f10_test(doc) -> [{userdata,[{""}]}];
sheet1_f10_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",9,5}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",9,5}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,666.0}]),
      test_util:expected2(Msg, {number,666.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g11_test(doc) -> [{userdata,[{""}]}];
sheet1_g11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,6.0}]),
      test_util:expected2(Msg, {number,6.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g9_test(doc) -> [{userdata,[{""}]}];
sheet1_g9_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",8,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",8,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.0}]),
      test_util:expected2(Msg, {number,1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g10_test(doc) -> [{userdata,[{""}]}];
sheet1_g10_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",9,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",9,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,777.0}]),
      test_util:expected2(Msg, {number,777.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_h11_test(doc) -> [{userdata,[{""}]}];
sheet1_h11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,7}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,7}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,5.0}]),
      test_util:expected2(Msg, {number,5.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_i11_test(doc) -> [{userdata,[{""}]}];
sheet1_i11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,8}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,8}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4.0}]),
      test_util:expected2(Msg, {number,4.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
all() -> 
    [sheet1_a8_test,
   sheet1_a9_test,
   sheet1_b5_test,
   sheet1_b11_test,
   sheet1_b6_test,
   sheet1_b1_test,
   sheet1_b7_test,
   sheet1_b2_test,
   sheet1_b8_test,
   sheet1_b3_test,
   sheet1_b9_test,
   sheet1_b4_test,
   sheet1_b10_test,
   sheet1_c5_test,
   sheet1_c11_test,
   sheet1_c6_test,
   sheet1_c1_test,
   sheet1_c7_test,
   sheet1_c2_test,
   sheet1_c8_test,
   sheet1_c3_test,
   sheet1_c9_test,
   sheet1_c4_test,
   sheet1_c10_test,
   sheet1_d11_test,
   sheet1_d8_test,
   sheet1_d9_test,
   sheet1_d10_test,
   sheet1_e11_test,
   sheet1_e8_test,
   sheet1_e9_test,
   sheet1_e10_test,
   sheet1_f11_test,
   sheet1_f8_test,
   sheet1_f9_test,
   sheet1_f10_test,
   sheet1_g11_test,
   sheet1_g9_test,
   sheet1_g10_test,
   sheet1_h11_test,
   sheet1_i11_test
    ].
  
