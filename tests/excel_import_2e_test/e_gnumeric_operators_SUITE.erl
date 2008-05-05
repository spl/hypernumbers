%% This file is generated; DO NOT EDIT MANUALLY.

-module(e_gnumeric_operators_SUITE).
-compile(export_all).
-include("ct.hrl").
-import(lists, [foreach/2, map/2]).
-import(test_util, [conv_for_post/1, conv_from_get/1, cmp/2, hnpost/3, hnget/2, readxls/1]).

-define(print_error_or_return(Res, Testcase),
        case Res of
            true ->
                {test, ok};
            false ->
                io:format("EXPECTED:~n    ~p~nGOT:~n    ~p~nCONV:~n    ~p~n~n",
                          [E, G, conv_from_get(G)]),
                exit("FAIL: Mismatch in ~p in ~p~n", 
                     [Testcase, "e_gnumeric_operators_SUITE %>"])
        end).

-define(test(Func, Path, Ref, Expected),
        Func(_Config) ->
               E = Expected,
               G = hnget("/" ++ "e_gnumeric_operators" ++ Path, Ref),
               Res = cmp(G, E),
               ?print_error_or_return(Res, Func)).

%% TESTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
?test(sheet1_A1, "/Result/", "A1", "EQUAL").
?test(sheet1_C1, "/Result/", "C1", "Success").
?test(sheet1_A2, "/Result/", "A2", "GT").
?test(sheet1_C2, "/Result/", "C2", "Success").
?test(sheet1_A3, "/Result/", "A3", "LT").
?test(sheet1_C3, "/Result/", "C3", "Success").
?test(sheet1_A4, "/Result/", "A4", "GTE").
?test(sheet1_C4, "/Result/", "C4", "Success").
?test(sheet1_A5, "/Result/", "A5", "LTE").
?test(sheet1_C5, "/Result/", "C5", "Success").
?test(sheet1_A6, "/Result/", "A6", "NOT_EQUAL").
?test(sheet1_C6, "/Result/", "C6", "Success").
?test(sheet1_A7, "/Result/", "A7", "ADD").
?test(sheet1_C7, "/Result/", "C7", "Success").
?test(sheet1_A8, "/Result/", "A8", "SUB").
?test(sheet1_C8, "/Result/", "C8", "Success").
?test(sheet1_A9, "/Result/", "A9", "MULT").
?test(sheet1_C9, "/Result/", "C9", "Success").
?test(sheet1_A10, "/Result/", "A10", "DIV").
?test(sheet1_C10, "/Result/", "C10", "Success").
?test(sheet1_A11, "/Result/", "A11", "EXP").
?test(sheet1_C11, "/Result/", "C11", "Success").
?test(sheet1_A12, "/Result/", "A12", "CONCAT").
?test(sheet1_C12, "/Result/", "C12", "Success").
?test(sheet1_A16, "/Result/", "A16", "Epsilon :").
?test(sheet1_B16, "/Result/", "B16", 1.0e-06).
%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

init_per_suite(Config) ->
    code:add_patha("../../../../../ebin"),
    production_boot:start(),
    bits:clear_db(),
    test_util:wait(),
    io:format("Current path:~n"),
    c:pwd(),
    Celldata = readxls("../../excel_files/Win_Excel07_As_97/" ++
                                 "e_gnumeric_operators.xls"),
    io:format("DATA:~n~p~n~n", [Celldata]),
    Postcell =
        fun({{{sheet, Sheetname}, {row_index, Row}, {col_index, Col}}, Val}) ->
                Postdata = conv_for_post(Val),
                Path = "/" ++ "e_gnumeric_operators" ++ "/" ++ Sheetname ++ "/",
                Ref = tconv:to_b26(Col + 1) ++ tconv:to_s(Row + 1),
                hnpost(Path, Ref, Postdata)
        end,
    foreach(Postcell, Celldata),
    Config.

end_per_suite(_Config) ->
    production_boot:stop(),
    ok.

init_per_testcase(_TestCase, Config) ->
    Config.

end_per_testcase(_TestCase, _Config) ->
    ok.

all() ->
    [
        sheet1_A1,
        sheet1_C1,
        sheet1_A2,
        sheet1_C2,
        sheet1_A3,
        sheet1_C3,
        sheet1_A4,
        sheet1_C4,
        sheet1_A5,
        sheet1_C5,
        sheet1_A6,
        sheet1_C6,
        sheet1_A7,
        sheet1_C7,
        sheet1_A8,
        sheet1_C8,
        sheet1_A9,
        sheet1_C9,
        sheet1_A10,
        sheet1_C10,
        sheet1_A11,
        sheet1_C11,
        sheet1_A12,
        sheet1_C12,
        sheet1_A16,
        sheet1_B16
    ].