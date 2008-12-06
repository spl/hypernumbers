%%% @doc Excel-compatible text functions.
%%% @author Hasan Veldstra <hasan@hypernumbers.com>

%%% INCOMPATIBILITY NOTES:
%%%
%%% 1. CHAR in Excel works with Windows ANSI or Mac character sets depending on
%%%    host platform. We work with Unicode.
%%%
%%% 2. Similarly, our implementation of CODE returns a list of the Unicode
%%%    codepoints of the first character in a string.
%%%
%%% Perhaps we can provide compatibility functions, like CHARWIN/CHARMAC and
%%% CODEWIN / CODEMAC, or maybe let our CHAR and CODE work as their namesakes
%%% on Windows Excel, and also have CHARMAC, CODEMAC, and CODEU and CHARU functions.
%%%
%%% In iWork Numbers CODE and CHAR work with Unicode, and there are no compatibility
%%% functions.

-module(stdfuns_text).
-compile(export_all).

-include("handy_macros.hrl").
-include("typechecks.hrl").

-import(tconv, [to_i/1, to_l/1, to_s/1]).

%% Excel 2004 API.
-export([
         %%dollar/2, TODO: Need formats.
         %%pound/2,  TODO: Need formats.
         replace/1,
         %%search/1, TODO:
         %%t/1, TODO: Needs types.
         %%trim/1, TODO:
         %%value/1, TODO: Need formats.
         %%yen/2, TODO: Need formats.
         '&'/1,
         char/1,
         clean/1,
         concatenate/1,
         exact/1,
         find/1,
         fixed/1,
         left/1,
         len/1,
         lower/1,
         mid/1,
         proper/1,
         rept/1,
         right/1,
         substitute/1,
         text/1,
         upper/1
        ]).

%% Default set of rules for text
-define(default_num_rules, [cast_strings, cast_bools,
                            cast_blanks, cast_dates]).
-define(default_str_rules, [cast_numbers, cast_bools,
                            cast_blanks, cast_dates]).

replace([Str,Start,Replace,InsertStr]) ->
    NewStr=?string(Str,?default_str_rules),
    StartInt=?int(Start,?default_num_rules),
    ?ensure(StartInt >= 0,?ERR_VAL),
    ReplaceInt=?int(Replace,?default_num_rules),
    ?ensure(ReplaceInt >= 0,?ERR_VAL),
    io:format("in stdfuns_text:replace StartInt is ~p and ReplaceInt is ~p~n",
              [StartInt,ReplaceInt]),
    NewInsertStr=?string(InsertStr,?default_str_rules),
    if
        (StartInt >= length(NewStr)) -> lists:concat([Str,NewInsertStr]);
        
        true                          ->
            {StartStr,MiddleStr}=lists:split(StartInt-1,NewStr),
            io:format("in stdfuns_text:replace StartStr is ~p MiddleStr is ~p~n",
                      [StartStr,MiddleStr]),
            {_Delete,EndStr}=lists:split(ReplaceInt,MiddleStr),
            lists:concat([StartStr,NewInsertStr,EndStr])
    end.

exact([Str1, Str1]) ->
    true;
exact([Str1, Str2]) -> 
    Rules=[ban_bools,ban_dates,ban_blanks,cast_strings],
    NewStr1 = ?number(Str1,Rules),
    NewStr2 = ?number(Str2,Rules),
    case NewStr1 of
        NewStr2 -> true;
        _       -> false
    end.

len([Str]) when is_float(Str) ->
    case mochinum:digits(Str) of
          "0.0" -> 1;
          S     -> length(S)
         end;
len([Str]) ->
    NewStr=?string(Str,?default_str_rules),
    length(NewStr).

mid([Str, Start, Len]) ->
    NewStr=?string(Str,?default_str_rules),
    NewStart=?int(Start,?default_num_rules),
    ?ensure(NewStart >0, ?ERR_VAL),
    NewLen=?int(Len,?default_num_rules),
    ?ensure(NewLen >0, ?ERR_VAL),
    if
        (NewLen >= length(NewStr)) -> NewStr;
        true                       -> mid1(NewStr,NewStart,NewLen)
    end.

mid1(Str, Start, Len) ->
    string:substr(Str, Start, Len).

clean([true])  -> "TRUE";
clean([false]) -> "FALSE";
clean([Str])   -> NewStr=?string(Str,?default_str_rules),
                  Clean = fun(X) -> (X > 31 andalso X < 123) end,
                  filter(Clean, NewStr).

%% Fixed is a bit of a mess
fixed([Num]) ->
    fixed([Num, 2, false]);
fixed([Num, Decimals]) ->
    fixed1([Num, Decimals, false]);
fixed([Num, Decimals, true]) ->
    fixed1([Num,Decimals,true]);
fixed([Num, Decimals, false]) ->
    fixed1([Num,Decimals,false]).
