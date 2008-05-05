% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_made_up_fn_names.xls
% Generated on: Mon May 05 12:34:27 +0100 2008

-module(b_made_up_fn_names_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("../../../../excel_files/Win_Excel07_As_97/b_made_up_fn_names.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    Pid=spawn(test_util,test_state,[Data]),
    io:format("in init_per_suite Pid is ~p~n",[Pid]),
    [{?MODULE,Pid}|Config].
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_made_up_fn_names_test_SUITE,{Sheet,Row,Col}).

sheet1_A3(doc) -> [{userdata,[{""}]}];
sheet1_A3(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",2,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",2,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-2146826259}]),
      test_util:expected2(Msg, {number,-2146826259})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_A4(doc) -> [{userdata,[{""}]}];
sheet1_A4(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",3,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",3,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-2146826259}]),
      test_util:expected2(Msg, {number,-2146826259})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_A5(doc) -> [{userdata,[{""}]}];
sheet1_A5(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Tom",4,0}]),
  Pid ! {msg,self(),?MODULE,{"Tom",4,0}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{number,-2146826259}]),
      test_util:expected2(Msg, {number,-2146826259})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
all() -> 
    [sheet1_A3,
   sheet1_A4,
   sheet1_A5
    ].
  
