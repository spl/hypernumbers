% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_simple.xls
% Generated on: Mon Feb 25 21:56:41 +0000 2008

-module(b_simple_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_simple.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    Pid=spawn(test_util,test_state,[Data]),
    io:format("in init_per_suite Pid is ~p~n",[Pid]),
    [{?MODULE,Pid}|Config].
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_simple_test_SUITE,{Sheet,Row,Col}).

sheet1_a5_test(doc) -> [{userdata,[{""}]}];
sheet1_a5_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",4,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",4,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Integer"}]),
      test_util:expected2(Msg, {string,"Integer"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a6_test(doc) -> [{userdata,[{""}]}];
sheet1_a6_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",5,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",5,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Float"}]),
      test_util:expected2(Msg, {string,"Float"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a1_test(doc) -> [{userdata,[{""}]}];
sheet1_a1_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",0,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",0,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This is a simple introductory test"}]),
      test_util:expected2(Msg, {string,"This is a simple introductory test"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This is a cell A2"}]),
      test_util:expected2(Msg, {string,"This is a cell A2"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a3_test(doc) -> [{userdata,[{""}]}];
sheet1_a3_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",2,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",2,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This is cell A3"}]),
      test_util:expected2(Msg, {string,"This is cell A3"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.0}]),
      test_util:expected2(Msg, {number,1.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.2}]),
      test_util:expected2(Msg, {number,1.2})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This is cell B2"}]),
      test_util:expected2(Msg, {string,"This is cell B2"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This is cell B3"}]),
      test_util:expected2(Msg, {string,"This is cell B3"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This is cell B4"}]),
      test_util:expected2(Msg, {string,"This is cell B4"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
all() -> 
    [sheet1_a5_test,
   sheet1_a6_test,
   sheet1_a1_test,
   sheet1_a2_test,
   sheet1_a3_test,
   sheet1_b5_test,
   sheet1_b6_test,
   sheet1_b2_test,
   sheet1_b3_test,
   sheet1_b4_test
    ].
  