% all the casting etc is done in the helper
fixed1([Num,Decimals,NoCommas]) ->
    NewNum=?number(Num,?default_num_rules),
    NewDecs=?number(Decimals,?default_num_rules),
    ?ensure(NewDecs =< 127, ?ERR_VAL),
    RoundedNum = stdfuns_math:round([NewNum, NewDecs]) * 1.0,
    Str = ?COND(NewDecs > 0,
                hd(io_lib:format("~." ++ to_l(NewDecs) ++ "f", [RoundedNum])),
                to_l(erlang:trunc(RoundedNum))),
    io:format("in stdfuns_test:fixed1 Str is ~p~n",[Str]),
    case NoCommas of
        true ->
            Str;
        false ->
            [Int,Dec]=string:tokens(Str,"."),
            commify(Int) ++ "."++Dec
    end.

lower([Str]) ->
    string:to_lower(Str).

proper([Str]) ->
    {ok, Words} = regexp:split(Str, "\\s+"),
    Capwords = map(fun([H|T]) -> string:to_upper([H]) ++ T end,
                   Words),
    string:join(Capwords, " ").

upper([Str]) ->
    string:to_upper(Str).

char([V1]) ->
    Code = ?number(V1, [cast_strings, cast_bools, ban_dates, ban_blanks]),
    xmerl_ucs:to_utf8([Code]).

code([Str]) ->
    xmerl_ucs:from_utf8(string:substr(Str, 1)).

find([Substr, Str]) ->
    find([Substr, Str, 1]);
find([Substr, Str, Start]) ->
    SearchStr = string:substr(Str, Start,
                              string:len(Str) - Start + 1), %% Slice from Start to end
    Idx = string:str(SearchStr, Substr),
    Idx + (string:len(Str) - (string:len(Str) - Start + 1)).

left([Str])->
    NewStr=?string(Str,?default_str_rules),
    io:format("in stdfuns_text:left NewStr is ~p~n",[NewStr]),
    [lists:nth(1,NewStr)];
left([Str, Len]) ->
    NewStr=?string(Str,?default_str_rules),
    NewLen=?int(Len,?default_num_rules),
    ?ensure(NewLen >= 0,?ERR_VAL),
    string:substr(NewStr, 1, NewLen).

right([Str])->
    NewStr=?string(Str,?default_str_rules),
    Len=length(NewStr),
    [lists:nth(Len,NewStr)];
right([Str, Len]) ->
    NewStr=?string(Str,?default_str_rules),
    NewLen=?int(Len,?default_num_rules),
    ?ensure(NewLen >= 0,?ERR_VAL),
    TotalLen=length(NewStr),
    if
        (NewLen > TotalLen) -> NewStr;
        true                -> string:substr(Str,TotalLen-NewLen+1,NewLen)
    end.

'&'(Strs) ->
    concatenate(Strs).

concatenate(Str) -> concatenate1(Str,[]).

concatenate1([],Acc) ->
    Acc;
concatenate1([H|T],Acc) when is_float(H) ->
    case mochinum:digits(H) of
        "0.0" -> concatenate1(["0"|T],Acc);
        S     -> concatenate1([S|T],Acc)
    end;
concatenate1([true|T],Acc) ->
    concatenate1(["TRUE"|T],Acc);
concatenate1([false|T],Acc) ->
    concatenate1(["FALSE"|T],Acc);
concatenate1(["0.0"|T],Acc) ->
    concatenate1(["0"|T],Acc);
concatenate1([H|T],Acc) ->
    Str = ?string(H,?default_str_rules),
    NewAcc=Acc++Str,
    concatenate1(T,NewAcc).

rept([Str, Reps]) ->
    NewStr=?string(Str,?default_str_rules),
    NewReps=?int(Reps,?default_num_rules),
    Len=length(NewStr)*NewReps,
    ?ensure(Len < 32767, ?ERR_VAL),
    ?ensure(Len >= 0,    ?ERR_VAL),
    Fun = fun(_) -> (NewStr) end,
    lists:flatten(concatenate([map(Fun, lists:seq(1, NewReps))])).

substitute([Text, Oldtext, Newtext]) ->
    {ok, Res, _Repcnt} = regexp:gsub(Text, Oldtext, Newtext),
    Res.

text([Value, Format]) ->
    {erlang, {_Type, Output}} = format:get_src(Format),
    {ok, {_Color, Fmtdstr}} = format:run_format(Value, Output),
    Fmtdstr.


%%% ----------------- %%%
%%% Private functions %%%
%%% ----------------- %%%

%% Takes an integer (as list), and gives it back formatted with commas.
commify(IntAsStr) when is_list(IntAsStr) ->
  commify(lists:reverse(IntAsStr), $,, []).
commify([A, B, C, D | T], P, Acc) ->
  commify([D|T], P, [P, C, B, A|Acc]);
commify(L, _, Acc) ->
  lists:reverse(L) ++ Acc.
