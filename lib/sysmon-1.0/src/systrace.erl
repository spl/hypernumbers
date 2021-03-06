%%% @author    Gordon Guthrie
%%% @copyright (C) 2012-2014, Hypernumbers Ltd
%%% @doc        A module for measuring code performance
%%%
%%% @end
%%% Created : 30 May 2012 by gordon@vixo.com

%%%-------------------------------------------------------------------
%%%
%%% LICENSE
%%%
%%% This program is free software: you can redistribute it and/or modify
%%% it under the terms of the GNU Affero General Public License as
%%% published by the Free Software Foundation version 3
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%% GNU Affero General Public License for more details.
%%%
%%% You should have received a copy of the GNU Affero General Public License
%%% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%%-------------------------------------------------------------------

-module(systrace).

-export([
         profile_dbsrvP/1,
         profile_db_wuP/0,
         profile_dbsrv/1,
         profile_db_wu/0,
         log_profile_site/2,
         profile_site/2
        ]).

-define(SampleTime, 6000). % in microseconds
-define(D, 68).

-record(ts, {
          pid = "",
          tracee = "",
          calls = "",
          time = ""
         }).

log_profile_site(Site, N) when is_integer(N) andalso N > 0 ->
    Dir = code:lib_dir(hypernumbers) ++ "/../../var/logs/",
    Stamp = "." ++ dh_date:format("Y_M_d_H_i_s"),
    "http://" ++ Site2 = Site,
    File = "systrace." ++ Site2 ++ Stamp ++ ".log",
    prof(N, Site, Dir ++ File).

prof(N, Site, File) -> prof2(1, N, Site, File).

prof2(N, N, _Site, _File) ->
    ok;
prof2(N, M, Site, File) ->
    io:format("Profiling ~p (sample ~p of ~p)~n",
              [Site, N, M]),
    profile_site(Site, File),
    prof2(N + 1, M, Site, File).

profile_site(Site, FileName) ->
    {_SiteName, RegProcesses} = syslib:get_registered(Site),
    RP2 = rectify(RegProcesses),
    TraceFlags = [all],
    Fun1 = fun(_PID, X) ->
                  Fns = X:module_info(functions),
                  zip(Fns, X, [])
          end,
    Fun2 = fun(X) ->
                   Logs = profile(X, TraceFlags, Fun1),
                   hn_util:log_terms(Logs, FileName),
                   garbage_collect()
           end,
    [Fun2([X]) || X <- RP2].

profile_db_wuP() -> print(profile_db_wu()).

profile_db_wu() ->
    PIDs = [{all, new_db_wu}],
    TraceFlags = [all],
    Fun1 = fun(_PID, X) ->
                  Fns = X:module_info(functions),
                  Fun2 = fun({X1, Arity}, Acc) ->
                                 Hd = hd(lists:reverse(atom_to_list(X1))),
                                 case Hd of
                                     % ascii matching!
                                     ?D -> [{X, X1, Arity} | Acc];
                                     _  -> Acc
                                 end
                         end,
                   lists:foldl(Fun2, [], Fns)
          end,
    profile(PIDs, TraceFlags, Fun1).

profile_dbsrvP(Site) -> print(profile_dbsrv(Site)).

profile_dbsrv(Site) ->
    Id = hn_util:site_to_atom(Site, "_dbsrv"),
    PID = whereis(Id),
    TraceFlags = [all],
    Fun = fun(_PID, X) ->
                  Fns = X:module_info(functions),
                  zip(Fns, X, [])
          end,
    profile([{PID, dbsrv}], TraceFlags, Fun).

profile(PIDs, TraceFlags, TraceeFun) ->
    % first set up the tracing
    Fun1 = fun({PID, Mod}) ->
                   erlang:trace(PID, true, TraceFlags),
                   erlang:trace_pattern({Mod, '_', '_'}, true,
                                        [local, call_time])
           end,
    [Fun1(X) || X <- PIDs],
    % now sample
    Fun2 = fun({PID, Mod}) ->
                   Tracees = TraceeFun(PID, Mod),
                   timer:sleep(?SampleTime),
                   Fun3 = fun(Term) ->
                                  Trace = erlang:trace_info(Term, call_time),
                                  case Trace of
                                      {call_time, []} ->
                                          [];
                                      {call_time, Time} ->
                                          case pid_time(Time, PID) of
                                              no_match ->
                                                  [];
                                              Times ->
                                                  format(Times, Term, [])
                                          end
                                  end
                          end,
                   {PID, Mod, lists:flatten([Fun3(X) || X <- Tracees])}
           end,
    Timings = [Fun2(X) || X <- PIDs],
    % now tidy up
    [erlang:trace(PID, false, [all]) || {PID, _M} <- PIDs],
    % return the timings
    Timings.

