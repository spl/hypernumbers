%%%-------------------------------------------------------------------
%%% @author gordonguthrie <gordong@hypernumbers.com>
%%% @copyright (C) 2009, gordonguthrie
%%% @doc This is a util module for the superparser. It handles all the
%%% messy stuff for automatic parsing of date/time shortcuts and also
%%% percentages. 
%%%
%%% @end
%%% Created :  5 Jan 2009 by Gordon Guthrie
%%%-------------------------------------------------------------------
-module(super_util).

-include("muin_records.hrl").

-define(upcase(S),ustring:pr(ustring:to_upper(ustring:new(S)))).

-export([autoparse/1,
        upcase/1]).

%%% I apoligise for the poor spelling of color but it is because it
%%% maps to CSS which is yantastic

% autoparses tokens to match date/time formats
autoparse([{int,Int}, {ssnumref, Ref}]) ->
    case string:tokens(Ref, "/") of
        [Month]       ->
            case make_date(Int, tconv:to_i(Month)) of
                {ok, maybe_bad_date} -> {ok, maybe_bad_date};
                Dt                   -> [{datetime, Dt},
                                         {'text-align', "center"}, 
                                         {format, "dd-mmm"}]
            end;                
        [Month, Year] ->
            case make_date(Int, tconv:to_i(Month), tconv:to_i(Year)) of
                {ok, maybe_bad_date} -> {ok, maybe_bad_date};
                Dt                   -> [{datetime, Dt},
                                         {'text-align', "center"}, 
                                         {format, "dd-mmm-yyyy"}]
            end;
        _             -> {ok, maybe_bad_date}
    end;
autoparse([{int,Int}, {ssnumref, Ref}, {int,H}, {':'}, {int, Mn}]) ->
    case string:tokens(Ref, "/") of
        [Month]       ->
            case make_datetime({Int, tconv:to_i(Month)}, {H, Mn}) of
                {ok, maybe_bad_date} -> {ok, maybe_bad_date};
                Dt                   -> [{datetime, Dt},
                                         {'text-align', "center"}, 
                                         {format, "dd-mmm hh:mm"}]
            end;                
        [Month, Year] ->
            case make_datetime({Int, tconv:to_i(Month), tconv:to_i(Year)},
                               {H, Mn}) of
                {ok, maybe_bad_date} -> {ok, maybe_bad_date};
                Dt                   -> [{datetime, Dt},
                                         {'text-align', "center"}, 
                                         {format, "dd-mmm-yyyy hh:mm"}]
            end;                
        _             -> {ok, maybe_bad_date}
    end;
autoparse([{int,Int}, {ssnumref, Ref}, {int,H}, {':'}, {int, Mn}, {':'},
           {int, S}]) ->
    case string:tokens(Ref, "/") of
        [Month]       ->
            case make_datetime({Int, tconv:to_i(Month)}, {H, Mn, S}) of
                {ok, maybe_bad_date} -> {ok, maybe_bad_date};
                Dt             -> [{datetime, Dt},
                                   {'text-align', "center"}, 
                                   {format, "dd-mmm hh:mm:ss"}]
            end;                
        [Month, Year] ->
            case make_datetime({Int, tconv:to_i(Month), tconv:to_i(Year)},
                               {H, Mn, S}) of
                {ok, maybe_bad_date} -> {ok, maybe_bad_date};
                Dt                   -> [{datetime, Dt},
                                         {'text-align', "center"}, 
                                         {format, "dd-mmm-yyyy hh:mm:ss"}]
            end;                
        _             -> {ok, maybe_bad_date}
    end;
autoparse([{int,D}, {'-'}, {int, M}]) ->
    case make_date(D, M) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        Dt                   -> [{datetime, Dt},
                                 {'text-align', "center"}, 
                                 {format, "dd-mmm"}]
    end;
autoparse([{int,D}, {'-'}, {int, M}, {int, H}, {':'}, {int, Mn}]) ->
    case make_datetime({D, M}, {H, Mn}) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        Dt                   -> [{datetime, Dt},
                                 {'text-align', "center"}, 
                                 {format, "dd-mmm hh:mm"}]
    end;
autoparse([{int,D}, {'-'}, {int, M}, {int, H}, {':'}, {int, Mn},
           {':'}, {int, S}]) ->
    case make_datetime({D, M}, {H, Mn, S}) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        Dt                   -> [{datetime, Dt},
                                 {'text-align', "center"}, 
                                 {format, "dd-mmm hh:mm"}]
    end;
autoparse([{int,D}, {'-'}, {int, M}, {'-'}, {int, Y}]) ->
    case make_date(D, M ,Y) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        Dt                   -> [{datetime, Dt},
                                 {'text-align', "center"}, 
                                 {format, "dd-mmm-yyyy"}]
    end;
