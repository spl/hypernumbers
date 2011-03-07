%%% @author Hasan Veldstra <hasan@hypernumbers.com>
%%% @doc Functions to handle file uploads.
-module(hn_file_upload).

-export([ handle_upload/3]).

-export([test_import/0,
         test_import/2,
         test_import/1 ]).

-include("spriki.hrl").
-include("hypernumbers.hrl").

% TODO - rest if chunking and sleep is still needed
-define(CHUNK, 1000).
-define(SLEEP, 500).

%% holds upload state for callback function in the hn_file_upload module.
-record(file_upload_state, {
          ref,               % The RefX for the request
          original_filename, % file name as it comes from the user
          filename,          % file name as saved on the server
          file
         }).


%% @doc Handles a file upload request from a user. Imports the file etc and
%% returns response data to be sent back to the client.
handle_upload(Mochi, Ref, Uid) ->

    {ok, UserName} = passport:uid_to_email(Uid),
    
    {ok, File, Name} = stream_to_file(Mochi, Ref, UserName),
    NRef = Ref#refX{path = Ref#refX.path ++ [make_name(Name)]},
    % io:format("file uploaded...~n"),
    try
        import(File, UserName, NRef, Name),
        { {struct, [{"location", hn_util:list_to_path(NRef#refX.path)}]},
          File}
    catch
        _Type:Reason ->
            ?ERROR("Error Importing ~p ~n User:~p~n Reason:~p~n Stack:~p~n",
                   [File, UserName, Reason,
                    erlang:get_stacktrace()]),
            { {struct, [{"error", "error reading sheet"}]},
              undefined}
    end.

%%% interfacing with the reader
%%% TODO: some of this needs to be part of the reader

%% @doc Writes contents of an XLS file into Hypernumbers pages.
%% Filename is a full name, parent page is path to page under which pages for
%% individual sheets will be created.
convert_addr({{Fr, Fc}, {Lr, Lc}}) ->
    {rc_to_a1(Fr, Fc), rc_to_a1(Lr, Lc)};
convert_addr({Row, Col}) ->
    rc_to_a1(Row, Col).

split_sheets(X, {Ls, Fs}) ->
    {SheetName, Target, V} = read_reader_record(X),
    Sheet = excel_util:esc_tab_name(SheetName),
    %Ref = convert_addr(Target),
    
    Postdata = conv_for_post(V),
    Datatpl = {Sheet, convert_addr(Target), Postdata},
    
    case Postdata of
        [$=|_] -> {Ls, [Datatpl|Fs]};
        _      -> {[Datatpl|Ls], Fs}
    end.

write_data(Ref, {Sheet, Target, Data}) when is_list(Target) ->
    NRef = Ref#refX{path = Ref#refX.path ++ [Sheet],
                    obj  = hn_util:parse_attr(Target)},
    hn_db_api:write_attributes([{NRef, [{"formula", Data}]}]);

write_data(_Ref, {_Sheet, {_Tl, _Br}, _Data}) ->
    %Name = excel_util:esc_tab_name(Sheet),
    %NRef = Ref#refX{path = Ref#refX.path ++ [Name],
    %                obj = hn_util:parse_attr(Tl ++ ":" ++ Br)},
    ok.
%    hn_main:formula_to_range(NRef, Data).

write_css(Ref, {{{sheet, Sheet}, {row_index, R}, {col_index, C}}, [CSS]}) ->
    Name = excel_util:esc_tab_name(Sheet),
    Obj = {cell, {C + 1, R + 1}},
    NRef = Ref#refX{path = Ref#refX.path ++ [Name], obj = Obj},
    StyleIdx = hn_db_api:write_magic_style_IMPORT(NRef, defaultize(CSS)),
    hn_db_api:write_attributes([{NRef, [{"style", StyleIdx }]}]).

%% Excel's default borders are
%% * no type of border
%% * no style of border
%% * black
%% Our default borders aer:
%% * no type of border
%% * no style of border
%% * no colour
%% This function 'makes it so' <-- super-ugelee n'est pas?
defaultize(M) ->
    M1 = case M of
             #magic_style{'border-right-style' = [], 
                          'border-right-color' = "rgb(000,000,000)", 
                          'border-right-width' = []} -> 
                 M#magic_style{'border-right-color' = []};
             _O1 -> M
         end,
    M2 = case M1 of
             #magic_style{'border-left-style' = [], 
                          'border-left-color' = "rgb(000,000,000)", 
                          'border-left-width' = []} -> 
                 M1#magic_style{'border-left-color' = []};
             _O2 -> M1
         end,
    M3 = case M2 of
             #magic_style{'border-top-style' = [], 
                          'border-top-color' = "rgb(000,000,000)", 
                          'border-top-width' = []} -> 
                 M2#magic_style{'border-top-color' = []};
             _O3 -> M2
         end,
    _M4 = case M3 of
              #magic_style{'border-bottom-style' = [], 
                           'border-bottom-color' = "rgb(000,000,000)", 
                           'border-bottom-width' = []} -> 
                 M3#magic_style{'border-bottom-color' = []};
              _O4 -> M3
          end.    


