%%% @author    Gordon Guthrie
%%% @copyright (C) 2011, Hypernumbers Ltd
%%% @doc
%%%
%%% @end
%%% Created : 26 Jan 2011 by gordon@hypernumbers.com

-module(hnfuns_controls).

-export([
         'create.button'/1,
         'map.rows.button'/1,
         'map.sheet.button'/1,
         'map.custom.button'/1,
         'load.templates.button'/1,
         'phone.out'/1,
         'phone.in'/1
        ]).

-include("spriki.hrl").
-include("errvals.hrl").

'phone.in'([]) ->
    Title = "Phone In",
    Site = get(site),
    Path = get(path),
    X = get(mx),
    Y = get(my),
    URL = hn_util:refX_to_url(#refX{site = Site, path = Path,
                                    obj = {cell, {X, Y}}}),
    Link = "<a href='" ++ URL ++ "?view=phone' target='hnsoftphone'>Soft Phone</a>",
    {preview, {"Phone In", 1, 1, #incs{}}, Link}.

'phone.out'(List) ->
    Title = "Phone Out",
    Js = ["/webcomponents/hn.phone.js",
          "http://static.twilio.com/libs/twiliojs/1.0/twilio.js"],
    Reload = ["HN.Phone.phone_outbound_reload();"],
    CSS = ["/webcomponents/hn.phone.css"],
    Incs = #incs{js = Js, js_reload = Reload, css = CSS},
    PhoneNo = "07776 251669",
    Payload = {struct, [{'twilio_outboundphone', PhoneNo}]},
    HTML = "<button id='hn-outboundphone' value='Phone' " ++
        "data-phoneno='" ++ PhoneNo ++"' disabled>" ++
        "<div class='hn-outboundphone_img'>" ++ "Phone" ++ "</div>"
        "</button>",
    Form = #form{id = {'phone', Title},
                 kind = "phone",
                 attrs = Payload},
    {webcontrol, {Form, {Title, 2, 2, Incs}}, HTML}.

'load.templates.button'(List) ->
    [Title, Template] = typechecks:std_strs(List),
    Templates = hn_util:get_templates(get(site)),
    Id = "id_" ++ muin_util:create_name(),
    case lists:member(Template, Templates) of
        false -> ?ERRVAL_VAL;
        true  -> Js = ["/hypernumbers/ajaxfileupload.js",
                       "/webcomponents/hn.loadtemplates.js"],
                 Reload = ["HN.LoadTemplates.reload();"],
                 Incs = #incs{js = Js, js_reload = Reload},
                 Payload = {struct, [{"load_templates", Template}]},
                 Form = #form{id = {'load-template-button', Title},
                              kind = "load-template-button",
                              attrs = Payload},
                 Html = "<input id='" ++ Id ++ "'type='submit' "
                     ++ "class='hn-loadtemplate' value='"
                     ++ Title ++ "' data-template='"
                     ++ Template ++ "' />",
                 {webcontrol, {Form, {Title, 2, 2, Incs}}, Html}
    end.

'map.custom.button'(List) ->
    [Title, Map] = typechecks:std_strs(List),
    Maps = hn_util:get_maps(get(site)),
    Id = "id_" ++ muin_util:create_name(),
    case lists:member(Map, Maps) of
        false -> ?ERRVAL_VAL;
        true  -> Js = ["/hypernumbers/ajaxfileupload.js",
                       "/webcomponents/hn.mapcustom.js"],
                 Reload = ["HN.MapCustom.reload();"],
                 Incs = #incs{js = Js, js_reload = Reload},
                 Payload = {struct, [{"map", Map}]},
                 Form = #form{id = {'map-custom-button', Title},
                              kind = "map-custom-button",
                              attrs = Payload},
                 Html = "<input id='" ++ Id ++ "' type='submit' "
                     ++ "class='hn-mapcustom' value='"
                     ++ Title ++ "' data-map-type='custom' data-map='"
                     ++ Map ++ "' />",
                 {webcontrol, {Form, {Title, 2, 2, Incs}}, Html}
    end.

