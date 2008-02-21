% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_arithmetic_and_precedence.xls
% Generated on: Sun Feb 17 21:41:47 +0000 2008

-module(b_arithmetic_and_precedence_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_arithmetic_and_precedence.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    Pid=spawn(test_util,test_state,[Data]),
    io:format("in init_per_suite Pid is ~p~n",[Pid]),
    [{?MODULE,Pid}|Config].
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_arithmetic_and_precedence_test_SUITE,{Sheet,Row,Col}).

sheet1_a5_test(doc) -> [{userdata,[{""}]}];
sheet1_a5_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",4,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",4,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1+2"}]),
      test_util:expected2(Msg, {formula,"=1+2"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a16_test(doc) -> [{userdata,[{""}]}];
sheet1_a16_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",15,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",15,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=(2+3)-(4*5)/(6^7)"}]),
      test_util:expected2(Msg, {formula,"=(2+3)-(4*5)/(6^7)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a27_test(doc) -> [{userdata,[{""}]}];
sheet1_a27_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",26,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",26,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1+(2)"}]),
      test_util:expected2(Msg, {formula,"=1+(2)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a22_test(doc) -> [{userdata,[{""}]}];
sheet1_a22_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",21,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",21,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1+(2+(3+(4)))"}]),
      test_util:expected2(Msg, {formula,"=1+(2+(3+(4)))"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a33_test(doc) -> [{userdata,[{""}]}];
sheet1_a33_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",32,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",32,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=111+-2--3*-4/-5"}]),
      test_util:expected2(Msg, {formula,"=111+-2--3*-4/-5"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1-2"}]),
      test_util:expected2(Msg, {formula,"=1-2"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a17_test(doc) -> [{userdata,[{""}]}];
sheet1_a17_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",16,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",16,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=(2^3)/(4*5)-(6+7)"}]),
      test_util:expected2(Msg, {formula,"=(2^3)/(4*5)-(6+7)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a28_test(doc) -> [{userdata,[{""}]}];
sheet1_a28_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",27,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",27,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=(2222+3)-(4*5)/(6^7)"}]),
      test_util:expected2(Msg, {formula,"=(2222+3)-(4*5)/(6^7)"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This spreadsheet tests basic arithmetic operations"}]),
      test_util:expected2(Msg, {string,"This spreadsheet tests basic arithmetic operations"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a12_test(doc) -> [{userdata,[{""}]}];
sheet1_a12_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",11,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",11,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Precedence and brackets"}]),
      test_util:expected2(Msg, {string,"Precedence and brackets"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a23_test(doc) -> [{userdata,[{""}]}];
sheet1_a23_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",22,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",22,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1+(2+(3+(4)))-(22-(33-(44-(55))))"}]),
      test_util:expected2(Msg, {formula,"=1+(2+(3+(4)))-(22-(33-(44-(55))))"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a34_test(doc) -> [{userdata,[{""}]}];
sheet1_a34_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",33,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",33,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=111+-2--3*-4/-5^-6"}]),
      test_util:expected2(Msg, {formula,"=111+-2--3*-4/-5^-6"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1*2"}]),
      test_util:expected2(Msg, {formula,"=1*2"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a18_test(doc) -> [{userdata,[{""}]}];
sheet1_a18_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",17,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",17,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=((((2+3)-4)*5)^6)"}]),
      test_util:expected2(Msg, {formula,"=((((2+3)-4)*5)^6)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a29_test(doc) -> [{userdata,[{""}]}];
sheet1_a29_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",28,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",28,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=3"}]),
      test_util:expected2(Msg, {formula,"=3"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a13_test(doc) -> [{userdata,[{""}]}];
sheet1_a13_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",12,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",12,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Formula"}]),
      test_util:expected2(Msg, {string,"Formula"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a24_test(doc) -> [{userdata,[{""}]}];
sheet1_a24_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",23,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",23,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=(1)"}]),
      test_util:expected2(Msg, {formula,"=(1)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a35_test(doc) -> [{userdata,[{""}]}];
sheet1_a35_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",34,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",34,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=(3333)*(4/5/6)^8-4+4*-5+(((3/4)^(4---6)*5)/7^2/3)+(3-4*5+7^((6)))"}]),
      test_util:expected2(Msg, {formula,"=(3333)*(4/5/6)^8-4+4*-5+(((3/4)^(4---6)*5)/7^2/3)+(3-4*5+7^((6)))"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1/2"}]),
      test_util:expected2(Msg, {formula,"=1/2"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a19_test(doc) -> [{userdata,[{""}]}];
sheet1_a19_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",18,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",18,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=((1*2+3))"}]),
      test_util:expected2(Msg, {formula,"=((1*2+3))"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a30_test(doc) -> [{userdata,[{""}]}];
sheet1_a30_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",29,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",29,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=111+-2"}]),
      test_util:expected2(Msg, {formula,"=111+-2"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Simple Arithmetic"}]),
      test_util:expected2(Msg, {string,"Simple Arithmetic"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a14_test(doc) -> [{userdata,[{""}]}];
sheet1_a14_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",13,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",13,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=2+3-4*5/6^7"}]),
      test_util:expected2(Msg, {formula,"=2+3-4*5/6^7"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a25_test(doc) -> [{userdata,[{""}]}];
sheet1_a25_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",24,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",24,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1+(2*3)"}]),
      test_util:expected2(Msg, {formula,"=1+(2*3)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a36_test(doc) -> [{userdata,[{""}]}];
sheet1_a36_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",35,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",35,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=3%"}]),
      test_util:expected2(Msg, {formula,"=3%"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=1/0"}]),
      test_util:expected2(Msg, {formula,"=1/0"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a20_test(doc) -> [{userdata,[{""}]}];
sheet1_a20_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",19,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",19,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=(((((((4)))))))"}]),
      test_util:expected2(Msg, {formula,"=(((((((4)))))))"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a31_test(doc) -> [{userdata,[{""}]}];
sheet1_a31_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",30,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",30,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=111+-2--3"}]),
      test_util:expected2(Msg, {formula,"=111+-2--3"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Formula"}]),
      test_util:expected2(Msg, {string,"Formula"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a15_test(doc) -> [{userdata,[{""}]}];
sheet1_a15_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",14,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",14,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=2^3/4*5-6+7"}]),
      test_util:expected2(Msg, {formula,"=2^3/4*5-6+7"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a26_test(doc) -> [{userdata,[{""}]}];
sheet1_a26_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",25,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",25,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=(1+2)*3"}]),
      test_util:expected2(Msg, {formula,"=(1+2)*3"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=2^2"}]),
      test_util:expected2(Msg, {formula,"=2^2"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a21_test(doc) -> [{userdata,[{""}]}];
sheet1_a21_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",20,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",20,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=(1+(2+(3+(4))))"}]),
      test_util:expected2(Msg, {formula,"=(1+(2+(3+(4))))"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_a32_test(doc) -> [{userdata,[{""}]}];
sheet1_a32_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",31,0}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",31,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=111+-2--3*-4"}]),
      test_util:expected2(Msg, {formula,"=111+-2--3*-4"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,3.0}]),
      test_util:expected2(Msg, {number,3.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b16_test(doc) -> [{userdata,[{""}]}];
sheet1_b16_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",15,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",15,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4.99992855509831}]),
      test_util:expected2(Msg, {number,4.99992855509831})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b27_test(doc) -> [{userdata,[{""}]}];
sheet1_b27_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",26,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",26,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,3.0}]),
      test_util:expected2(Msg, {number,3.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b22_test(doc) -> [{userdata,[{""}]}];
sheet1_b22_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",21,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",21,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,10.0}]),
      test_util:expected2(Msg, {number,10.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b33_test(doc) -> [{userdata,[{""}]}];
sheet1_b33_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",32,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",32,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.4}]),
      test_util:expected2(Msg, {number,1.4})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-1.0}]),
      test_util:expected2(Msg, {number,-1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b17_test(doc) -> [{userdata,[{""}]}];
sheet1_b17_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",16,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",16,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-12.6}]),
      test_util:expected2(Msg, {number,-12.6})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b28_test(doc) -> [{userdata,[{""}]}];
sheet1_b28_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",27,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",27,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4.99992855509831}]),
      test_util:expected2(Msg, {number,4.99992855509831})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b23_test(doc) -> [{userdata,[{""}]}];
sheet1_b23_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",22,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",22,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,32.0}]),
      test_util:expected2(Msg, {number,32.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b34_test(doc) -> [{userdata,[{""}]}];
sheet1_b34_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",33,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",33,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-187501.0}]),
      test_util:expected2(Msg, {number,-187501.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,2.0}]),
      test_util:expected2(Msg, {number,2.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b18_test(doc) -> [{userdata,[{""}]}];
sheet1_b18_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",17,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",17,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,15625.0}]),
      test_util:expected2(Msg, {number,15625.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b29_test(doc) -> [{userdata,[{""}]}];
sheet1_b29_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",28,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",28,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,3.0}]),
      test_util:expected2(Msg, {number,3.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b13_test(doc) -> [{userdata,[{""}]}];
sheet1_b13_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",12,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",12,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Answer"}]),
      test_util:expected2(Msg, {string,"Answer"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b24_test(doc) -> [{userdata,[{""}]}];
sheet1_b24_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",23,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",23,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.0}]),
      test_util:expected2(Msg, {number,1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b35_test(doc) -> [{userdata,[{""}]}];
sheet1_b35_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",34,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",34,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,117608.060801556}]),
      test_util:expected2(Msg, {number,117608.060801556})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,0.5}]),
      test_util:expected2(Msg, {number,0.5})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b19_test(doc) -> [{userdata,[{""}]}];
sheet1_b19_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",18,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",18,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,5.0}]),
      test_util:expected2(Msg, {number,5.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b30_test(doc) -> [{userdata,[{""}]}];
sheet1_b30_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",29,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",29,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-1.0}]),
      test_util:expected2(Msg, {number,-1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b14_test(doc) -> [{userdata,[{""}]}];
sheet1_b14_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",13,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",13,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4.99992855509831}]),
      test_util:expected2(Msg, {number,4.99992855509831})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b25_test(doc) -> [{userdata,[{""}]}];
sheet1_b25_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",24,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",24,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,7.0}]),
      test_util:expected2(Msg, {number,7.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b36_test(doc) -> [{userdata,[{""}]}];
sheet1_b36_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",35,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",35,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,0.03}]),
      test_util:expected2(Msg, {number,0.03})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-2146826281}]),
      test_util:expected2(Msg, {number,-2146826281})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b20_test(doc) -> [{userdata,[{""}]}];
sheet1_b20_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",19,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",19,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4.0}]),
      test_util:expected2(Msg, {number,4.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b31_test(doc) -> [{userdata,[{""}]}];
sheet1_b31_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",30,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",30,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,2.0}]),
      test_util:expected2(Msg, {number,2.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Answer"}]),
      test_util:expected2(Msg, {string,"Answer"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b15_test(doc) -> [{userdata,[{""}]}];
sheet1_b15_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",14,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",14,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,11.0}]),
      test_util:expected2(Msg, {number,11.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b26_test(doc) -> [{userdata,[{""}]}];
sheet1_b26_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",25,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",25,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,9.0}]),
      test_util:expected2(Msg, {number,9.0})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,4.0}]),
      test_util:expected2(Msg, {number,4.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b21_test(doc) -> [{userdata,[{""}]}];
sheet1_b21_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",20,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",20,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,10.0}]),
      test_util:expected2(Msg, {number,10.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_b32_test(doc) -> [{userdata,[{""}]}];
sheet1_b32_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",31,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",31,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-13.0}]),
      test_util:expected2(Msg, {number,-13.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
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
  