test_import() ->
     test_import("Management Accounts Model v17", hn_util:url_to_refX("http://hypernumbers.dev:9000")).
    %test_import("c_year", hn_util:url_to_refX("http://hypernumbers.dev:9000")).

test_import(File) ->
    test_import(File, hn_util:url_to_refX("http://hypernumbers.dev:9000/")).

test_import(File, Ref) ->
    io:format("File is ~p Ref is ~p~n", [File, Ref]),
    Path = code:lib_dir(hypernumbers)++"/../../tests/excel_files/"
        ++ "Win_Excel07_As_97/"++File++".xls",
    import(Path, "anonymous", Ref#refX{path=[File]}, File).

import(File, User, Ref, Name) ->
    
    {Cells, _Names, _Formats, CSS, Warnings, Sheets} = filefilters:read(excel, File),    
    {Literals, Formulas} = lists:foldl(fun split_sheets/2, {[], []}, Cells),
    % io:format("There are ~p literals~nThere are ~p Formulae~n",
    %          [erlang:length(Literals), erlang:length(Formulas)]),
    [ write_data(Ref, X) || X <- Literals ],
    % [ write_data(Ref, X) || X <- Formulas ],
    % chunking gives the recalc engine the time to sort itself out...
    ok = chunk_write(Ref, Formulas),
    %io:format("going to write css~n"),
    [ write_css(Ref, X) || X <- CSS ],
    %io:format("write out warnings...~n"),
    ok = write_warnings_page(Ref, Sheets, User, Name, Warnings).

chunk_write(Refs, Items) -> chunk_w1(Refs, Items, 1).

chunk_w1(_Ref, [], _N)      -> ok;
chunk_w1(Ref, List, ?CHUNK) -> timer:sleep(?SLEEP),
                               chunk_w1(Ref, List, 1);
chunk_w1(Ref, [H | T], N)   -> ok = write_data(Ref, H),
                               chunk_w1(Ref, T, N + 1).

write_warnings_page(Ref, Sheets, User, Name, Warnings) ->

    hn_db_api:write_attributes([{Ref#refX{obj = {column, {2, 2}}},
                                 [{width, 400}]}]),

    % write parent page information    
    HeaderSt = [{"font-weight", "bold"},
                {"font-size", "16px"}, {"color", "#E36C0A"}],
    WarningSt = [{"font-weight", "bold"},
                 {"font-size", "12px"}, {"color", "#FF0000"}],

    Msg = ?FORMAT("File ~s imported by ~s on ~s",
                  [Name, User, dh_date:format("r")]),

    write_to_cell(Ref, "File Import Details", 2, 2, HeaderSt),
    write_to_cell(Ref, Msg, 2, 3, []),

    write_to_cell(Ref, "Each sheet in your Excel file has been written as "
                  "a page. The sheetname may have been rewritten to "
                  "make them valid URL's. ", 2, 5, []),
    write_to_cell(Ref, "(Don't worry all your formulae that refer to cells on "
                  "a renamed sheet have been rewritten to take this into "
                  "account.)", 2, 6, []),
    write_to_cell(Ref, "Imported Pages", 2, 8, HeaderSt),

    Root = hn_util:list_to_path(Ref#refX.path),
    F = fun({_X, [Sheet]}, Int) ->
                SheetPath = Root++Sheet++"/",
                Url       = "<a href='"++SheetPath++"'>"++SheetPath++"</a>",
                write_to_cell(Ref, Url, 2, Int, []),
                Int + 1
        end,
    Index = lists:foldl(F, 9, Sheets),
    
    write_to_cell(Ref, "Warnings", 2, Index + 1, HeaderSt),
    write_to_cell(Ref, "(remember this is an early BETA product!)",
                  2, Index + 2, WarningSt),
    write_to_cell(Ref, "Not all Excel functions are fully supported "
                  "at the moment. Any functions that you use which " ++
                  "are not supported will be listed here.", 2, Index + 3, []),
    
    ok = write_warnings(Ref, Warnings, Index + 5),
    
    ok.

write_to_cell(Ref, Str, Col, Row, Attrs) ->
    Attrs2 = [{"formula", Str} | Attrs],
    hn_db_api:write_attributes([{Ref#refX{obj = {cell, {Col, Row}}}, Attrs2}]).

write_warnings(_Ref, [], _) ->
    ok;
% Idx is the index of W in the original list
write_warnings(Ref, [W|Ws], Idx) -> 
    WarningString = case W of
                        {S, []}          -> S;
                        {_, S}           -> S
                    end,
    write_to_cell(Ref, WarningString, 2, Idx, []),
    write_warnings(Ref, Ws, Idx + 1).


%% Input: list of {key, id} pairs where key is an ETS table holding info
%% about some part of the XLS file.
%% @TODO: formats, names, styles.
read_reader_record({{{sheet, SheetName}, {row_index, Row},
                     {col_index, Col}}, Val}) ->
    {SheetName, {Row, Col}, Val};

read_reader_record({{{sheet, SheetName}, {firstrow, Fr}, {firstcol, Fc},
                     {lastrow, Lr}, {lastcol, Lc}}, Fla}) ->
    {SheetName, {{Fr, Fc}, {Lr, Lc}}, Fla}.

%% @doc Convert row and column pair to A1-style ref
%% @spec rc_to_a1(Row :: integer(), Col :: integer()) -> string()
rc_to_a1(Row, Col) ->
    tconv:to_b26(Col + 1) ++ tconv:to_s(Row + 1).

%% @TODO: Some of these conversion need to be done inside the reader itself.
conv_for_post(Val) ->
    case Val of
        {_, boolean, true}        -> "true";
        {_, boolean, false}       -> "false";
        {_, date, {datetime,D,T}} -> dh_date:format("d/m/Y H:i:s",{D,T});
        {_, number, N}            -> tconv:to_s(N);
        {_, error, E}             -> E;
        {string, X}               -> X;
        {formula, F}              -> F
    end.

setup_state(S, {"content-disposition",
                {"form-data", [_Nm, {"filename", FileName}]}}) ->
    
    Stamp = S#file_upload_state.filename ++ "__" ++ FileName,
    Site  = (S#file_upload_state.ref)#refX.site,
    Name  = filename:join([hn_mochi:docroot(Site), "..", "uploads", Stamp]),
    filelib:ensure_dir(Name),
    {ok, File} = file:open(Name, [raw, write]),
    
    #file_upload_state{original_filename = FileName,
                       filename = Name,
                       file = File}.

make_name(Name) ->
    Basename = filename:basename(Name, ".xls"),
    re:replace(Basename,"\s","_",[{return,list}, global]).

stream_to_file(Mochi, Ref, UserName) ->
    Stamp    = UserName ++ dh_date:format("__Y_m_d_h_i_s"),
    Rec      = #file_upload_state{filename=Stamp, ref=Ref},
    CallBack = fun(N) -> file_upload_callback(N, Rec) end,
    {_, _, State} = mochiweb_multipart:parse_multipart_request(Mochi, CallBack),
    
    {ok, State#file_upload_state.filename,
     State#file_upload_state.original_filename}.

file_upload_callback({headers, Headers}, S) ->
    NewState = setup_state(S, hd(Headers)),
    fun(N) -> file_upload_callback(N, NewState) end;

file_upload_callback({body, Data}, S) ->
    file:write(S#file_upload_state.file, Data),
    fun(N) -> file_upload_callback(N, S) end;

file_upload_callback(body_end, S) ->
    file:close(S#file_upload_state.file),
    fun(N) -> file_upload_callback(N, S) end;

file_upload_callback(eof, State) -> State.
