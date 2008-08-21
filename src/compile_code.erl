-module(compile_code).

-export([start/0,start/1]).
-include("../include/handy_macros.hrl").

-define(init(L),
        reverse(tl(reverse(L)))).

%% Disable warnings for these files (generated by Leex).
-define(NO_WARNINGS,
        ["xfl_lexer.erl",
         "russian_lexer.erl", "french_lexer.erl", "german_lexer.erl",
         "italian_lexer.erl", "spanish_lexer.erl",
         "portuguese_lexer.erl",
         "superlex.erl", "num_format_lexer.erl"]).

-define(DIRS,
        ["/lib/hypernumbers-1.0/",
         "/lib/hypernumbers.com-1.0/",
         "/lib/formula_engine-1.0/",
         "/lib/read_excel-1.0/",
         "/lib/mochi-1.0/"]).

-define(EXTRA_ERL_FILES, []).

start(Clean) ->
    compile(Clean).
start() ->
    compile(dirty).

compile(Clean) ->

    get_rel_file(),

    [_File, _Ebin | Rest] =
        reverse(string:tokens(code:which(compile_code), "/")),

    Pre = case os:type() of
              {win32,_} -> "";
              _ ->         "/"
          end,
    App_rt_dir = Pre++string:join(reverse(Rest),"/")++"/",

    io:fwrite("~nStarting the compilation~n~n", []),

    code:add_pathz(App_rt_dir ++ "/lib/eunit/ebin"),

    %% First set up the include file
    Inc_list = [{i, App_rt_dir ++ "/include"},
                {i, App_rt_dir ++ "/lib/read_excel-1.0/include"},
                {i, App_rt_dir ++ "/lib/yaws-1.76/include"},
                {i, code:lib_dir(xmerl)++"/include"}],

    %% List of {ErlangFile, OutputDirectory} tuples.
    Dirs = flatten(map(fun(X) ->
                               map(fun(Y) -> {Y, App_rt_dir ++ X ++ "ebin"} end,
                                   filelib:wildcard(App_rt_dir ++ X ++ "src/*.erl"))
                       end,
                       ?DIRS)),

    Extra = lists:map(
              fun(X) ->
                      {App_rt_dir++X,App_rt_dir++"ebin"}
              end,
              ?EXTRA_ERL_FILES),

    compile_funcs(Clean,Dirs++Extra, Inc_list).

compile_funcs(Clean, List, Inc_list) ->
    New_list = [{X, [debug_info, {outdir, Y} | Inc_list]} || {X, Y} <- List],
    comp_lists(Clean, New_list).

comp_lists(Clean, List) ->
    comp_lists(Clean, List, ok).

comp_lists(Clean, [{File, Opt}|T], OldStatus) ->
    Append = case member(filename:basename(File), ?NO_WARNINGS) of
                 true ->  [return_errors];
                 false -> [return_errors,report_warnings]
             end,
    Options = append(Opt,Append),

    %% Ensure output directory exists.
    [debug_info, {outdir, Dir} | _] = Options,
    filelib:ensure_dir(Dir ++ "/"),

    Comp = fun() -> NewStatus = compile:file(File, Options),
                    case NewStatus of
                        {ok, FileName} ->
                            io:fwrite("OK: ~s~n", [File]),
                            code:delete(FileName),
                            code:purge(FileName),
                            code:load_file(FileName),
                            comp_lists(Clean, T, OldStatus);
                        Error ->
                            io:fwrite("   Compile failure:    ~p~n", [File]),
                            io:fwrite("   Error is       :    ~p~n~n", [Error]),
                            comp_lists(Clean, T, error)
                    end
           end,

    case {Clean, uptodate(File, Dir)} of
        {clean,_} ->
            Comp();
        {dirty,false} ->
            Comp();
        {_,_} ->
            comp_lists(Clean, T, OldStatus)
    end;
comp_lists(_Clean, [], Status) ->
    io:fwrite("   Termination Status: ~p~n", [Status]),
    Status.

%% Is the beam older than the erl file?
uptodate(File, Dir) ->
    %% Find the beam corresponding to this erl file.
    Comps = string:tokens(File, "/"), % Path components
    Erlfile = last(Comps),
    Modname = sublist(Erlfile, length(Erlfile) - 4), % 4 <-> ".erl"
    Beam = Dir ++ "/" ++ Modname ++ ".beam",
    %% Get last modified times for beam and erl and compare them.
    Filelastmod = filelib:last_modified(File),
    Beamlastmod = filelib:last_modified(Beam),
    Beamlastmod > Filelastmod.

get_vsn(Module) ->
    AppFile = code:lib_dir(Module)++"/ebin/"++atom_to_list(Module)++".app",
    {ok,[{application,_App,Attrs}]} = file:consult(AppFile),
    {value,{vsn,Vsn}} = lists:keysearch(vsn,1,Attrs),
    Vsn.

get_rel_file() ->

    F = lists:append(["{release, {\"hypernumbers\",\"1.0\"}, ",
                      "{erts,\"",erlang:system_info(version),"\"},"
                      "[{kernel,\"",get_vsn(kernel),"\"},",
                      "{stdlib,\"",get_vsn(stdlib),"\"},",
                      "{inets,\"",get_vsn(inets),"\"},",
                      "{crypto,\"",get_vsn(crypto),"\"},",
                      "{sasl,\"",get_vsn(sasl),"\"},",
                      "{mnesia,\"",get_vsn(mnesia),"\"},",
                      "{yaws, \"1.76\", load},",
                      "{read_excel,\"1.0\"},",
                      "{starling_app,\"0.0.1\"},",
                      "{formula_engine,\"1.0\"},",
                      "{mochi,\"1.0\"},",
                      "{hypernumbers,\"1.0\"}]}."]),
    
    file:write_file("hypernumbers.rel",F),
    systools:make_script("hypernumbers",[local,{path,["../lib/*/ebin"]}]).
