% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_three_dee_ref.xls
% Generated on: Sun Feb 17 21:41:54 +0000 2008

-module(b_three_dee_ref_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("/Win Excel 2007 (as 97)/b_three_dee_ref.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    Pid=spawn(test_util,test_state,[Data]),
    io:format("in init_per_suite Pid is ~p~n",[Pid]),
    [{?MODULE,Pid}|Config].
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_three_dee_ref_test_SUITE,{Sheet,Row,Col}).

tom_a6_test(doc) -> [{userdata,[{""}]}];
tom_a6_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",5,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",5,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"And now some errors - the sheet bob has been deleted"}]),
      test_util:expected2(Msg, {string,"And now some errors - the sheet bob has been deleted"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_a1_test(doc) -> [{userdata,[{""}]}];
tom_a1_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",0,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",0,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"This Spreadsheet tests 3D references"}]),
      test_util:expected2(Msg, {string,"This Spreadsheet tests 3D references"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_a7_test(doc) -> [{userdata,[{""}]}];
tom_a7_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",6,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",6,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Simple Ref"}]),
      test_util:expected2(Msg, {string,"Simple Ref"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_a2_test(doc) -> [{userdata,[{""}]}];
tom_a2_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",1,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",1,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Simple Ref"}]),
      test_util:expected2(Msg, {string,"Simple Ref"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_a8_test(doc) -> [{userdata,[{""}]}];
tom_a8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",7,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",7,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Simple Range"}]),
      test_util:expected2(Msg, {string,"Simple Range"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_a3_test(doc) -> [{userdata,[{""}]}];
tom_a3_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",2,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",2,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"Simple Range"}]),
      test_util:expected2(Msg, {string,"Simple Range"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_a4_test(doc) -> [{userdata,[{""}]}];
tom_a4_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",3,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",3,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"3D Range"}]),
      test_util:expected2(Msg, {string,"3D Range"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_b7_test(doc) -> [{userdata,[{""}]}];
tom_b7_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",6,1}]),
  Pid ! {msg,self(),?MODULE,{"Tom",6,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=#REF!A1"}]),
      test_util:expected2(Msg, {formula,"=#REF!A1"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_b2_test(doc) -> [{userdata,[{""}]}];
tom_b2_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",1,1}]),
  Pid ! {msg,self(),?MODULE,{"Tom",1,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=Dick!A1"}]),
      test_util:expected2(Msg, {formula,"=Dick!A1"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_b8_test(doc) -> [{userdata,[{""}]}];
tom_b8_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",7,1}]),
  Pid ! {msg,self(),?MODULE,{"Tom",7,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(#REF!A1:D1)"}]),
      test_util:expected2(Msg, {formula,"=SUM(#REF!A1:D1)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_b3_test(doc) -> [{userdata,[{""}]}];
tom_b3_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",2,1}]),
  Pid ! {msg,self(),?MODULE,{"Tom",2,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(Dick!A2:D2)"}]),
      test_util:expected2(Msg, {formula,"=SUM(Dick!A2:D2)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
tom_b4_test(doc) -> [{userdata,[{""}]}];
tom_b4_test(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",3,1}]),
  Pid ! {msg,self(),?MODULE,{"Tom",3,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{formula,"=SUM(Dick:Harry!A1)"}]),
      test_util:expected2(Msg, {formula,"=SUM(Dick:Harry!A1)"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
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
  
