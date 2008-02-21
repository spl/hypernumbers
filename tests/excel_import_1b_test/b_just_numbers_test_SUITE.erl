% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_just_numbers.xls
% Generated on: Sun Feb 17 21:41:50 +0000 2008

-module(b_just_numbers_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_just_numbers.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    Pid=spawn(test_util,test_state,[Data]),
    io:format("in init_per_suite Pid is ~p~n",[Pid]),
    [{?MODULE,Pid}|Config].
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_just_numbers_test_SUITE,{Sheet,Row,Col}).

sheet1_a5_test(doc) -> [{userdata,[{""}]}];
sheet1_a5_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",4,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",4,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4.0}]),
      test_util:expected2(Msg, {number,4.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a11_test(doc) -> [{userdata,[{""}]}];
sheet1_a11_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,10.0}]),
      test_util:expected2(Msg, {number,10.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,5.0}]),
      test_util:expected2(Msg, {number,5.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,0.0}]),
      test_util:expected2(Msg, {number,0.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a7_test(doc) -> [{userdata,[{""}]}];
sheet1_a7_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",6,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",6,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,6.0}]),
      test_util:expected2(Msg, {number,6.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.0}]),
      test_util:expected2(Msg, {number,1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a8_test(doc) -> [{userdata,[{""}]}];
sheet1_a8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",7,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",7,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,7.0}]),
      test_util:expected2(Msg, {number,7.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,2.0}]),
      test_util:expected2(Msg, {number,2.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,8.0}]),
      test_util:expected2(Msg, {number,8.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a4_test(doc) -> [{userdata,[{""}]}];
sheet1_a4_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",3,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",3,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,3.0}]),
      test_util:expected2(Msg, {number,3.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a10_test(doc) -> [{userdata,[{""}]}];
sheet1_a10_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",9,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",9,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,9.0}]),
      test_util:expected2(Msg, {number,9.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,777.0}]),
      test_util:expected2(Msg, {number,777.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.1}]),
      test_util:expected2(Msg, {number,1.1})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,0.12}]),
      test_util:expected2(Msg, {number,0.12})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-0.99}]),
      test_util:expected2(Msg, {number,-0.99})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,0.123}]),
      test_util:expected2(Msg, {number,0.123})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_e3_test(doc) -> [{userdata,[{""}]}];
sheet1_e3_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",2,4}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",2,4}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,123.123456789012}]),
      test_util:expected2(Msg, {number,123.123456789012})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g5_test(doc) -> [{userdata,[{""}]}];
sheet1_g5_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",4,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",4,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4294967296.0}]),
      test_util:expected2(Msg, {number,4294967296.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g6_test(doc) -> [{userdata,[{""}]}];
sheet1_g6_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",5,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",5,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4294967297.0}]),
      test_util:expected2(Msg, {number,4294967297.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g1_test(doc) -> [{userdata,[{""}]}];
sheet1_g1_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",0,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",0,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,0.0}]),
      test_util:expected2(Msg, {number,0.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g7_test(doc) -> [{userdata,[{""}]}];
sheet1_g7_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",6,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",6,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.84467440737095e+019}]),
      test_util:expected2(Msg, {number,1.84467440737095e+019})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g2_test(doc) -> [{userdata,[{""}]}];
sheet1_g2_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",1,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",1,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,256.0}]),
      test_util:expected2(Msg, {number,256.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g3_test(doc) -> [{userdata,[{""}]}];
sheet1_g3_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",2,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",2,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,65535.0}]),
      test_util:expected2(Msg, {number,65535.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_g4_test(doc) -> [{userdata,[{""}]}];
sheet1_g4_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",3,6}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",3,6}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,16777216.0}]),
      test_util:expected2(Msg, {number,16777216.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
all() -> 
    [sheet1_a5_test,
   sheet1_a11_test,
   sheet1_a6_test,
   sheet1_a1_test,
   sheet1_a7_test,
   sheet1_a2_test,
   sheet1_a8_test,
   sheet1_a3_test,
   sheet1_a9_test,
   sheet1_a4_test,
   sheet1_a10_test,
   sheet1_c11_test,
   sheet1_c1_test,
   sheet1_c2_test,
   sheet1_c3_test,
   sheet1_e2_test,
   sheet1_e3_test,
   sheet1_g5_test,
   sheet1_g6_test,
   sheet1_g1_test,
   sheet1_g7_test,
   sheet1_g2_test,
   sheet1_g3_test,
   sheet1_g4_test
    ].
  
