%%% @author gordon <gordon@gordon.dev>
%%% @copyright (C) 2011, gordon
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2011 by gordon <gordon@gordon.dev>

-module(tagcloud).

-export([dump/0]).

dump() ->

    Europe = [
              {'Austria',78},
              {'Slovenia',88},
              {'Malta',90},
              {'Germany',91},
              {'Spain',100},
              {'Netherlands',100},
              {'Greece',101},
              {'Sweden',102},
              {'Italy',106},
              {'Denmark',110},
              {'Poland',113},
              {'England-&-Wales',116},
              {'France',117},
              {'Cyprus',117},
              {'Portugal',120},
              {'Northern-Ireland',123},
              {'Hungary',123},
              {'Luxembourg',126},
              {'Slovakia',129},
              {'Belgium',140},
              {'Ireland-(Eire)',141},
              {'Czech-Republic',142},
              {'Romania',144},
              {'Scotland',146},
              {'Bulgaria',150},
              {'Finland',152},
              {'Estonia',256},
              {'Lithuania',295}
             ],

    NoVics = [{'One',1071},
              {'Two',8},
              {'Three',3}],

    NoKillers = [{'One',780},
                 {'Two',184},
                 {'Three',58},
                 {'Four',24},
                 {'Five',12},
                 {'Six',4},
                 {'Ten',1}
                ],

    WordRenorm = [{'Central',61},
                  {'Dumfries and Galloway',46},
                  {'Fife',60},
                  {'Grampian',83},
                  {'Lothian and Borders ',119},
                  {'Northern ',63},
                  {'Strathclyde',259},
                  {'Tayside',78},
                  {'house',247},
                  {'garden',42},
                  {'common-Stair',58},
                  {'lodgings',40},
                  {'licensed-premises',44},
                  {'commercial-premises',44},
                  {'public-building',22},
                  {'transport',22},
                  {'street',167},
                  {'outdoors',78},
                  {'shooting',67},
                  {'sharp-instrument',229},
                  {'blunt-instrument',96},
                  {'hitting-and-kicking',127},
                  {'strangulation-asphyxiation',80},
                  {'drowning',22},
                  {'fire',46},
                  {'poisoning',85},
                  {'unknown-cause',101},
                  {'Son-or-daughter',57},
                  {'Parent',60},
                  {'lover',121},
                  {'relative',67},
                  {'friend',184},
                  {'criminal-associate',59},
                  {'rival-gang-member',53},
                  {'known-person',131},
                  {'acquaintance',47},
                  {'stranger',124},
                  {'unknown-relationship',76},
                  {'rage-fury',129},
                  {'fight',189},
                  {'jealousy',62},
                  {'sexual',43},
                  {'theft',64},
                  {'feud',102},
                  {'insanity',45},
                  {'contract-killing',17},
                  {'suicide-pact-or-mercy-killing',24},
                  {'other-motive',107},
                  {'unknown-motive',141},
                  {'drunk-killer',220},
                  {'killer-on-drugs',109},
                  {'killer-on-drugs-and-drink',118},
                  {'sober-killer',146},
                  {'under-16',72},
                  {'16-to-20',184},
                  {'21-to-30',229},
                  {'31-to-50',223},
                  {'over-51',95},
                  {'male-killer',366},
                  {'female-killer',128},
                  {'male-victim',294},
                  {'female-victim',151}],

    Words = [
             {'Central',38},
             {'Dumfries and Galloway',22},
             {'Fife',37},
             {'Grampian',70},
             {'Lothian and Borders ',142},
             {'Northern ',40},
             {'Strathclyde',672},
             {'Tayside',61},
             {'house',613},
             {'garden',18},
             {'common-Stair',34},
             {'lodgings',16},
             {'licensed-premises',20},
             {'commercial-premises',20},
             {'public-building',5},
             {'transport',5},
             {'street',280},
             {'outdoors',61},
             {'shooting',45},
             {'sharp-instrument',526},
             {'blunt-instrument',93},
             {'hitting-and-kicking',163},
             {'strangulation-asphyxiation',65},
             {'drowning',5},
             {'fire',22},
             {'poisoning',73},
             {'unknown-cause',104},
             {'Son-or-daughter',33},
             {'Parent',37},
             {'lover',148},
             {'relative',45},
             {'friend',339},
             {'criminal-associate',35},
             {'rival-gang-member',29},
             {'known-person',174},
             {'acquaintance',23},
             {'stranger',155},
             {'unknown-relationship',58},
             {'rage-fury',167},
             {'fight',359},
             {'jealousy',39},
             {'sexual',19},
             {'theft',42},
             {'feud',105},
             {'insanity',21},
             {'contract-killing',3},
             {'suicide-pact-or-mercy-killing',6},
             {'other-motive',115},
             {'unknown-motive',200},
             {'drunk-killer',486},
             {'killer-on-drugs',120},
             {'killer-on-drugs-and-drink',141},
             {'sober-killer',215},
             {'under-16',52},
             {'16-to-20',341},
             {'21-to-30',528},
             {'31-to-50',498},
             {'over-51',92},
             {'male-killer',1346},
             {'female-killer',166},
             {'male-victim',865},
             {'female-victim',231}
            ],

    [logging(X, N, "europe.txt") || {X, N} <- Europe],
    %[logging(X, N, "tagcloud.txt") || {X, N} <- Words],
    %[logging(X, N, "vicscloud.txt") || {X, N} <- NoVics],
    %[logging(X, N, "killerscloud.txt") || {X, N} <- NoKillers],
    %[logging(X, N, "fixedtagcloud.txt") || {X, N} <- WordRenorm],
    ok.

logging(_Atom, 0, _File) -> ok;
logging(Atom, N, File) ->
    log(atom_to_list(Atom), File),
    logging(Atom, N - 1, File).

log(String, File) ->
    Dir = code:lib_dir(hypernumbers) ++ "/../../var/logs/",
    _Return = filelib:ensure_dir(Dir ++ File),

    case file:open(Dir ++ File, [append]) of
        {ok, Id} ->
            io:fwrite(Id, "~s~n", [String]),
            file:close(Id);
        _ ->
            error
    end.

