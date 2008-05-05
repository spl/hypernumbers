% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_simple_arrays_and_ranges.xls
% Generated on: Mon May 05 12:34:30 +0100 2008

-module(b_simple_arrays_and_ranges_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("../../../../excel_files/Win_Excel07_As_97/b_simple_arrays_and_ranges.xls"),
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

sheet1_B1(doc) -> [{userdata,[{""}]}];
sheet1_B1(Config) -> 
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
  
sheet1_C1(doc) -> [{userdata,[{""}]}];
sheet1_C1(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",0,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",0,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,1.0}]),
      test_util:expected2(Msg, {number,1.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B2(doc) -> [{userdata,[{""}]}];
sheet1_B2(Config) -> 
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
  
sheet1_C2(doc) -> [{userdata,[{""}]}];
sheet1_C2(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",1,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",1,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"2"}]),
      test_util:expected2(Msg, {string,"2"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B3(doc) -> [{userdata,[{""}]}];
sheet1_B3(Config) -> 
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
  
sheet1_C3(doc) -> [{userdata,[{""}]}];
sheet1_C3(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",2,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",2,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{boolean,true}]),
      test_util:expected2(Msg, {boolean,true})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B4(doc) -> [{userdata,[{""}]}];
sheet1_B4(Config) -> 
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
  
sheet1_C4(doc) -> [{userdata,[{""}]}];
sheet1_C4(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",3,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",3,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-2146826288}]),
      test_util:expected2(Msg, {number,-2146826288})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B5(doc) -> [{userdata,[{""}]}];
sheet1_B5(Config) -> 
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
  
sheet1_C5(doc) -> [{userdata,[{""}]}];
sheet1_C5(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",4,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",4,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,2.0}]),
      test_util:expected2(Msg, {number,2.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B6(doc) -> [{userdata,[{""}]}];
sheet1_B6(Config) -> 
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
  
sheet1_C6(doc) -> [{userdata,[{""}]}];
sheet1_C6(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",5,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",5,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,33.0}]),
      test_util:expected2(Msg, {number,33.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B7(doc) -> [{userdata,[{""}]}];
sheet1_B7(Config) -> 
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
  
sheet1_C7(doc) -> [{userdata,[{""}]}];
sheet1_C7(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",6,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",6,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,44.0}]),
      test_util:expected2(Msg, {number,44.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_A8(doc) -> [{userdata,[{""}]}];
sheet1_A8(Config) -> 
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
  
sheet1_B8(doc) -> [{userdata,[{""}]}];
sheet1_B8(Config) -> 
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
  
sheet1_C8(doc) -> [{userdata,[{""}]}];
sheet1_C8(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",7,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",7,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,6.0}]),
      test_util:expected2(Msg, {number,6.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_D8(doc) -> [{userdata,[{""}]}];
sheet1_D8(Config) -> 
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
  
sheet1_E8(doc) -> [{userdata,[{""}]}];
sheet1_E8(Config) -> 
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
  
sheet1_F8(doc) -> [{userdata,[{""}]}];
sheet1_F8(Config) -> 
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
  
sheet1_A9(doc) -> [{userdata,[{""}]}];
sheet1_A9(Config) -> 
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
  
sheet1_B9(doc) -> [{userdata,[{""}]}];
sheet1_B9(Config) -> 
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
  
sheet1_C9(doc) -> [{userdata,[{""}]}];
sheet1_C9(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",8,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",8,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,555.0}]),
      test_util:expected2(Msg, {number,555.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_D9(doc) -> [{userdata,[{""}]}];
sheet1_D9(Config) -> 
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
  
sheet1_E9(doc) -> [{userdata,[{""}]}];
sheet1_E9(Config) -> 
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
  
sheet1_F9(doc) -> [{userdata,[{""}]}];
sheet1_F9(Config) -> 
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
  
sheet1_G9(doc) -> [{userdata,[{""}]}];
sheet1_G9(Config) -> 
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
  
sheet1_B10(doc) -> [{userdata,[{""}]}];
sheet1_B10(Config) -> 
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
  
sheet1_C10(doc) -> [{userdata,[{""}]}];
sheet1_C10(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",9,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",9,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,2442.0}]),
      test_util:expected2(Msg, {number,2442.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_D10(doc) -> [{userdata,[{""}]}];
sheet1_D10(Config) -> 
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
  
sheet1_E10(doc) -> [{userdata,[{""}]}];
sheet1_E10(Config) -> 
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
  
sheet1_F10(doc) -> [{userdata,[{""}]}];
sheet1_F10(Config) -> 
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
  
sheet1_G10(doc) -> [{userdata,[{""}]}];
sheet1_G10(Config) -> 
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
  
sheet1_B11(doc) -> [{userdata,[{""}]}];
sheet1_B11(Config) -> 
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
  
sheet1_C11(doc) -> [{userdata,[{""}]}];
sheet1_C11(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",10,2}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",10,2}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,34.0}]),
      test_util:expected2(Msg, {number,34.0})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_D11(doc) -> [{userdata,[{""}]}];
sheet1_D11(Config) -> 
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
  
sheet1_E11(doc) -> [{userdata,[{""}]}];
sheet1_E11(Config) -> 
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
  
sheet1_F11(doc) -> [{userdata,[{""}]}];
sheet1_F11(Config) -> 
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
  
sheet1_G11(doc) -> [{userdata,[{""}]}];
sheet1_G11(Config) -> 
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
  
sheet1_H11(doc) -> [{userdata,[{""}]}];
sheet1_H11(Config) -> 
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
  
sheet1_I11(doc) -> [{userdata,[{""}]}];
sheet1_I11(Config) -> 
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
    [sheet1_B1,
   sheet1_C1,
   sheet1_B2,
   sheet1_C2,
   sheet1_B3,
   sheet1_C3,
   sheet1_B4,
   sheet1_C4,
   sheet1_B5,
   sheet1_C5,
   sheet1_B6,
   sheet1_C6,
   sheet1_B7,
   sheet1_C7,
   sheet1_A8,
   sheet1_B8,
   sheet1_C8,
   sheet1_D8,
   sheet1_E8,
   sheet1_F8,
   sheet1_A9,
   sheet1_B9,
   sheet1_C9,
   sheet1_D9,
   sheet1_E9,
   sheet1_F9,
   sheet1_G9,
   sheet1_B10,
   sheet1_C10,
   sheet1_D10,
   sheet1_E10,
   sheet1_F10,
   sheet1_G10,
   sheet1_B11,
   sheet1_C11,
   sheet1_D11,
   sheet1_E11,
   sheet1_F11,
   sheet1_G11,
   sheet1_H11,
   sheet1_I11
    ].
  
