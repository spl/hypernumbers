% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: a_should_be_10_tests.xls
% Generated on: Sun Apr 13 20:21:19 +0100 2008

-module(a_should_be_10_tests_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("../../../../excel_files/Win Excel 2007 (as 97)/a_should_be_10_tests.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    Pid=spawn(test_util,test_state,[Data]),
    io:format("in init_per_suite Pid is ~p~n",[Pid]),
    [{?MODULE,Pid}|Config].
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,a_should_be_10_tests_test_SUITE,{Sheet,Row,Col}).

sheet1_a1_test(doc) -> [{userdata,[{""}]}];
sheet1_a1_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",0,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",0,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This spreadsheet should have 10 tests - it tests the alignment of the test generators and makes sure that it it pulling out the range correctly and not transposed"}]),
      test_util:expected2(Msg, {string,"This spreadsheet should have 10 tests - it tests the alignment of the test generators and makes sure that it it pulling out the range correctly and not transposed"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a2_test(doc) -> [{userdata,[{""}]}];
sheet1_a2_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",1,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",1,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"If this test fails there will only be two tests - this one and the introductary text - none of them will be for integers."}]),
      test_util:expected2(Msg, {string,"If this test fails there will only be two tests - this one and the introductary text - none of them will be for integers."})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,2.0}]),
      test_util:expected2(Msg, {number,2.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,7.0}]),
      test_util:expected2(Msg, {number,7.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,3.0}]),
      test_util:expected2(Msg, {number,3.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,8.0}]),
      test_util:expected2(Msg, {number,8.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_d1_test(doc) -> [{userdata,[{""}]}];
sheet1_d1_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",0,3}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",0,3}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4.0}]),
      test_util:expected2(Msg, {number,4.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_d2_test(doc) -> [{userdata,[{""}]}];
sheet1_d2_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",1,3}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",1,3}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,9.0}]),
      test_util:expected2(Msg, {number,9.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_e1_test(doc) -> [{userdata,[{""}]}];
sheet1_e1_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",0,4}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",0,4}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(B1:D1)"}]),
      test_util:expected2(Msg, {formula,"=SUM(B1:D1)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_e2_test(doc) -> [{userdata,[{""}]}];
sheet1_e2_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",1,4}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",1,4}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(B2:D2)+E1"}]),
      test_util:expected2(Msg, {formula,"=SUM(B2:D2)+E1"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
all() -> 
    [sheet1_a1_test,
   sheet1_a2_test,
   sheet1_b1_test,
   sheet1_b2_test,
   sheet1_c1_test,
   sheet1_c2_test,
   sheet1_d1_test,
   sheet1_d2_test,
   sheet1_e1_test,
   sheet1_e2_test
    ].
  
