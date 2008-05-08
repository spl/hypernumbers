%%% Stats functions fosho.
%%% <hasan@hypernumbers.com>

%%% IMPORTANT NOTES:
%%%
%%% In CHIDIST(X, DegreesOfFreedom) in Excel DegreesOfFreedom is capped at
%%% 10^10. We're doing that too (for now anyway).
%%%
%%% 

-module(stdfuns_stats).

-include("handy_macros.hrl").
-include("typechecks.hrl").
-import(muin_util, [conv/2, cast/2]).

-export([
         avedev/1,
         average/1,
         averagea/1,
         %%averageif/1,
         %%averageifs/1,
         %%betadist/1,
         %%betainv/1,
         binomdist/1,
         chidist/1,
         %%chiinv/1,
         %%chitest/1,
         %%confidence/1,
         correl/1,
         count/1,
         %%counta/1,
         countblank/1,
         %%countif/1,
         %%countifs/1,
         covar/1,
         critbinom/1,
         devsq/1,
         expondist/1,
         %%fdist/1,
         %%finv/1,
         %%fisher/1,
         %%fisherinv/1,
         forecast/1,
         frequency/1,
         %%ftest/1,
         gammadist/1,
         %%gammainv/1,
         %%gammaln/1,
         %%geomean/1,
         %%growth/1,
         %%harmean/1,
         %%hypgeomdist/1,
         intercept/1,
         kurt/1,
         large/1,
         linest/1,
         %%logest/1,
         %%loginv/1,
         %%lognormdist/1,
         max/1,
         maxa/1,
         median/1,

         percentile/1,
         quartile/1
        ]).

avedev(Vals) ->
    Flatvals = flatten(Vals),
    ?ensure_no_errvals(Flatvals),
    Nums = [X || X <- Flatvals, is_number(X)],
    ?ensure_nonzero(length(Nums)),
    avedev1(Nums).
avedev1(Nums) ->
    Avg = average1(Nums),
    Deviation = foldl(fun(X, Acc) ->
                              Acc + erlang:abs(Avg - X)
                      end,
                      0,
                      Nums),
    Deviation / length(Nums).

average(Vals) ->
    Flatvals = flatten(Vals),
    ?ensure_no_errvals(Flatvals),
    Nums = [X || X <- Flatvals, is_number(X)],
    ?ensure_nonzero(length(Nums)),
    average1(Nums).
average1(Nums) ->
    lists:sum(Nums) / length(Nums).

averagea(Vals) ->
    Flatvals = flatten(Vals),
    ?ensure_no_errvals(Flatvals),
    MaybeNums = map(fun(X) -> conv(X, num) end, Flatvals),
    %% Now convert {error, value}s that may be there to 0s.
    Nums = foldl(fun({error, value}, Acc) ->
                         Acc ++ [0];
                    (X, Acc) ->
                         Acc ++ [X]
                 end,
                 [],
                 MaybeNums),
    ?ensure_nonzero(Nums),
    average1(Nums).

binomdist([Succn_, Trials_, Succprob, Cumul]) ->
    ?ensure_numbers([Succn_, Trials_, Succprob]),
    Succn = erlang:trunc(Succn_),
    Trials = erlang:trunc(Trials_),
    ?ensure(Succn =< Trials, ?ERR_NUM),
    ?ensure_non_negatives([Succn, Succprob]),
    ?ensure(Succprob =< 1, ?ERR_NUM),
    ?ensure(is_boolean(Cumul), ?ERR_VAL),
    binomdist1(Succn, Trials, Succprob, Cumul).
binomdist1(Ns, Nt, Ps, false) ->
    stdfuns_math:combin([Nt, Ps]) * math:pow(Ps, Ns) * math:pow((1 - Ps),
                                                                (Nt - Ns));
%% TODO: Rewrite to tail-recursive.
binomdist1(Ns, Nt, Ps, true) ->
    binomdist1(Ns, Nt, Ps, false) + binomdist1(Ns - 1, Nt, Ps, true).