autoparse([{int,D}, {'-'}, {int, M}, {'-'}, {int, Y}, {int, H},
           {':'}, {int, Mn}]) ->
    case make_datetime({D, M ,Y}, {H, Mn}) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        Dt                   -> [{datetime, Dt},
                                 {'text-align', "center"}, 
                                 {format, "dd-mmm-yyyy hh:mm"}]
    end;
autoparse([{int,D}, {'-'}, {int, M}, {'-'}, {int, Y}, {int, H}, {':'},
           {int, Mn}, {':'}, {int , S}]) ->
    case make_datetime({D, M ,Y}, {H, Mn, S}) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        Dt                   -> [{datetime, Dt},
                                 {'text-align', "center"}, 
                                 {format, "dd-mmm-yyyy hh:mm:ss"}]
    end;
autoparse([{int,H}, {':'}, {int, Mn}]) ->
    case make_time(H, Mn) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        Dt                   -> [{datetime, Dt},
                                 {'text-align', "center"}, 
                                 {format, "hh:mm"}]
    end;
autoparse([{int,H}, {':'}, {int, Mn}, {':'}, {int, S}]) ->
    case make_time(H, Mn, S) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        Dt                   -> [{datetime, Dt},
                                 {'text-align', "center"}, 
                                 {format, "hh:mm:ss PM"}]
    end;
autoparse(_Toks) ->
    {ok, maybe_bad_date}.

%% Converts formula to upper-case, leaving only string literals as-is.
upcase(Str) ->
    {ok, Tokens, _} = superlex:string(Str),
    % List of numbers (codepoints) interspersed with {string, _} tuples.
    Str2 = 
        tl(lists:foldl(fun({stuff, X}, Acc) ->
                               hslists:init(Acc) ++ ([lists:last(Acc)] ++ X);
                          (Tok = {string, _}, Acc) ->
                               Acc ++ [Tok]
                       end,
                       [junk],
                       Tokens)),
    upcase1(Str2, [], []).

%%%
%%% Private functions
%%% 
make_datetime({D, M}, {H, Mn}) ->
    {{Y, _, _}, _} = calendar:now_to_local_time(now()),
    get_datetime({Y, M, D}, {H, Mn, 0});
make_datetime({D, M}, {H, Mn, S}) ->
    {{Y, _, _}, _} = calendar:now_to_local_time(now()),
    get_datetime({Y, M, D}, {H, Mn, S});
make_datetime({D, M, Y}, {H, Mn}) ->
    Y2 = if
             (Y < 99) -> 2000 + Y; %Y3k Bug!
             true     -> Y
         end,
    get_datetime({Y2, M, D}, {H, Mn, 0});
make_datetime({D, M, Y}, {H, Mn, S}) ->
    Y2 = if
             (Y < 99) -> 2000 + Y; %Y3k Bug!
             true     -> Y
         end,
    get_datetime({Y2, M, D}, {H, Mn, S}).

make_date(D, M) ->
    {{Y, _, _}, _} = calendar:now_to_local_time(now()),
    get_datetime({Y, M, D}, {0, 0, 0}).

make_date(D, M, Y) ->
    Y2 = if
             (Y < 99) -> 2000 + Y; %Y3k Bug!
             true     -> Y
         end,
    get_datetime({Y2, M, D}, {0, 0, 0}).

make_time(H, Mn) -> get_datetime({1, 1, 1}, {H, Mn, 0}).

make_time(H, Mn, S) -> get_datetime({1, 1, 1}, {H, Mn, S}).

get_datetime({Y, M, D}, {H, Mn, S}) ->
    case get_datetime2({Y, M, D}, {H, Mn, S}) of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        DateTime             -> DateTime
    end.

get_datetime2({Y, M, D}, {H, Mn, S}) ->
    DateTime = #datetime{date = {Y, M, D}, time = {H, Mn, S}},
    Return = try muin_date:to_rfc1123_string(DateTime)
             catch
                 error:_ -> {ok, maybe_bad_date};
                 exit:_  -> {ok, maybe_bad_date}
             end,
    case Return of
        {ok, maybe_bad_date} -> {ok, maybe_bad_date};
        _                    -> DateTime
    end.

upcase1([Hd | Tl], Intermbuf, Res) when is_number(Hd) ->
    upcase1(Tl, Intermbuf ++ [Hd], Res);
upcase1([{string, Val} | Tl], Intermbuf, Res) ->
    upcase1(Tl, [], lists:append([Res, ?upcase(Intermbuf), Val]));
upcase1([], Intermbuf, Res) ->
    lists:append([Res, ?upcase(Intermbuf)]).
