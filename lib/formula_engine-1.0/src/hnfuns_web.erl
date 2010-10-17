%%% @copyright 2010 Hypernumbers Ltd
%%% @doc Web Spreadsheet functions
-module(hnfuns_web).

-export([ input/1,
          textarea/1,
          button/1,
          radio/1,
          select/1,
          include/1,
          %table/1,
          background/1,
          'google.map'/1,
          'twitter.search'/1,
          anchor/1,
          img/1,
          html/1,
          site/1]).

-export([fail/1]).

-include("spriki.hrl").
-include("typechecks.hrl").
-include("muin_records.hrl").
-include("hypernumbers.hrl").

-import(muin_util, [cast/2]).
-import(muin_collect, [ col/2, col/3, col/4 ]).

-define(default_str_rules, [first_array, cast_numbers, cast_bools,
                            cast_blanks, cast_dates ]).

-type trans() :: common | string().
-type html() :: string().
-type zoom() :: 1..20.

fail([_]) -> [forced_error, "should_wig"].

%% Safe functions (after typecheck)
%%
html([Html]) ->
    Html.

-spec input_([string()], string(), trans()) -> {rawform, #form{}, html()}.
input_(Label) -> input_(Label, "", common).
%input_(Label, Default) -> input_(Label, Default, common).
input_([Label], _Default, Trans) ->
    Form = #form{id = {Trans, Label}, kind = input},
    Html = lists:flatten("<input type='input' class='hninput' " ++
                         "data-name='default' " ++
                         "data-label='"++Label++"' />"),
    {rawform, Form, Html}.

-spec textarea_([string()], string(), trans()) -> {rawform, #form{}, html()}.
textarea_(Label) -> textarea_(Label, "", common).
%textarea_(Label, Default) -> textarea_(Label, Default, common).
textarea_([Label], _Default, Trans) ->
    Form = #form{id = {Trans, Label}, kind = textarea},
    Html = lists:flatten("<textarea class='hntext' data-name='default' "
                         ++ "data-label='"++Label++"'></textarea>"),
    {rawform, Form, Html}.

-spec 'google.map_'(number(), number(), zoom()) -> html().
'google.map_'(Lat, Long, Zoom) ->
    "<iframe width='100%' height='100%' frameborder='0' scrolling='no' "
        ++ "marginheight='0' marginwidth='0' src='http://maps.google.com"
        ++ "/?ie=UTF8&amp;ll=" ++ cast(Lat, str) ++ "," ++ cast(Long, str)
        ++ "&amp;z=" ++ cast(Zoom, str) ++ "&amp;output=embed'></iframe>".

-spec button_(string(), string(), string()) -> {rawform, #form{}, html()}.
button_(Value, Response, ResultsPath) ->
    Trans = common,
    Origin = hn_util:list_to_path(muin:context_setting(path)),
    Form = #form{id = {Trans, "_"}, 
                 kind = button, 
                 attrs = [{"dest", Origin}]},
    Html = lists:flatten("<input type='submit' class='hninput' value='"++Value++"'"
                         ++ " data-results='" ++ ResultsPath ++ "'"
                         ++ " data-origin='" ++ Origin ++ "?view=webpage'"
                         ++ " data-form-name='default' data-response='"
                         ++ Response ++ "' />"),
    {rawform, Form, Html}.

-spec select_(string(), [string()]) -> {rawform, #form{}, html()}.
select_(Label, Options) ->
    Trans = common,
    Form = #form{id = {Trans, Label},
                 kind = select,
                 restrictions = Options},
    Opts = [ "<option>" ++ Option ++ "</option>" || Option <- Options ],
    Html = lists:flatten("<select class='hninput' data-name='default' "++
                         "data-label='" ++ Label ++ "' >" ++ Opts ++ 
                         "</select>"),
    {rawform, Form, Html}.

-spec radio_(string(), [string()]) -> {rawform, #form{}, html()}.
radio_(Label, Options) ->
    Trans = common,
    Name = "tmp_" ++ create_name(),
    Form = #form{id = {Trans, Label},
                 kind = radio,
                 restrictions = Options},
    [First | Rest] = Options,
    ID1 = "id_"++create_name(),
    FirstOpt = "<div class='radio'><label for='"++ID1++"'>"
        ++ First ++ "</label><input id='"++ID1++"' type='radio' value='" ++
        First ++ "' name='" ++ Name ++ "' checked='true' /></div>",
    RestOpts = [ make_radio(Name, Opt) || Opt <- Rest],
    Opts = [FirstOpt | RestOpts],
    Html = lists:flatten("<div class='hninput' data-name='default' "++
                         "data-label='" ++ Label ++ "' >" ++ Opts ++ 
                         "</div>"),
    {rawform, Form, Html}.

'twitter.search_'(_Term, _Title) ->
    "Todo".

background_(Url, Rest) ->
    lists:flatten("<style type='text/css'>body{background:url("
                  ++ Url ++ ") " ++ Rest ++ "};</style>").

anchor_(Src, Text) ->
    lists:flatten("<a href='" ++ Src ++ "'>" ++ Text ++ "</a>").
img_(Src) ->
    lists:flatten("<img src='" ++ Src ++ "' />").

%% Type checking and default values
%%

%% site just returns the site url
site([]) ->
    Site = get(site),
    [Proto, Domain, _Port] = string:tokens(Site, ":"),
    Proto ++ Domain.

anchor([Src, Text]) ->
    col([Src, Text], [eval_funs, fetch, {cast, str}], [return_errors],
        fun([NSrc, NText]) -> anchor_(NSrc, NText) end).

img([Src]) ->
    col([Src], [eval_funs, fetch, {cast, str}], [return_errors],
        fun([NSrc]) -> img_(NSrc) end).


'twitter.search'([])          -> 'twitter.search'(["hello"]);
'twitter.search'([Term])      -> 'twitter.search'([Term, "title"]);
'twitter.search'([Term, Title]) ->
    col([Term, Title], [eval_funs, fetch, {cast, str}], [return_errors],
        fun([NTerm, NTitle]) -> 'twitter.search_'(NTerm, NTitle) end).

table([Ref]) ->
    table([Ref, 0]);
table([Ref, Sort]) ->
    table_(Ref, Sort).

'google.map'([])          -> 'google.map'([0]);
'google.map'([Long])      -> 'google.map'([Long, 0]);
'google.map'([Long, Lat]) -> 'google.map'([Long, Lat, 10]);
'google.map'([Long, Lat, Zoom]) ->
    col([Long, Lat, Zoom], [eval_funs, fetch, {cast, num}],
        [return_errors, {all, fun is_number/1}],
        fun([NLong, NLat, NZoom]) ->
                'google.map_'(NLong, NLat, NZoom)
        end).

input([])   -> input([""]);
input([V1]) ->
    Label = col([V1], [first_array, fetch, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    muin_util:run_or_err([Label], fun input_/1).

textarea([])   -> textarea([""]);
textarea([V1]) ->
    Label = col([V1], [first_array, fetch, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    muin_util:run_or_err([Label], fun textarea_/1).

button([])      -> button(["Submit Form"]);
button([Title]) -> button([Title, "Thanks for completing our form."]);
button([Title, Response]) -> button([Title, Response, "./replies/"]);
button([Title, Response, Results]) ->
    col([Title, Response, Results], [first_array, fetch, {cast,str}],
        [return_errors, {all, fun muin_collect:is_string/1}],
        fun([NTitle, NResponse, NResult]) ->
                button_(NTitle, NResponse, NResult)
        end).


select([])      -> select([""]);
select([Label]) -> select([Label, {array, [["option 1", "option 2"]]}]);
select([V1, V2]) ->
    [Label] = col([V1], [first_array, fetch, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    Opts = col([V2], [fetch, flatten, {ignore, blank}, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    muin_util:apply([Label, Opts], fun select_/2).

radio([])      -> radio([""]);
radio([Label]) -> radio([Label, {array, [["option 1", "option 2"]]}]);
radio([V1, V2]) ->
    [Label] = col([V1], [first_array, fetch, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    Opts = col([V2], [fetch, flatten, {ignore, blank}, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    muin_util:apply([Label, Opts], fun radio_/2).

background([Url]) -> background([Url, ""]);
background([V1, V2]) ->
    col([V1, V2], [first_array, fetch, {cast,str}],
        [return_errors, {all, fun muin_collect:is_string/1}],
        fun([Url, Extra]) -> background_(Url, Extra) end).


include([CellRef]) when ?is_cellref(CellRef) ->
    #cellref{col={offset, X}, row={offset, Y}, path=Path} = CellRef,
    RelRan = #rangeref{type=finite,
                       path=Path,
                       tl = {{offset, X}, {offset, Y}},
                       br = {{offset, X}, {offset, Y}}},
    include([RelRan]);
include([RelRan]) when ?is_rangeref(RelRan) ->
    %% DIRTY HACK. This forces muin to setup dependencies, and checks
    %% for circ errors.
    Ret = muin:fetch(RelRan),
    case has_circref(Ret) of
        true  -> {errval, '#CIRCREF'};
        false ->
            AbsRan = area_util:to_absolute(RelRan, 
                                           muin:context_setting(col),
                                           muin:context_setting(row)),
            #rangeref{path=RelPath, tl = {X1,Y1}, br = {X2,Y2}} = AbsRan,
            Site = muin:context_setting(site),
            Path = muin_util:walk_path(muin:context_setting(path), RelPath),
            Obj = {range, {X1, Y1, X2, Y2}},
            Ref = #refX{site = Site, path = Path, obj = Obj},
            {Html, Width, Height} = hn_render:content(Ref),
            lists:flatten(hn_render:wrap_region(Html, Width, Height))
    end.

has_circref({range, List}) -> has_c1(List).

has_c1([])                                -> false;
has_c1([[{errval, '#CIRCREF!'} , _] | _T]) -> true;
has_c1([_H | T])                          -> has_c1(T).

create_name() ->
    Bin = crypto:rand_bytes(8),
    mochihex:to_hex(Bin).

table_({range, [ THead | Range]}, Sort) ->
    
    Id = "tbl_"++create_name(),
    F = fun(blank) -> "";
           (Else)  -> cast(Else, str)
        end,

    Head = ["<thead><tr>",
            [["<th>", F(X),"</th>"] || X <- THead ],
            "</tr></thead>"],
    
    Rows = [ ["<tr>", [ ["<td>", F(Cell),"</td>"] || Cell <- Row ],"</tr>"]
             || Row <- Range ],
    
    Script = ["<script type='text/javascript'>$(\"#", Id,
              "\").tablesorter({headers: { 1: { sorter:'digit' }}, sortList:[[",
              cast(Sort, str), ",0]]});</script>"],
    
    lists:flatten(["<table id='", Id,"' class='tablesorter'>", Head, Rows,
                   "</table>", Script]).

make_radio(Name, Opt) ->
    ID = "id_"++create_name(),
    "<div class='radio'><label for='"++ID++"'>" ++ Opt ++ "</label><input id='"++ID++
        "' type='radio' value='" ++ Opt ++ "' name='" ++ Name ++ "' /></div>".
