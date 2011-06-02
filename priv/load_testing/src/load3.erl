-module(load3).

-export([
         load/0,
         fprof/0
        ]).

-record(refX,
        {
          site        = [],
          type,
          path        = [],
          obj         = null
         }).

-define(size, 100).
-define(site, "http://hypernumbers.dev:9000").
-define(doublequote, 34). % use insted of $"

fprof() ->
    Dir = "/media/logging/",
    Now = dh_date:format("y_M_d_h_i_s"),
    Log = Dir ++ "fprof_" ++ Now ++ ".log",
    Analysis = Dir ++ "fprof_analysis" ++ Now ++ ".log",
    fprof:trace([start, {file, Log}, {procs, all}]),
    Seg1 = "fprof_page",
    Seg2 = "data",
    RefX1 = #refX{site = ?site, path = [Seg1], obj = {page, "/"}},
    RefX2 = #refX{site = ?site, path = [Seg1, Seg2], obj = {page, "/"}},
    io:format("loading ~p~n", [RefX1]),
    ok = hn_templates:load_template(RefX1, "meter_page"),
    io:format("loading ~p~n", [RefX2]),
    ok = hn_templates:load_template(RefX2, "data"),
    new_db_api:wait_for_dirty(?site),
    fprof:trace(stop),
    fprof:profile([{file, Log}]),
    fprof:analyse([{dest, Analysis}]),
    ok.

load() -> Templates = ["meter_page", "data"],
          copy(Templates),
          l2(?size).

l2(0) -> ok;
l2(N) -> Seg1 = "meter_page" ++ integer_to_list(N),
         Seg2 = "data",
         RefX1 = #refX{site = ?site, path = [Seg1], obj = {page, "/"}},
         RefX2 = #refX{site = ?site, path = [Seg1, Seg2], obj = {page, "/"}},
         io:format("loading ~p~n", [RefX1]),
         ok = hn_templates:load_template(RefX1, "meter_page"),
         io:format("loading ~p~n", [RefX2]),
         ok = hn_templates:load_template(RefX2, "data"),
         syslib:limiter(?site),
         syslib:log("loading " ++ integer_to_list(N) ++ ","
                    ++ integer_to_list(util2:get_timestamp()), "load.log"),
         l2(N - 1).

copy([])      -> ok;
copy([H | T]) ->
    Site = "hypernumbers.dev\\&9000",
    Root = code:lib_dir(hypernumbers) ++ "/../../",
    Cmd = "cp " ++ [?doublequote] ++ Root ++ "priv/load_testing/priv/"
        ++ H ++ ".json" ++ [?doublequote] ++ " " ++ Root ++ "var/sites/"
        ++ Site ++ "/templates/",
    _Ret = os:cmd(Cmd),
    copy(T).