chidist([X, Degfree_]) ->
    ?ensure_numbers([X, Degfree_]),
    Degfree = erlang:trunc(Degfree_),
    ?ensure_non_negative(X),
    ?ensure(Degfree >= 1, ?ERR_NUM),
    ?ensure(Degfree =< 1.0e+10, ?ERR_NUM),
    chidist1(X, Degfree).
chidist1(X, Degfree) ->
    Alpha = Degfree / 2, % 2 is beta
    Chi = 1 / (math:pow(2, Alpha) * stdfuns_math:fact1(Alpha)),
    math:pow(Chi, (Alpha - 1)) * math:exp(X * -0.5).

correl([L1, L2]) ->
    _Nums1 = ?filter_numbers(?ensure_no_errvals(?flatten(L1))),
    _Nums2 = ?filter_numbers(?ensure_no_errvals(?flatten(L2))),
    0. %% TODO:

count([L0]) ->
    L = ?flatten(L0),
    Nums = ?filter_numbers(L),
    Dates = [X || X <- L, element(1, X) == date],
    Strs  = [X || X <- L, tconv:to_num(X) =/= {error, nan}],
    length(Nums) + length(Dates) + length(Strs).
                 
countblank([L]) ->
    length([X || X <- L, X == blank]).

covar([L1, L2]) ->
    Ary1 = ?filter_numbers(L1),
    Ary2 = ?filter_numbers(L2),
    ?ensure_nonzero(length(Ary1)),
    ?ensure_nonzero(length(Ary2)),
    ?ensure(length(Ary1) == length(Ary2), ?ERR_NA),
    covar1(Ary1, Ary2).
covar1(_Ary1, _Ary2) ->
    0. %% TODO:

critbinom([Trials0, Prob, Alpha]) ->
    ?ensure_numbers([Trials0, Prob, Alpha]),
    ?ensure(Trials0 >= 0, ?ERR_NUM),
    ?ensure(Prob >= 0 andalso Prob =< 1, ?ERR_NUM),
    ?ensure(Alpha >= 0 andalso Alpha =< 1, ?ERR_NUM),
    critbinom1(trunc(Trials0), Prob, Alpha, 0).
critbinom1(Trials, Prob, Alpha, X) ->    
    Val = binomdist1(X, Trials, Prob, true),
    ?COND(Val >= Alpha,
          X,
          critbinom1(Trials, Prob, Alpha, X + 1)).

devsq([L]) ->
    Vals = ?filter_numbers(?ensure_no_errvals(?flatten(L))),
    devsq1(Vals).
devsq1(Vals) ->
    moment(Vals, 2) * length(Vals).

expondist([X, Lambda, Cum]) ->
    ?ensure_numbers([X, Lambda]),
    ?ensure_non_negatives([X, Lambda]),
    expondist1(X, Lambda, cast(Cum, bool)).
expondist1(X, Lambda, true) ->
    1 - math:exp(-1 * X / Lambda);
expondist1(X, Lambda, false) ->
    math:exp(-1 * X / Lambda) / Lambda.

forecast([N, L1, L2]) ->
    ?ensure_number(N),
    Kys = ?filter_numbers(?ensure_no_errvals(?flatten(L1))),
    Kxs = ?filter_numbers(?ensure_no_errvals(?flatten(L2))),
    ?ensure(length(Kys) > 0 andalso length(Kys) == length(Kxs), ?ERR_NA),
    forecast1(N, Kys, Kxs).
forecast1(X, Kys, Kxs) ->
    {matrix, [B1, B0]} = linest1(Kys, Kxs),
    B1 * X + B0.

frequency([L1, L2]) ->
    Data = ?filter_numbers(?ensure_no_errvals(?flatten(L1))),
    Bins = ?filter_numbers(?ensure_no_errvals(?flatten(L2))),
    frequency1(Data, Bins).
