%%% @author    Gordon Guthrie
%%% @copyright (C) 2012, Hypernumbers Ltd (Vixo)
%%% @doc       Functions for administering the site
%%%
%%% @end
%%% Created : 21 Apr 2012 by gordon@vixo.com

-module(hnfuns_site).

-include("spriki.hrl").
-include("errvals.hrl").
-include("twilio.hrl").
-include("muin_records.hrl").
-include("muin_proc_dict.hrl").

-export([
         'configure.email'/1,
         'phone.menu'/1,
         'phone.menu.say'/1
         ]).

'phone.menu'(List) ->
    List2 = gather(List),
    io:format("List is ~p~nList2 is ~p~n", [List, List2]),
    "Phone Menu".

'phone.menu.say'([Text]) ->
    phsay(Text, "woman", "en-gb", 1);
'phone.menu.say'([Text, Voice]) ->
    phsay(Text, Voice, "en_gb", 1);
'phone.menu.say'([Text, Voice, Language]) ->
    phsay(Text, Voice, Language, 1);
'phone.menu.say'([Text, Voice, Language, Loop]) ->
    phsay(Text, Voice, Language, Loop).

phsay(Text, Voice, Language, Loop) ->
    [Text2, V2, L2] = typechecks:std_strs([Text, Voice, Language]),
    [Lp2] = typechecks:std_pos_ints([Loop]),
    Len = length(Text2),
    ok = typechecks:in_range(Len, 1, 4000),
    ok = typechecks:is_member(string:to_lower(V2), ?SAYVoices),
    ok = typechecks:is_member(string:to_lower(L2), ?SAYLanguages),
    Title = if
                Len >  30 -> {Tit, _} = lists:split(30, Text2),
                             Tit;
                Len =< 30 -> Text2
            end,
    Preview = #preview{title = "SAY: " ++ Title, width = 2, height = 2},
    SAY = #say{text = Text2, voice = V2, language = L2, loop = Lp2},
    #spec_val{val = "", preview = Preview, sp_phone = #phone{twiml = [SAY]}}.

'configure.email'([FromEmail]) ->
    'configure.email'([FromEmail, ""]);
'configure.email'([_FromEmail, _Signature] = Args) ->
    [FromE2, Sig2] = typechecks:std_strs(Args),
    Valid = hn_util:valid_email(FromE2),
    if
        Valid == false -> ?ERR_VAL;
        Valid == true  -> ok
    end,
    Site = get(site),
    Idx = get(idx),
    V = new_db_wu:read_kvD(Site, site_email),
    % got some validation to do
    % a new email has to be validated
    io:format("V is ~p~n", [V]),
    Rec2 = case V of
               [] ->
                   OrigIdx = null,
                   #site_email{idx = Idx, email = FromE2,
                               email_validated = false, signature = Sig2};
               [{kvstore, site_email, Rec}] ->
                   case Rec of
                       #site_email{email = FromE2, idx = OrigIdx} ->
                           Rec#site_email{idx = Idx, signature = Sig2};
                       #site_email{idx = OrigIdx} ->
                           #site_email{idx = Idx, email = FromE2,
                                       email_validated = false,
                                       signature = Sig2}
                   end
           end,
    % there can only be one configure_email panel at one time
    case OrigIdx of
        I when I == Idx orelse I == null ->
            HTML = "<div class='hn_site_admin'>"
                ++ "<div class='hn_site_admin_top'>Email Configuration</div>"
                ++ "<div>" ++ Rec2#site_email.email ++ "<br />"
                ++ "<em>Has the email been validated?</em> "
                ++ atom_to_list(Rec2#site_email.email_validated) ++ "<br />"
                ++ "<em>Signature is:</em> " ++ Rec2#site_email.signature
                ++ "</div>",
            ok = new_db_wu:write_kvD(Site, site_email, Rec2),
            RSz = #resize{width = 4, height = 9},
            #spec_val{val = HTML, resize = RSz, unique = site_email};
        OldI ->
            Uniq = new_db_wu:idx_to_xrefXD(Site, OldI),
            #xrefX{path = P, obj = {cell, _} = O} = Uniq,
            "already set in " ++ hn_util:list_to_path(P) ++ hn_util:obj_to_ref(O)
    end.

gather(List) -> gath(List, []).

gath([], Acc) -> io:format("Acc is ~p~n", [Acc]),
                 lists:flatten(lists:reverse(Acc));
gath([#cellref{col = {_, C}, row = {_, R}, path = Path} = H | T], Acc) ->
    Site = ?msite,
    OrigPath = ?mpath,
    Ref = hn_util:obj_to_ref({cell, {?mx + C, ?my + R}}),
    P2 = hn_util:list_to_path(muin_util:walk_path(OrigPath, Path)),
    URL = Site ++ P2 ++ Ref,
    RefX = hn_util:url_to_refX(URL),
    Phone = new_db_wu:get_phone(RefX),
    NewAcc = case Phone of
                 []  -> Acc;
                 [P] -> [P#phone.twiml | Acc]
             end,
    % now just fetch the value and chuck it away
    % need to set up the recalc links properly
    % this is the easiest way to go it
    _Val = muin:fetch(H, "value"),
    gath(T, NewAcc);
gath([#rangeref{text = _Text} = H | T], Acc) ->
    io:format("Rangeref is ~p~n", [H]),
    Cells = muin:expand(H),
    io:format("Cells is ~p~n", [Cells]),
    gath(T, Acc);
% its an unevaluated function so eval it and chuck it back on the pile
gath([H | T], Acc) ->
    Val = muin:external_eval_formula(H),
    NewAcc = case Val of
                 #spec_val{} ->
                     SP_P = Val#spec_val.sp_phone,
                     case SP_P of
                         null ->
                             Acc;
                         _    ->
                             [SP_P#phone.twiml | Acc]
                     end;
                 _           -> Acc
             end,
    gath(T, NewAcc).