format([], _Term, Acc) ->
    lists:reverse(Acc);
format([H | T], Term, Acc) ->
    {P, C, S, Ms} = H,
    Total = (S * 1000 + Ms)/1000,
    NewAcc = #ts{pid = P, tracee = Term, calls = C, time = Total},
    format(T, Term, [NewAcc | Acc]).

print([]) ->
    ok;
print([{PID, Mod, []} | T]) ->
    io:format("No activity for ~p on ~p~n", [Mod, PID]),
    print(T);
print([{PID, Mod, H} | T]) ->
    Fun = fun(#ts{time = Tm}, Acc) ->
                  Acc + Tm
          end,
    Total = lists:foldl(Fun, 0, H),
    io:format("Total is ~p for ~p on ~p~n", [Total, Mod, PID]),
    p2(H, Total),
    print(T).

p2([], _Total) -> ok;
p2([H | T], Total) ->
    io:format("H is ~p~n", [H]),
    #ts{tracee = Tracee, calls = C, time = Tm} = H,
    case Tracee of
        {Mod, Fn, Arity} ->
            case {Total, C} of
                {Zero, C} when (Zero == 0 orelse Zero == 0.0)
                andalso (C == 0 orelse C == 0.0) ->
                    io:format("~p,~p,~p,~p,~p,-,-~n",
                              [Mod, Fn, Arity, C, Tm]);
                {Zero, _} when Zero == 0 orelse Zero == 0.0 ->
                    io:format("~p,~p,~p,~p,~p,-,~p~n",
                              [Mod, Fn, Arity, C, Tm, Tm/C]);
                {_, C} when C == 0 orelse C == 0.0 ->
                    % don't print nothing
                    ok;
                _Other ->
                    io:format("~p,~p,~p,~p,~p,~p%,~p~n",
                              [Mod, Fn, Arity, C, Tm, (Tm/Total)*100, Tm/C])
            end;
        Term ->
            case {Total, C} of
                {Zero, C} when (Zero == 0 orelse Zero == 0.0)
                andalso (C == 0 orelse C == 0.0) ->
                    io:format("~p,~p,~p,-,-~n",
                              [Term, C, Tm]);
                {Zero, _} when Zero == 0 orelse Zero == 0.0 ->
                    io:format("~p,~p,~p,-,~p~n",
                              [Term, C, Tm, Tm/C]);
                {_, C} when C == 0 orelse C == 0.0 ->
                    % don't print nothing
                    ok;
                _Other ->
                    io:format("~p,~p,~p,~p%,~p~n",
                              [Term, C, Tm, (Tm/Total)*100, Tm/C])
            end
    end,
    p2(T, Total).

rectify(List) -> r2(List, []).

r2([], Acc)           -> Acc;
r2([{N, P}| T], Acc) -> r2(T, [{P, rect(N)} | Acc]).

rect("dbsrv")     -> dbsrv;
rect("dbsrv_sup") -> dbsrv;
rect("auth")      -> auth_srv;
rect("tick")      -> tick_srv;
rect("status")    -> status_srv;
rect("pages")     -> page_srv;
rect("remoting")  -> remoting_reg;
rect("sup")       -> sitemaster_sup;
rect("phonecall") -> phonecall_sup;
rect("calc_sup")  -> calc_sup;
rect("zinf")      -> zinf_srv.

pid_time([], _PID)                       -> no_match;
pid_time([{PID, _, _, _} = H | _T], PID) -> [H];
pid_time(List, all)                      -> List;
pid_time([_H | T], PID)                  -> pid_time(T, PID).

zip([], _A, Acc)          -> lists:reverse(Acc);
zip([{B, C} | T], A, Acc) -> zip(T, A, [{A, B, C} | Acc]).

