%%% @author     Gordon Guthrie
%%% @copyright (C) 2011-2014, Hypernumbers Ltd
%%% @doc       Functions that pertain to forms
%%%
%%% @end
%%% Created : 26 Jan 2011 by gordon@hypernumbers.com

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

-module(hnfuns_forms).

-export([
         'form.input'/1,
         'form.textarea'/1,
         'form.button'/1,
         'form.radio'/1,
         'form.select'/1,
         'form.fixedval'/1,
         input/1,            % deprecated
         textarea/1,         % deprecated
         button/1,           % deprecated
         radio/1,            % deprecated
         select/1,           % deprecated
         fixedval/1          % deprecated
        ]).

-include("spriki.hrl").
-include("typechecks.hrl").
-include("muin_records.hrl").
-include("hypernumbers.hrl").

-define(col, muin_collect:col).

'form.input'(Args)    -> input(Args).
'form.textarea'(Args) -> textarea(Args).
'form.button'(Args)   -> button(Args).
'form.radio'(Args)    -> radio(Args).
'form.select'(Args)   -> select(Args).
'form.fixedval'(Args) -> fixedval(Args).

fixedval([Label, Val]) ->
    fixedval([Label, Val, true]);
fixedval([Label, Val, Show]) ->
    Label2 = ?col([Label], [first_array, fetch, {cast,str}],
                  [return_errors, {all, fun muin_collect:is_string/1}]),
    Val2 = ?col([Val], [first_array, fetch, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    Show2 = typechecks:std_bools([Show]),
    muin_util:run_or_err([Label2, Val2, Show2], fun fixedval_/1).

input([]) ->
    input([""]);
input([V1]) ->
    input([V1, "Enter data..."]);
input([V1, V2]) ->
    [Lbl, Int] = ?col([V1, V2], [first_array, fetch, {cast,str}],
                      [return_errors, {all, fun muin_collect:is_string/1}]),
    muin_util:run([Lbl, Int], fun input_/1).

textarea([])->
    textarea([""]);
textarea([V1]) ->
    textarea([V1, "Enter data..."]);
textarea([V1, V2]) ->
    [Lbl, Int] = ?col([V1, V2], [first_array, fetch, {cast,str}],
                      [return_errors, {all, fun muin_collect:is_string/1}]),
    muin_util:run([Lbl, Int], fun textarea_/1).

button([])      ->
    button(["Submit Form"]);
button([Title]) ->
    button([Title, "Thanks for completing our form."]);
button([Title, Response]) ->
    button([Title, Response, "./_replies/"]);
button([Title, Response, Results]) ->
    button([Title, Response, Results, none]);
button([Title, Response, Results, Email]) ->
    Email2 = validate_email(Email),
    ?col([Title, Response, Results],
         [first_array, fetch, {cast,str}],
         [return_errors, {all, fun muin_collect:is_string/1}],
         fun([NTitle, NResponse, NResult]) ->
                 button_(NTitle, NResponse, NResult, Email2)
         end).

select([]) ->
    select([""]);
select([Label]) ->
    select([Label, {array, [["option 1", "option 2"]]}]);
select([V1, V2]) ->
    [Label] = ?col([V1], [first_array, fetch, {cast,str}],
                   [return_errors, {all, fun muin_collect:is_string/1}]),
    Opts = ?col([V2], [fetch, flatten, {ignore, blank}, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    muin_util:apply([Label, Opts], fun select_/2).

radio([]) ->
    radio([""]);
radio([Label]) ->
    radio([Label, {array, [["option 1", "option 2"]]}]);
radio([V1, V2]) ->
    [Label] = ?col([V1], [first_array, fetch, {cast,str}],
                   [return_errors, {all, fun muin_collect:is_string/1}]),
    Opts = ?col([V2], [fetch, flatten, {ignore, blank}, {cast,str}],
                [return_errors, {all, fun muin_collect:is_string/1}]),
    muin_util:apply([Label, Opts], fun radio_/2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                          %%%
%%% Internal Functions
%%%                                                                          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
validate_email(none) -> none;
validate_email(Email) ->
    Emails = hn_util:split_emails(Email),
    % can be a list of emails
    case valid_emails(Emails) of
        true  -> string:join(Emails, ";");
        false -> ?ERR_VAL
    end.

valid_emails([]) -> true;
valid_emails([E | T]) ->
    case hn_util:valid_email(E) of
        true  -> valid_emails(T);
        false -> false
    end.

fixedval_([Label, Val, Show]) ->
    Trans = common,
    Form = #form{id = {Trans, Label}, kind = fixedval, restrictions = [Val]},
    Html = case Show of
               true  -> "<input type='text' readonly class='hnfixedval'"
                            ++ "value=\""++ Val ++ "\""
                            ++" data-name='default'"
                            ++ "data-label='" ++ Label ++ "' />";
               false -> "<input type='text' readonly class='hnfixedval'"
                            ++ "value=\""++ Val ++ "\""
                            ++ "style='display:none;'"
                            ++" data-name='default'"
                            ++ "data-label='" ++ Label ++ "' />"
           end,
    Preview = Label,
    #spec_val{val = Html, preview = Preview,
              rawform = #rawform{form = Form, html = Html}}.

-spec input_([]) -> #spec_val{}.
input_([Label, Intro]) ->
    Form = #form{id = {common, Label}, kind = input},
    Html = lists:flatten("<input type='input' class='hninput hn_prompt' " ++
                         "data-name='default' " ++
                         "data-label='" ++ Label ++ "' " ++
                         "value='" ++ Intro ++ "'/>"),
    Preview = case Label of
                  []    -> Intro;
                  Label -> Label
              end,
    #spec_val{val = Html, preview = Preview,
              rawform = #rawform{form = Form, html = Html}}.

-spec textarea_([]) -> #spec_val{}.
textarea_([Label, Intro]) ->
    Form = #form{id = {common, Label}, kind = textarea},
    Html = lists:flatten("<textarea class='hntext hn_prompt' "
                         ++ "data-name='default' "
                         ++ "data-label='" ++ Label ++
                         "'>" ++ Intro ++ "</textarea>"),
    Preview = case Label of
                  []    -> Intro;
                  Label -> Label
              end,
    #spec_val{val = Html, preview = Preview,
              rawform = #rawform{form = Form, html = Html}}.

-spec button_(string(), string(), string(), string()) -> #spec_val{}.
button_(Value, Response, ResultsPath, Email) ->
    Trans = common,
    Origin = hn_util:list_to_path(muin:context_setting(path)),
    Attrs = case Email of
                none -> [{"dest", Origin}];
                _    -> [{"dest", Origin}, {"email", Email}]
            end,
    Resp2 = xmerl_lib:export_text(Response),
    Resp3 = re:replace(Resp2, "'", "", [{return, list}, global]),
    Resp4 = re:replace(Resp3, "\"", "", [{return, list}, global]),
    Form = #form{id = {Trans, "_"},
                 kind = button,
                 attrs = Attrs},
    Html = lists:flatten("<input type='submit' class='hninput button' value='"
                         ++ Value ++"'"
                         ++ " data-results='" ++ ResultsPath ++ "'"
                         ++ " data-origin='" ++ Origin ++ "?view=webpage'"
                         ++ " data-form-name='default' data-response='"
                         ++ Resp4 ++ "' />"),
    Preview = Value ++ " Submit Button",
    #spec_val{val = Html, preview = Preview,
              rawform = #rawform{form = Form, html = Html}}.

-spec select_(string(), [string()]) -> #spec_val{}.
select_(Label, Options) ->
    Trans = common,
    Form = #form{id = {Trans, Label},
                 kind = select,
                 restrictions = Options},
    Opts = [ "<option>" ++ Option ++ "</option>" || Option <- Options ],
    Html = lists:flatten("<select class='hninput' data-name='default' "++
                         "data-label='" ++ Label ++ "' >" ++ Opts ++
                         "</select>"),
    Preview = Label,
    #spec_val{val = Html, preview = Preview,
              rawform = #rawform{form = Form, html = Html}}.

-spec radio_(string(), [string()]) -> #spec_val{}.
radio_(Label, Options) ->
    Trans = common,
    Name = "tmp_" ++ muin_util:create_name(),
    Form = #form{id = {Trans, Label},
                 kind = radio,
                 restrictions = Options},
    [First | Rest] = Options,
    ID1 = "id_"++muin_util:create_name(),
    FirstOpt = "<div class='radio'><label for='"++ID1++"'>"
        ++ First ++ "</label><input id='"++ID1++"' type='radio' value='" ++
        First ++ "' name='" ++ Name ++ "' checked='true' /></div>",
    RestOpts = [ make_radio(Name, Opt) || Opt <- Rest],
    Opts = [FirstOpt | RestOpts],
    Html = lists:flatten("<div class='hninput' data-name='default' "++
                         "data-label='" ++ Label ++ "' >" ++ Opts ++
                         "</div>"),
    Preview = Label,
    #spec_val{val = Html, preview = Preview,
              rawform = #rawform{form = Form, html = Html}}.

make_radio(Name, Opt) ->
    ID = "id_"++muin_util:create_name(),
    "<div class='radio'><label for='"++ID++"'>" ++ Opt ++ "</label><input id='"++ID++
        "' type='radio' value='" ++ Opt ++ "' name='" ++ Name ++ "' /></div>".

