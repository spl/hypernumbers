% This module has been generated by gen_rev_comp_test.rb
% DO NOT EDIT MANUALLY.
%
% Source file: b_basic_unicode_strings.xls
% Generated on: Mon May 05 12:34:26 +0100 2008

-module(b_basic_unicode_strings_test_SUITE).
-compile(export_all).
-include("ct.hrl").


init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:setup_paths(),
    Data = test_util:read_excel_file("../../../../excel_files/Win_Excel07_As_97/b_basic_unicode_strings.xls"),
    %% io:format("in init_per_suite Data is ~p~n",[Data]),
    Pid=spawn(test_util,test_state,[Data]),
    io:format("in init_per_suite Pid is ~p~n",[Pid]),
    [{?MODULE,Pid}|Config].
  
end_per_suite(_Config) ->
    ok.
  
init_per_testcase(_TestCase, Config) -> Config.

end_per_testcase(_TestCase, _Config) -> ok.

read_from_excel_data(Config,{Sheet,Row,Col}) ->
  test_util:read_from_excel_data(Config,b_basic_unicode_strings_test_SUITE,{Sheet,Row,Col}).

sheet1_B2(doc) -> [{userdata,[{""}]}];
sheet1_B2(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",1,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",1,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"β"}]),
      test_util:expected2(Msg, {string,"β"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"kfdks45678dkβsfjk"}]),
      test_util:expected2(Msg, {string,"kfdks45678dkβsfjk"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"áâãäåæ"}]),
      test_util:expected2(Msg, {string,"áâãäåæ"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ĀāĂăĄą"}]),
      test_util:expected2(Msg, {string,"ĀāĂăĄą"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ƒǺǻǼǽǾ"}]),
      test_util:expected2(Msg, {string,"ƒǺǻǼǽǾ"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"aˆbˇcˇdˉeˉf˘g˘h˙i˙"}]),
      test_util:expected2(Msg, {string,"aˆbˇcˇdˉeˉf˘g˘h˙i˙"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"àb́ĉd̃̄ĕḟ̈̊g̋ȟ"}]),
      test_util:expected2(Msg, {string,"àb́ĉd̃̄ĕḟ̈̊g̋ȟ"})
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
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ʹ͵;΄΅Ά·ΈΑΒΓΔ"}]),
      test_util:expected2(Msg, {string,"ʹ͵;΄΅Ά·ΈΑΒΓΔ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B12(doc) -> [{userdata,[{""}]}];
sheet1_B12(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",11,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",11,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ЀЁЉЊЋЌЍ"}]),
      test_util:expected2(Msg, {string,"ЀЁЉЊЋЌЍ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B13(doc) -> [{userdata,[{""}]}];
sheet1_B13(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",12,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",12,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ẀẁẂẃẄẅỲỳ"}]),
      test_util:expected2(Msg, {string,"ẀẁẂẃẄẅỲỳ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B14(doc) -> [{userdata,[{""}]}];
sheet1_B14(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",13,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",13,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"‐–—―‘’‚"}]),
      test_util:expected2(Msg, {string,"‐–—―‘’‚"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B15(doc) -> [{userdata,[{""}]}];
sheet1_B15(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",14,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",14,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"⁰⁴⁵⁶₇₈₉₊₋₌₍₎"}]),
      test_util:expected2(Msg, {string,"⁰⁴⁵⁶₇₈₉₊₋₌₍₎"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B16(doc) -> [{userdata,[{""}]}];
sheet1_B16(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",15,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",15,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"€"}]),
      test_util:expected2(Msg, {string,"€"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B17(doc) -> [{userdata,[{""}]}];
sheet1_B17(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",16,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",16,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ℓ№℗℠™Ω"}]),
      test_util:expected2(Msg, {string,"ℓ№℗℠™Ω"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B18(doc) -> [{userdata,[{""}]}];
sheet1_B18(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",17,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",17,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"⅓⅔⅕⅖⅗⅘"}]),
      test_util:expected2(Msg, {string,"⅓⅔⅕⅖⅗⅘"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B19(doc) -> [{userdata,[{""}]}];
sheet1_B19(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",18,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",18,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"←↑→↓↔↕↖↗↘↙"}]),
      test_util:expected2(Msg, {string,"←↑→↓↔↕↖↗↘↙"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B20(doc) -> [{userdata,[{""}]}];
sheet1_B20(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",19,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",19,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"∂∆∏∑"}]),
      test_util:expected2(Msg, {string,"∂∆∏∑"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B21(doc) -> [{userdata,[{""}]}];
sheet1_B21(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",20,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",20,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"◊"}]),
      test_util:expected2(Msg, {string,"◊"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B22(doc) -> [{userdata,[{""}]}];
sheet1_B22(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",21,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",21,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ﬀﬁﬂﬃﬄ"}]),
      test_util:expected2(Msg, {string,"ﬀﬁﬂﬃﬄ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B25(doc) -> [{userdata,[{""}]}];
sheet1_B25(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",24,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",24,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"β"}]),
      test_util:expected2(Msg, {string,"β"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B26(doc) -> [{userdata,[{""}]}];
sheet1_B26(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",25,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",25,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"kfdks45678dkβsfjk"}]),
      test_util:expected2(Msg, {string,"kfdks45678dkβsfjk"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B27(doc) -> [{userdata,[{""}]}];
sheet1_B27(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",26,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",26,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"áâãäåæ"}]),
      test_util:expected2(Msg, {string,"áâãäåæ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B28(doc) -> [{userdata,[{""}]}];
sheet1_B28(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",27,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",27,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ĀāĂăĄą"}]),
      test_util:expected2(Msg, {string,"ĀāĂăĄą"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B29(doc) -> [{userdata,[{""}]}];
sheet1_B29(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",28,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",28,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ƒǺǻǼǽǾ"}]),
      test_util:expected2(Msg, {string,"ƒǺǻǼǽǾ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B30(doc) -> [{userdata,[{""}]}];
sheet1_B30(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",29,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",29,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"aˆbˇcˇdˉeˉf˘g˘h˙i˙"}]),
      test_util:expected2(Msg, {string,"aˆbˇcˇdˉeˉf˘g˘h˙i˙"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B31(doc) -> [{userdata,[{""}]}];
sheet1_B31(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",30,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",30,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"àb́ĉd̃̄ĕḟ̈̊g̋ȟ"}]),
      test_util:expected2(Msg, {string,"àb́ĉd̃̄ĕḟ̈̊g̋ȟ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B32(doc) -> [{userdata,[{""}]}];
sheet1_B32(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",31,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",31,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ʹ͵;΄΅Ά·ΈΑΒΓΔ"}]),
      test_util:expected2(Msg, {string,"ʹ͵;΄΅Ά·ΈΑΒΓΔ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B33(doc) -> [{userdata,[{""}]}];
sheet1_B33(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",32,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",32,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ЀЁЉЊЋЌЍ"}]),
      test_util:expected2(Msg, {string,"ЀЁЉЊЋЌЍ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B34(doc) -> [{userdata,[{""}]}];
sheet1_B34(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",33,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",33,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ẀẁẂẃẄẅỲỳ"}]),
      test_util:expected2(Msg, {string,"ẀẁẂẃẄẅỲỳ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B35(doc) -> [{userdata,[{""}]}];
sheet1_B35(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",34,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",34,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"‐–—―‘’‚"}]),
      test_util:expected2(Msg, {string,"‐–—―‘’‚"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B36(doc) -> [{userdata,[{""}]}];
sheet1_B36(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",35,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",35,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"⁰⁴⁵⁶₇₈₉₊₋₌₍₎"}]),
      test_util:expected2(Msg, {string,"⁰⁴⁵⁶₇₈₉₊₋₌₍₎"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B37(doc) -> [{userdata,[{""}]}];
sheet1_B37(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",36,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",36,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"€"}]),
      test_util:expected2(Msg, {string,"€"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B38(doc) -> [{userdata,[{""}]}];
sheet1_B38(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",37,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",37,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ℓ№℗℠™Ω"}]),
      test_util:expected2(Msg, {string,"ℓ№℗℠™Ω"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B39(doc) -> [{userdata,[{""}]}];
sheet1_B39(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",38,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",38,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"⅓⅔⅕⅖⅗⅘"}]),
      test_util:expected2(Msg, {string,"⅓⅔⅕⅖⅗⅘"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B40(doc) -> [{userdata,[{""}]}];
sheet1_B40(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",39,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",39,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"←↑→↓↔↕↖↗↘↙"}]),
      test_util:expected2(Msg, {string,"←↑→↓↔↕↖↗↘↙"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B41(doc) -> [{userdata,[{""}]}];
sheet1_B41(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",40,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",40,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"∂∆∏∑"}]),
      test_util:expected2(Msg, {string,"∂∆∏∑"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B42(doc) -> [{userdata,[{""}]}];
sheet1_B42(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",41,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",41,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"◊"}]),
      test_util:expected2(Msg, {string,"◊"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
sheet1_B43(doc) -> [{userdata,[{""}]}];
sheet1_B43(Config) -> 
  {value,{_,Pid}}=lists:keysearch(?MODULE,1,Config),
  io:format("in test case Pid is ~p MODULE is ~p~n Key is ~p",[Pid,?MODULE,{"Sheet1",42,1}]),
  Pid ! {msg,self(),?MODULE,{"Sheet1",42,1}},
  receive
    Msg -> 
      io:format("Expected is :~p~nGot is      :~p~n",[Msg,{string,"ﬀﬁﬂﬃﬄ"}]),
      test_util:expected2(Msg, {string,"ﬀﬁﬂﬃﬄ"})
  after
    500 -> io:format("timed out in test case!~n"),
            exit("die in flames!")
  end.
  
all() -> 
    [sheet1_B2,
   sheet1_B3,
   sheet1_B6,
   sheet1_B7,
   sheet1_B8,
   sheet1_B9,
   sheet1_B10,
   sheet1_B11,
   sheet1_B12,
   sheet1_B13,
   sheet1_B14,
   sheet1_B15,
   sheet1_B16,
   sheet1_B17,
   sheet1_B18,
   sheet1_B19,
   sheet1_B20,
   sheet1_B21,
   sheet1_B22,
   sheet1_B25,
   sheet1_B26,
   sheet1_B27,
   sheet1_B28,
   sheet1_B29,
   sheet1_B30,
   sheet1_B31,
   sheet1_B32,
   sheet1_B33,
   sheet1_B34,
   sheet1_B35,
   sheet1_B36,
   sheet1_B37,
   sheet1_B38,
   sheet1_B39,
   sheet1_B40,
   sheet1_B41,
   sheet1_B42,
   sheet1_B43
    ].
  