frequency1(_Data, _Bins) ->
    0. %% TODO:

gammadist([X, Alpha, Beta, Cum]) ->
    ?ensure_numbers([X, Alpha, Beta]),
    ?ensure_non_negative(X),
    ?ensure_positive(Alpha),
    ?ensure_positive(Beta),
    gammadist1(X, Alpha, Beta, cast(Cum, bool)).
gammadist1(X, Alpha, Beta, false) ->
    Top = math:pow(X, Alpha - 1) * math:exp(-1 * X / Beta),
    Top / (math:pow(Beta, Alpha) * stdfuns_math:fact1(round(Alpha)));
gammadist1(_X, _Alpha, _Beta, true) ->
    0. %% TODO:

intercept([L1, L2]) ->
    Kys = ?filter_numbers(?ensure_no_errvals(?flatten(L1))),
    Kxs = ?filter_numbers(?ensure_no_errvals(?flatten(L2))),
    intercept1(Kys, Kxs).
intercept1(Kys, Kxs) ->
    {matrix, [M, C]} = linest1(Kys, Kxs),
    C / M.

kurt([L]) ->
    Nums = ?filter_numbers(?ensure_no_errvals(?flatten(L))),
    ?ensure(length(Nums) > 3, ?ERR_DIV),
    kurt1(Nums).
kurt1(Nums) ->
    (moment(Nums, 4) / math:pow(moment(Nums, 2), 2)) - 3.

large([L, K]) ->
    Nums = ?filter_numbers(?ensure_no_errvals(?flatten(L))),
    ?ensure(length(Nums) > 0, ?ERR_NUM),
    ?ensure_number(K),
    ?ensure_positive(K),
    ?ensure(length(Nums) >= K, ?ERR_NUM),
    large1(Nums, K).
large1(Nums, K) ->
    nth(K, reverse(sort(Nums))).

linest(_) ->
    linest1(0, 0).
linest1(_, _) ->
    {matrix, [0, 0]}. %% TODO:

max([L]) ->
    Flatl = ?ensure_no_errvals(?flatten(L)),
    Nums = map(fun(X) when is_number(X) ->
                       X;
                  (S) when is_list(S) ->
                       case tconv:to_num(S) of
                           {error, nan} -> ?ERR_VAL;
                           V            -> V
                       end
               end,
               Flatl),
    ?COND(length(Nums) == 0, 0, lists:max(Nums)).
    
maxa([L]) ->
    Flatl = ?ensure_no_errvals(?flatten(L)),
    Nums = map(fun(X) -> cast(X, num) end, Flatl),
    ?COND(length(Nums) == 0, 0, lists:max(Nums)).

median([L]) ->
    Nums = ?filter_numbers(?ensure_no_errvals(?flatten(L))),
    quartile1(Nums, 2).

percentile([L, K]) ->
    Nums = ?filter_numbers(?ensure_no_errvals(?flatten(L))),
    ?ensure(length(Nums) > 0, ?ERR_NUM),
    ?ensure_number(K),
    ?ensure((K >= 0) and (K =< 1), ?ERR_NUM),
    percentile1(Nums, K).
percentile1(_Nums, _K) ->
    0. %% TODO:


quartile([L, Q]) ->
    Nums = ?filter_numbers(?ensure_no_errvals(?flatten(L))),
    ?ensure(length(Nums) > 0, ?ERR_NUM),
    ?ensure_number(Q),
    ?ensure((Q >= 0) and (Q =< 4), ?ERR_NUM),
    quartile1(Nums, trunc(Q)).
quartile1(Nums, Q) ->
    nth(percentile1(Nums, Q * 0.25), Nums).

    


%%% Private functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

moment(Vals, M) ->
    Avg = average1(Vals),
    lists:foldl(fun(X, Acc) -> Acc + math:pow((Avg - X), M) end,
                0, Vals) / length(Vals).