'map.sheet.button'(List) ->
    [Title, Page, Map] = typechecks:std_strs(List),
    Maps = hn_util:get_maps(get(site)),
    Id = "id_" ++ muin_util:create_name(),
    case lists:member(Map, Maps) of
        false -> ?ERRVAL_VAL;
        true  -> Js = ["/hypernumbers/ajaxfileupload.js",
                       "/webcomponents/hn.mapsheet.js"],
                 Reload = ["HN.MapSheet.reload();"],
                 Incs = #incs{js = Js, js_reload = Reload},
                 Payload = {struct, [{"map", Map}, {"page", Page}]},
                 Form = #form{id = {'map-sheet-button', Title},
                              kind = "map-sheet-button",
                              attrs = Payload},
                 Html = "<input id='" ++ Id ++ "' type='submit' "
                     ++ "class='hn-mapsheet' value='"
                     ++ Title ++ "' data-map-type='sheet' data-map='"
                     ++ Map ++ "' data-map-page='" ++ Page ++"' />",
                 {webcontrol, {Form, {Title, 2, 2, Incs}}, Html}
    end.

'map.rows.button'(List) ->
    [Title, Map] = typechecks:std_strs(List),
    Maps = hn_util:get_maps(get(site)),
    Id = "id_" ++ muin_util:create_name(),
    case lists:member(Map, Maps) of
        false -> ?ERRVAL_VAL;
        true  -> Js = ["/hypernumbers/ajaxfileupload.js",
                       "/webcomponents/hn.maprows.js"],
                 Reload = ["HN.MapRows.reload();"],
                 Incs = #incs{js = Js, js_reload = Reload},
                 Payload = {struct, [{"map", Map}]},
                 Form = #form{id = {'map-rows-button', Title},
                              kind = "map-rows-button",
                              attrs = Payload},
                 Html = "<input id='" ++ Id ++ "' type='submit' "
                     ++ "class='hn-maprows' value='"
                     ++ Title ++ "' data-map-type='row' data-map='"
                     ++ Map ++ "' />",
                 {webcontrol, {Form, {Title, 2, 2, Incs}}, Html}
    end.

'create.button'(List) when is_list(List) ->
    Id = "id_" ++ muin_util:create_name(),
    [Title | Commands] = typechecks:std_strs(List),
    case Commands of
        [] -> ?ERRVAL_VAL;
        _  ->
            Origin = hn_util:list_to_path(muin:context_setting(path)),
            % first we create the list of commands records
            % this is the executable AST
            Fun1 = fun(Expr, {N, Acc}) ->
                           {N + 1, [{N, webc_parser:compile(Expr)} | Acc]}
                   end,
            Ret = lists:foldl(Fun1, {1, []}, Commands),
            {_, Commands2} = Ret,
            % no real reason to sort, just tidier!
            Commands3 = lists:sort(Commands2),
            % now we transform the commands in Json
            % this is the payload that is shipped to the button on the
            % browser
            Fun2 = fun({N, L}) ->
                           RecJson = [json_recs:rec_to_json(X) || X <- L],
                           {struct, [{N, {array, RecJson}}]}
                   end,
            Payload = [Fun2(X) || X <- Commands3],
            Pay2 = {struct, [{createpages, {array, Payload}}]},
            Json = mochijson:encode(Pay2),
            Html = lists:flatten("<input id='" ++ Id ++ "' type='submit' "
                                 ++ "class='hn-webcontrol' value='"
                                 ++ Title ++ "' data-payload='" ++ Json ++ "' "
                                 ++ "data-action='postcreatepages'"
                                 ++ "data-origin='" ++ Origin ++ "' />"),
            % we stash the record set as the form definition and when the POST
            % comes in from the button we will translate it back into a
            % record format and then compare the records to see if the
            % action is approved
            Form = #form{id = {'create-button', Title}, kind = "create-button",
                         attrs = Commands3},
            {webcontrol, {Form, {Title, 2, 2, #incs{}}}, Html}
    end.
