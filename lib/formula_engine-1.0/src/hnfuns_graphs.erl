%%%-------------------------------------------------------------------
%%% @author    Gordon Guthrie <gordon@hypernumbers.com>
%%% @copyright (C) 2010-2014 Hypernumbers Ltd
%%% @doc       The module for producing graphs
%%%
%%% @end
%%% Created : 11 Jan 2010 by Gordon Guthrie
%%%-------------------------------------------------------------------

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

-module(hnfuns_graphs).

-export([cast_data/1]).

-export([
         'status.bar'/1,
         'sparkline.'/1,
         'sparkbar.'/1,
         'sparkhist.'/1,
         'xy.'/1,
         'speedo.'/1,
         'histogram.'/1,
         'linegraph.'/1,
         'dategraph.'/1,
         'equigraph.'/1,
         'piechart.'/1,
         % deprecated fns
         linegraph/1,
         piechart/1,
         histogram/1,
         barchart/1
        ]).

-define(MARGIN, 0.1).
-define(NOMARGIN, 0.0).

-define(ROW,    true).
-define(COLUMN, false).

-include("typechecks.hrl").
-include("muin_records.hrl").
-include("spriki.hrl").

%% definitions of standard abbreviations
-define(apiurl,     "<img src='http://chart.apis.google.com/chart?").
-define(urlclose,   "' />").
-define(axesrange,  "chxr").  % 0=x, 1=Y, min, max (seperated by |)"
-define(piecolours, "chxs").
-define(axes,       "chxt").  % handles multiple axes
-define(size,       "chs").   % Width x Height
-define(colours,    "chco").  % colours of the lines
-define(data,       "chd").   % data - depends on chart time
-define(datalables, "chdl").  % separated by |
-define(pielables,  "chl").
-define(customscale,"chds").
-define(type,       "cht").
-define(legendpos,  "chdlp"). % t | l | r | b
-define(linestyles, "chls").
-define(margins,    "chma").
-define(title,      "chtt").
-define(titlestyle, "chts").
-define(axeslables, "chxl").
-define(axeslabpos, "chxp").
-define(tickmarks,  "chxt").
-define(speedolab,  "chl").
-define(barwidths,  "chbh").
-define(zeroline,   "chp").

% definition of standard stuff
-define(SPEEDOPARAMS, {array, [[0, 33, 66, 100]]}).
-define(RED,          "FF3333").
-define(ORANGE,       "FF9900").
-define(GREEN,        "80C65A").
-define(GREY,         "999999").
-define(BLACK,        "000000").
-define(NORMALAXES,   "x,y").
-define(LABLEAXES,    "x,x,y,y").
-define(HIST_VGROUP,  "bvg").
-define(HIST_VSTACK,  "bvs").
-define(HIST_HGROUP,  "bhg").
-define(HIST_HSTACK,  "bhs").
-define(PIECHART,     "pc").
-define(XYLINE,       "lxy").
-define(EQXAXIS,      "lc").
-define(SPARKLINE,    "ls").
-define(TOPHORIZ,     "t").
-define(TOPVERT,      "tv").
-define(RIGHTVERT,    "r").
-define(LEFTVERT,     "l").
-define(BOTHORIZ,     "b").
-define(BOTVERT,      "bv").
-define(NORMMARGINS,  "5,5,5,5").
-define(BOTHAXES,     "x,y").
-define(SPKBARWIDTHS, "10,1,2").
-define(SPKBARWIDTH,  10).
-define(SPKBARSPACE,  4).
-define(SPKBARGRPSP,  5).

-define(SPCOLOURS, [
                    "737373",
                    "F15A60",
                    "7AC36A",
                    "5A9BD4",
                    "FAA75B",
                    "9E67AB",
                    "CE7058",
                    "D77FB4"
                   ]).

-define(XYCOLOURS, [
                    "7AC36A",
                    "5A9BD4",
                    "FAA75B",
                    "9E67AB",
                    "CE7058",
                    "D77FB4",
                    "F15A60",
                    "737373"
                   ]).

%%
%% Exported functions
%%
'status.bar'([N])       -> 'status.bar'([N, 1]);
'status.bar'([N, Type]) ->
    [N1] = typechecks:std_nums([N]),
    [Type1] = typechecks:std_ints([Type]),
    N2 = if
             N1 < 0                  -> ?ERR_VAL;
             N1 >= 0 andalso N1 =< 5 -> N1;
             N1 > 5                  -> ?ERR_VAL
         end,
    N3 = integer_to_list(trunc(N2 * 15)),
    if
        Type <  1                   -> ?ERR_VAL;
        Type >= 1 andalso Type =< 6 -> ok;
        Type >  6                   -> ?ERR_VAL
    end,
    'status.bar1'(N3, Type1).

'status.bar1'(Width, 1) -> 'status.bar2'(Width, "progress_black.png");
'status.bar1'(Width, 2) -> 'status.bar2'(Width, "progress_red.png");
'status.bar1'(Width, 3) -> 'status.bar2'(Width, "progress_green.png");
'status.bar1'(Width, 4) -> 'status.bar2'(Width, "ticks.png");
'status.bar1'(Width, 5) -> 'status.bar2'(Width, "crosses.png");
'status.bar1'(Width, 6) -> 'status.bar2'(Width, "hearts.png").

'status.bar2'(Width, File) ->
    "<div style='width:" ++ Width ++ "px;overflow:hidden;'>"
        ++ "<img src='http://files.hypernumbers.com/images/" ++
        File ++ "' /></div>".

'sparkline.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    {Data, Colours} = chunk_spark(List),
    Resize = #resize{width = Width, height = Height},
    HTML = spark1(make_sparksize(Width, Height), Data, Colours),
    #spec_val{val = HTML, resize = Resize}.

chunk_spark([Lines | List]) ->
    [Lines1] = typechecks:throw_std_ints([Lines]),
    muin_checks:ensure(Lines1 > 0, ?ERRVAL_NUM),
    muin_checks:ensure(Lines1 == length(List), ?ERRVAL_NUM),
    % now make the colours
    Colours = allocate_colours(Lines, ?SPCOLOURS),
    Data1 = [cast_data_keep_blank(X) || X <- List],
    Min = lists:min(lists:flatten(Data1)),
    Max = lists:max(lists:flatten(Data1)),
    Diff = Max - Min,
    Data2 = [normalize_sp(X, Min - ?MARGIN * Diff, Max + ?MARGIN * Diff)
             || X <- Data1],
    Data3 = "t:"++conv_data2(Data2),
    {Data3, Colours}.

% avoid a #DIV/0! error
normalize_sp(List, Min, Min)  when Min == 0 ->
    lists:duplicate(length(List), 0);
normalize_sp(List, Min, Min) ->
    lists:duplicate(length(List), 100);
normalize_sp(List, Min, Max) ->
    Diff = Max - Min,
    Fun = fun(blank) -> blank;
             (X)     -> round((X - Min)*1000/Diff)/10
          end,
    [Fun(X) || X <- List].

spark1(Size, Data, Colours) ->
    Opts = [
            {?colours, Colours},
            {?type, ?SPARKLINE},
            {?size, Size},
            {?data, Data},
            {?linestyles, "1|1"}
           ],
    make_chart2(Opts).

'piechart.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    Opts = chunk_pie(List),
    Chart = make_chart2([{?type, ?PIECHART}, {?size, make_size(Width, Height)},
                {?axes, "x"}, {?colours, "bb2222"},
                {?piecolours, "0,444499,11.5"} | Opts]),
    Resize = #resize{width = Width, height = Height},
    #spec_val{val = Chart, resize = Resize}.

'sparkbar.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    Ret = chunk_sparkbar(List),
    {DataY, NoBars, NoGroups, Orientation, MinY, MaxY, Type, Cols, Rest} = Ret,
    BarSize = case Orientation of
                  vertical ->
                      make_barsize(Width, Orientation, NoBars, NoGroups);
                  horizontal ->
                      make_barsize(Height, Orientation, NoBars, NoGroups)
              end,
    Img = sparkhist1(Type, make_sparksize(Width, Height), DataY, MinY, MaxY,
                     Cols, BarSize, Rest, []),
    Img2 = "<div class='hn_sparkS'>" ++ Img ++ "</div>",
    Resize = #resize{width = Width, height = Height},
    #spec_val{val = Img2, resize = Resize}.

'sparkhist.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    Ret = chunk_sparkhist(List),
    {DataY, NoBars, NoGroups, Orientation, MinY, MaxY, Type, Cols, Rest} = Ret,
    BarSize = case Orientation of
                  vertical ->
                      make_barsize(Width, Orientation, NoBars, NoGroups);
                  horizontal ->
                      make_barsize(Height, Orientation, NoBars, NoGroups)
              end,
    Opts = make_zeroline(MinY, MaxY),
    Img = sparkhist1(Type, make_sparksize(Width, Height), DataY, MinY, MaxY,
                     Cols, BarSize, Rest, Opts),
    Img2 = "<div class='hn_spark'>" ++ Img ++ "</div>",
    Resize = #resize{width = Width, height = Height},
    #spec_val{val = Img2, resize = Resize}.

make_zeroline(MinY, MaxY) ->
    if
        MinY < 0 ->
            Z = - MinY /(MaxY - MinY),
            [{?zeroline, float_to_list(Z)}];
        MinY >= 0 ->
            []
    end.

'histogram.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    Ret = chunk_histogram(List),
    {DataX, DataY, MinY, MaxY, Type, Colours, Rest} = Ret,
    Opts = make_zeroline(MinY, MaxY),
    Resize = #resize{width = Width, height = Height},
    HTML = eq_hist1(Type, make_size(Width, Height), DataX, DataY, MinY, MaxY,
                    Colours, Rest, Opts),
    #spec_val{val = HTML, resize = Resize}.

'equigraph.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    Ret = chunk_equigraph(List),
    {DataX, DataY, MinY, MaxY, Colours, Rest} = Ret,
    Resize = #resize{width = Width, height = Height},
    HTML = eq_hist1(equi, make_size(Width, Height), DataX, DataY,
                    MinY, MaxY, Colours, Rest, [{?tickmarks, ?BOTHAXES}]),
    #spec_val{val = HTML, resize = Resize}.

'dategraph.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    Ret = chunk_dategraph(List, double),
    {Data, Scale, AxesLabPos, Colours, Rest, StartDate, EndDate} = Ret,
     Resize = #resize{width = Width, height = Height},
     HTML = dg1(make_size(Width, Height), Data, Scale, AxesLabPos,
                Colours, Rest, StartDate, EndDate, [{?tickmarks, ?BOTHAXES}]),
    #spec_val{val = HTML, resize = Resize}.

'linegraph.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    {Data, Scale, AxesLabPos, Colours, Rest} = chunk_linegraph(List, double),
    Resize = #resize{width = Width, height = Height},
    HTML = xy1(make_size(Width, Height), Data, Scale, AxesLabPos, Colours, Rest,
               [{?tickmarks, ?BOTHAXES}]),
    #spec_val{val = HTML, resize = Resize}.

'xy.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    {Data, Scale, AxesLabPos, Colours, Rest} = chunk_xy(List, double),
    Resize = #resize{width = Width, height = Height},
    HTML = xy1(make_size(Width, Height), Data, Scale, AxesLabPos,
               Colours, Rest, [{?tickmarks, ?BOTHAXES}]),
    #spec_val{val = HTML, resize = Resize}.

chunk_sparkbar([Type, Lines| List]) ->
    [Type2, Lines2] = typechecks:throw_std_ints([Type, Lines]),
    SeriesLength = get_series_length(List),
    muin_checks:ensure(Lines2 > 0, ?ERRVAL_NUM),
    {Orientation, MaxType, Type3, NoBars} = case Type2 of
        0 -> {vertical,   group, ?HIST_VGROUP, Lines2 * SeriesLength};
        1 -> {horizontal, group, ?HIST_HGROUP, Lines2 * SeriesLength};
        _ -> ?ERR_VAL
    end,
    NoGroups = NoBars/Lines2,
    {MinY, MaxY, DataY, Cols, Rest}
        = case {Orientation, MaxType} of
              {vertical,   group} -> chunk_sbar(Lines2, List);
              {horizontal, group} -> chunk_sbar(Lines2, List);
              _                   -> ?ERR_VAL
          end,
    DataY2 = "t:" ++ conv_data_rev(DataY),
    {DataY2, NoBars, NoGroups, Orientation, MinY, MaxY, Type3, Cols, Rest}.

chunk_sparkhist([Type, Lines| List]) ->
    [Type2, Lines2] = typechecks:throw_std_ints([Type, Lines]),
    SeriesLength = get_series_length(List),
    muin_checks:ensure(Lines2 > 0, ?ERRVAL_NUM),
    {Orientation, MaxType, Type3, NoBars} = case Type2 of
        0 -> {vertical,   group, ?HIST_VGROUP, Lines2 * SeriesLength};
        1 -> {vertical,   stack, ?HIST_VSTACK, SeriesLength};
        2 -> {horizontal, group, ?HIST_HGROUP, Lines2 * SeriesLength};
        3 -> {horizontal, stack, ?HIST_HSTACK, SeriesLength};
        _ -> ?ERR_VAL
    end,
    NoGroups = NoBars/Lines2,
    {MinY, MaxY, DataY, Cols, Rest}
        = case {Orientation, MaxType} of
              {vertical,   group} -> chunk_hist(false, Lines2, List, ?NOMARGIN);
              {horizontal, group} -> chunk_hist(false, Lines2, List, ?NOMARGIN);
              {vertical,   stack} -> chunk_hist(true,  Lines2, List, ?NOMARGIN);
              {horizontal, stack} -> chunk_hist(true,  Lines2, List, ?NOMARGIN);
              _                   -> ?ERR_VAL
          end,
    DataY2 = "t:" ++ conv_data_rev(DataY),
    {DataY2, NoBars, NoGroups, Orientation, MinY, MaxY, Type3, Cols, Rest}.

chunk_histogram([Type, X, Lines| List]) ->
    [Type2, Lines2] = typechecks:throw_std_ints([Type, Lines]),
    muin_checks:ensure(Lines2 > 0, ?ERRVAL_NUM),
    {Orientation, MaxType, Type3} = case Type2 of
        0 -> {vertical,   group, ?HIST_VGROUP};
        1 -> {vertical,   stack, ?HIST_VSTACK};
        2 -> {horizontal, group, ?HIST_HGROUP};
        3 -> {horizontal, stack, ?HIST_HSTACK};
        _ -> ?ERR_VAL
    end,
    DataX = cast_strings(X),
    {MinY, MaxY, DataY, Cols, Rest}
        = case {Orientation, MaxType} of
              {vertical,   group} -> chunk_hist(false, Lines2, List, ?NOMARGIN);
              {horizontal, group} -> chunk_hist(false, Lines2, List, ?NOMARGIN);
              {vertical,   stack} -> chunk_hist(true,  Lines2, List, ?NOMARGIN);
              {horizontal, stack} -> chunk_hist(true,  Lines2, List, ?NOMARGIN);
              _                   -> ?ERR_VAL
          end,
    DataY2 = "t:" ++ conv_data_rev(DataY),
    {DataX, DataY2, MinY, MaxY, Type3, Cols, Rest}.

chunk_equigraph([X, Lines | List]) ->
    [Lines2] = typechecks:throw_std_ints([Lines]),
    muin_checks:ensure(Lines2 > 0, ?ERRVAL_NUM),
    DataX = cast_strings(X),
    {MinY, MaxY, DataY, Cols, Rest} = chunk_l2(false, Lines2, List, ?MARGIN),
    DataY2 = "t:" ++ conv_data_rev(DataY),
    {DataX, DataY2, MinY, MaxY, Cols, Rest}.

chunk_dategraph([X, Lines | List], LabType) ->
    [Lines2] = typechecks:throw_std_ints([Lines]),
    muin_checks:ensure(Lines2 > 0, ?ERRVAL_NUM),
    DataX = lists:reverse(cast_dates(X)),
    {MinY, MaxY, DataY, Cols, Rest} = chunk_l2(false, Lines2, List, ?MARGIN),
    {DataX2, MinX, MaxX} = process_x_l2(DataX),
    Data = make_data(DataX2, DataY, []),
    StartDate = cast_date(MinX),
    EndDate = cast_date(MaxX),
    AxesLabPos = make_axes_lab_pos_date(MinX, MaxX, MaxY),
    Scale = make_scale(LabType, auto, MinX, MaxX, MinY, MaxY),
    {Data, {?axesrange, Scale}, {?axeslabpos, AxesLabPos}, Cols, Rest,
     StartDate, EndDate}.

chunk_linegraph([X, Lines | List], LabType) ->
    DataX = cast_data(X),
    [Lines2] = typechecks:throw_std_ints([Lines]),
    {MinY, MaxY, DataY, Cols, Rest} = chunk_l2(false, Lines2, List, ?MARGIN),
    {DataX2, MinX, MaxX} = process_x_l2(DataX),
    Data = make_data(DataX2, DataY, []),
    AxesLabPos = make_axes_lab_pos(MaxX, MaxY),
    Scale = make_scale(LabType, auto, MinX, MaxX, MinY, MaxY),
    {Data, {?axesrange, Scale}, {?axeslabpos, AxesLabPos}, Cols, Rest}.

chunk_sbar(Lines, List) ->
    [Lines2] = typechecks:throw_std_ints([Lines]),
    muin_checks:ensure(Lines2 > 0, ?ERRVAL_NUM),
    {Data, Rest} = lists:split(Lines2, List),
    {MinY, MaxY, DataY} = process_data_sbar(Data),
    % now make the colours
    Colours = allocate_colours(Lines, ?XYCOLOURS),
    {MinY, MaxY, DataY, {?colours, Colours}, Rest}.

chunk_hist(Aggregate, Lines, List, Margin) ->
    [Lines2] = typechecks:throw_std_ints([Lines]),
    muin_checks:ensure(Lines2 > 0, ?ERRVAL_NUM),
    {Data, Rest} = lists:split(Lines2, List),
    {MinY, MaxY, DataY} = process_data_hist(Aggregate, Data, Margin),
    % now make the colours
    Colours = allocate_colours(Lines, ?XYCOLOURS),
    {MinY, MaxY, DataY, {?colours, Colours}, Rest}.

chunk_l2(Aggregate, Lines, List, Margin) ->
    [Lines2] = typechecks:throw_std_ints([Lines]),
    muin_checks:ensure(Lines2 > 0, ?ERRVAL_NUM),
    {Data, Rest} = lists:split(Lines2, List),
    {MinY, MaxY, DataY} = process_data_linegraph(Aggregate, Data, Margin),
    % now make the colours
    Colours = allocate_colours(Lines, ?XYCOLOURS),
    {MinY, MaxY, DataY, {?colours, Colours}, Rest}.

process_x_l2(DataX) ->
    MinX = stdfuns_stats:min(DataX),
    MaxX = stdfuns_stats:max(DataX),
    DataX2 = normalize_sp(DataX, MinX, MaxX),
    {DataX2, MinX, MaxX}.

make_data(_X, [], Acc)     -> "t:" ++ string:join(lists:reverse(Acc), "|");
make_data(X, [H | T], Acc) -> NewAcc = make_d2(X, H, [], []),
                              make_data(X, T, [NewAcc | Acc]).

make_d2([], [], A1, A2)                   -> A1a = [tconv:to_s(X) || X <- A1],
                                             A2a = [tconv:to_s(X) || X <- A2],
                                             string:join(A1a, ",") ++ "|"
                                                 ++ string:join(A2a, ",");
make_d2([_H1 | T1], [blank | T2], A1, A2) -> make_d2(T1, T2, A1, A2);
make_d2([H1 | T1], [H2 | T2], A1, A2)     -> make_d2(T1, T2, [H1 | A1], [H2 | A2]);
make_d2([], _List, _A1, _A2) -> ?ERR_VAL; % X and Y ranges must be congruent
make_d2(_List, [], _A1, _A2) -> ?ERR_VAL. % X and Y ranges must be congruent

chunk_pie([Lines | List]) ->
    [Lines1] = typechecks:throw_std_ints([Lines]),
    muin_checks:ensure(Lines1 > 0, ?ERRVAL_NUM),
    {Data, Rest} = lists:split(Lines1, List),
    Data1 = process_data_pie(Data),
    Title = typechecks:throw_std_strs(Rest),
    Opts = case Title of
               []  -> [];
               [H] -> [{?title, H}];
               _   -> ?ERR_VAL
           end,
    {Lables, Vals} = unzip(Data1, [], []),
    [Vals, Lables | Opts].

unzip([], Lables, Vals) ->
    {{?pielables, string:join(Lables, "|")},
     {?data, "t:"++string:join(Vals, "|")}};
unzip([[H1, H2] | T], Lables, Vals) ->
    unzip(T, [H1 | Lables], [H2 | Vals]).

chunk_xy([Lines | List], LabType) ->
    [Lines1] = typechecks:throw_std_ints([Lines]),
    muin_checks:ensure(Lines1 > 0, ?ERRVAL_NUM),
    {Data, Rest} = lists:split(Lines1, List),
    {MinX, MaxX, MinY, MaxY, Data1} = process_data_xy(Data, ?MARGIN),
    Scale = make_scale(LabType, auto, MinX, MaxX, MinY, MaxY),
    AxesLabPos = make_axes_lab_pos(MaxX, MaxY),
    % now make the colours
    Colours = allocate_colours(Lines, ?XYCOLOURS),
    {Data1, {?axesrange, Scale}, {?axeslabpos, AxesLabPos},
     {?colours, Colours}, Rest}.

sparkhist1(Type, Size, DataY, MinY, MaxY, Colours, BarSize, [], Opts) ->
    Scale = make_eq_hist_scale(Type, MinY, MaxY),
    AddOpts = lists:concat([[BarSize, Scale, Colours], Opts]),
    NewOpts = opts(Type, Size, DataY),
    make_chart(DataY, NewOpts, AddOpts).

eq_hist1(Type, Size, DataX, DataY, MinY, MaxY, Colours, [], Opts) ->
    Axes = {?axes, ?LABLEAXES},
    AxesLables = make_eq_hist_labs(Type, DataX, "", ""),
    Scale = make_eq_hist_scale(Type, MinY, MaxY),
    AddOpts = lists:concat([[Axes, AxesLables, Scale, Colours], Opts]),
    NewOpts = opts(Type, Size, DataY),
    make_chart(DataY, NewOpts, AddOpts);

eq_hist1(Type, Size, DataX, DataY, MinY, MaxY, Colours, [Tt | []], Opts) ->
    Axes = {?axes, ?LABLEAXES},
    AxesLables = make_eq_hist_labs(Type, DataX, "", ""),
    Title = make_title(Tt),
    Scale = make_eq_hist_scale(Type, MinY, MaxY),
    AddOpts = lists:concat([[Title, Axes, AxesLables, Scale, Colours],
                            Opts]),
    NewOpts = opts(Type, Size, DataY),
    make_chart(DataY, NewOpts, AddOpts);

eq_hist1(Type, Size, DataX, DataY, MinY, MaxY, Colours, [Tt, Xl | []],
         Opts) ->
    Axes = {?axes, ?LABLEAXES},
    AxesLables = make_eq_hist_labs(Type, DataX, Xl, ""),
    Title = make_title(Tt),
    Scale = make_eq_hist_scale(Type, MinY, MaxY),
    AddOpts = lists:concat([[Title, Axes, AxesLables,
                             Scale, Colours], Opts]),
    NewOpts = opts(Type, Size, DataY),
    make_chart(DataY, NewOpts, AddOpts);

eq_hist1(Type, Size, DataX, DataY, MinY, MaxY, Colours, [Tt, Xl, Yl | []],
         Opts) ->
    Axes = {?axes, ?LABLEAXES},
    AxesLables = make_eq_hist_labs(Type, DataX, Xl, Yl),
    Title = make_title(Tt),
    Scale = make_eq_hist_scale(Type, MinY, MaxY),
    AddOpts = lists:concat([[Title, Axes, AxesLables,
                             Scale, Colours], Opts]),
    NewOpts = opts(Type, Size, DataY),
    make_chart(DataY, NewOpts, AddOpts);

eq_hist1(Type, Size, DataX, DataY, MinY, MaxY, Colours, [Tt, Xl, Yl, Srs | []],
         Opts) ->
    Axes = {?axes, ?LABLEAXES},
    AxesLables = make_eq_hist_labs(Type, DataX, Xl, Yl),
    Title = make_title(Tt),
    Scale = make_eq_hist_scale(Type, MinY, MaxY),
    Series = make_series(Srs),
    AddOpts = lists:concat([[Title, Series, Axes, AxesLables,
                             {?legendpos, ?TOPHORIZ}, Scale, Colours], Opts]),
    NewOpts = opts(Type, Size, DataY),
    make_chart(DataY, NewOpts, AddOpts);

% barwidth is only an option for histograms
eq_hist1(Type, Size, DataX, DataY, MinY, MaxY, Colours,
         [Tt, Xl, Yl, Srs, BarWidth | []], Opts)
  when Type == ?HIST_VGROUP orelse Type == ?HIST_VSTACK
       orelse Type == ?HIST_HGROUP orelse Type == ?HIST_HSTACK->
    Axes = {?axes, ?LABLEAXES},
    AxesLables = make_eq_hist_labs(Type, DataX, Xl, Yl),
    Title = make_title(Tt),
    Scale = make_eq_hist_scale(Type, MinY, MaxY),
    Series = make_series(Srs),
    [BarW2] = typechecks:std_pos_ints([BarWidth]),
    BarOpts = {?barwidths, make_list(BarW2, ?SPKBARSPACE,
                                            ?SPKBARGRPSP)},
    AddOpts = lists:concat([[BarOpts, Title, Series, Axes, AxesLables,
                             {?legendpos, ?TOPHORIZ}, Scale, Colours], Opts]),
    NewOpts = opts(Type, Size, DataY),
    make_chart(DataY, NewOpts, AddOpts).

dg1(Size, Data, Scale, AxesLabPos, Colours, [], StartDate, EndDate, Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos,
                             make_labs_date("", "", StartDate, EndDate),
                             {?axes, ?LABLEAXES}], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts);
dg1(Size, Data, Scale, AxesLabPos, Colours, [Tt | []], StartDate, EndDate, Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_title(Tt),
                             make_labs_date("", "", StartDate, EndDate),
                            {?axes, ?LABLEAXES}], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts);
dg1(Size, Data, Scale, AxesLabPos, Colours, [Tt, Xl | []],
    StartDate, EndDate, Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_title(Tt),
                             make_labs_date(Xl, "", StartDate, EndDate),
                             {?axes, ?LABLEAXES}], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts);
dg1(Size, Data, Scale, AxesLabPos, Colours, [Tt, Xl, Yl | []],
    StartDate, EndDate, Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_title(Tt),
                             make_labs_date(Xl, Yl, StartDate, EndDate),
                             {?axes, ?LABLEAXES}], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts);
dg1(Size, Data, Scale, AxesLabPos, Colours, [Tt, Xl, Yl, Srs | []],
    StartDate, EndDate, Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_title(Tt),
                             make_labs_date(Xl, Yl, StartDate, EndDate),
                             {?axes, ?LABLEAXES},
                             {?legendpos, ?TOPHORIZ}, make_series(Srs)], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts).

xy1(Size, Data, Scale, AxesLabPos, Colours, [], Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_labs("", ""),
                             {?axes, ?LABLEAXES}], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts);
xy1(Size, Data, Scale, AxesLabPos, Colours, [Tt | []], Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_title(Tt),
                             make_labs("", ""),
                            {?axes, ?LABLEAXES}], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts);
xy1(Size, Data, Scale, AxesLabPos, Colours, [Tt, Xl | []], Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_title(Tt),
                             make_labs(Xl, ""), {?axes, ?LABLEAXES}], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts);
xy1(Size, Data, Scale, AxesLabPos, Colours, [Tt, Xl, Yl | []], Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_title(Tt),
                             make_labs(Xl, Yl), {?axes, ?LABLEAXES}], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts);
xy1(Size, Data, Scale, AxesLabPos, Colours, [Tt, Xl, Yl, Srs | []], Opts) ->
    AddOpts = lists:concat([[Scale, Colours, AxesLabPos, make_title(Tt),
                             make_labs(Xl, Yl), {?axes, ?LABLEAXES},
                             {?legendpos, ?TOPHORIZ}, make_series(Srs)], Opts]),
    NewOpts = xyopts(Size, Data),
    make_chart(Data, NewOpts, AddOpts).

opts(equi,      Size, Data) -> eqopts(Size, Data);
opts(Histogram, Size, Data) -> histopts(Histogram, Size, Data).

histopts(Histogram, Size, Data) ->
    [
     {?type, Histogram},
     {?size, Size},
     {?data, Data},
     {?linestyles, "1|1"}
    ].

eqopts(Size, Data) ->
    [
     {?type, ?EQXAXIS},
     {?size, Size},
     {?data, Data},
     {?linestyles, "1|1"}
    ].

xyopts(Size, Data) ->
    [
     {?type, ?XYLINE},
     {?size, Size},
     {?data, Data},
     {?linestyles, "1|1"}
    ].

make_chart(Data, Opts, AddOpts) ->
    case has_error([Data]) of
        {true, Error} -> Error;
        false         -> make_chart2(lists:concat([Opts, AddOpts]))
    end.

make_series(Srs) ->
    Srs2 = lists:reverse(typechecks:throw_flat_strs([Srs])),
    {?datalables, string:join(Srs2, "|")}.

make_eq_hist_scale(Type, MinY, MaxY)
  when Type == equi
       orelse Type == ?HIST_VGROUP
       orelse Type == ?HIST_VSTACK ->
    {?axesrange, make_scale(single, auto, 0, 100, MinY, MaxY)};
make_eq_hist_scale(Type, MinY, MaxY)
  when Type == ?HIST_HGROUP
       orelse Type == ?HIST_HSTACK ->
    {?axesrange, make_scale(single, auto, MinY, MaxY, 0, 100)}.

make_eq_hist_labs(Type, XAxis, XTitle, YTitle)
  when Type == equi
       orelse Type == ?HIST_VGROUP
       orelse Type == ?HIST_VSTACK ->
    {?axeslables, "0:|" ++ string:join(XAxis, "|") ++ "|"
     ++"|1:||"++XTitle++"|3:||"++YTitle};
make_eq_hist_labs(Type, XAxis, XTitle, YTitle)
  when Type == ?HIST_HGROUP
       orelse Type == ?HIST_HSTACK ->
    {?axeslables, "1:||"++YTitle++"|2:|" ++
     string:join(lists:reverse(XAxis), "|") ++ "|"
     ++ "|3:||"++XTitle}.

make_labs_date(X, Y, StartDate, EndDate) ->
    [X1, Y1] = typechecks:throw_std_strs([X, Y]),
    {?axeslables, "0:|"++StartDate++"|"++EndDate
           ++"|1:||"++X1++"|3:||"++Y1}.

make_labs(X, Y) ->
    [X1, Y1] = typechecks:throw_std_strs([X, Y]),
    {?axeslables, "1:|"++X1++"|3:|"++Y1}.

make_title(Title) ->
    [T2] = typechecks:throw_std_strs([Title]),
    {?title, T2}.

make_axes_lab_pos_date(MinX, MaxX, MaxY) ->
    "0,"++tconv:to_s(MinX)++","++tconv:to_s(MaxX)++"|1,"
        ++tconv:to_s(MaxX)++"|3,"++tconv:to_s(MaxY).

make_axes_lab_pos(MaxX, MaxY) ->
    "1,"++tconv:to_s(MaxX)++"|3,"++tconv:to_s(MaxY).

make_scale(null, _, _, _, _, _) -> "";
make_scale(single, auto, MinX, MaxX, MinY, MaxY) ->
    "0,"++tconv:to_s(MinX)++","++tconv:to_s(MaxX)
        ++"|2,"++tconv:to_s(MinY)++","++tconv:to_s(MaxY);
make_scale(double, auto, MinX, MaxX, MinY, MaxY) ->
    "0,"++tconv:to_s(MinX)++","++tconv:to_s(MaxX)
        ++"|1,"++tconv:to_s(MinX)++","++tconv:to_s(MaxX)
        ++"|2,"++tconv:to_s(MinY)++","++tconv:to_s(MaxY)
        ++"|3,"++tconv:to_s(MinY)++","++tconv:to_s(MaxY).

cast_date(N) ->
    {datetime, D, T} = muin_util:cast(N, num, date),
    dh_date:format("d-M-y", {D, T}).

make_chart2(List) -> make_c2(List, []).

make_c2([], Acc)           -> lists:flatten([?apiurl | Acc]) ++ ?urlclose;
make_c2([{K, V} | T], Acc) -> NewAcc = "&amp;" ++ K ++ "=" ++ V,
                              make_c2(T, [NewAcc | Acc]).

'speedo.'([W, H | List]) ->
    [Width] = typechecks:throw_std_ints([W]),
    [Height] = typechecks:throw_std_ints([H]),
    Resize = #resize{width = Width, height = Height},
    HTML = speedo(make_size(Width, Height),  List),
    #spec_val{val = HTML, resize = Resize}.

speedo(Size, [V])               -> speedo1(Size, V, "", "",   ?SPEEDOPARAMS);
speedo(Size, [V, Tt])           -> speedo1(Size, V, Tt, "",   ?SPEEDOPARAMS);
speedo(Size, [V, Tt, SubT])     -> speedo1(Size, V, Tt, SubT, ?SPEEDOPARAMS);
speedo(Size, [V, Tt, SubT, Th]) -> speedo1(Size, V, Tt, SubT, Th).

speedo1(Size, Val, Title, Subtitle, Thresholds) ->
    [V2] = typechecks:std_nums([Val]),
    [Tt2]  = cast_titles(Title),
    [Sb2]  = cast_titles(Subtitle),
    {V3, Colours, Lables} = speedo_scale(Thresholds, V2),
    if
        V3 < 0   -> ?ERRVAL_VAL;
        V3 > 100 -> ?ERRVAL_VAL;
        0 =< V3 andalso V3 =< 100 ->
            Opts = [],
            NewOpts = [
                       Colours,
                       Lables,
                       {?tickmarks, "y"},
                       {?size, Size},
                       {?type, "gm"},
                       {?data, "t:" ++ tconv:to_s(V3)},
                       {?titlestyle, "000000,18"},
                       {?speedolab, Sb2},
                       {?title, Tt2}
                       ],
            case Opts of
                [] -> make_chart2(NewOpts);
                _  -> make_chart2(lists:concat([Opts, NewOpts]))
            end
    end.

speedo_scale(Th, Val) ->
    NoOfColours = 100,
    NoOfCMinus1 = 99,
    NoOfCMinus2 = 98,
    [Zero, Orange, Red, Max] = lists:reverse(cast_data(Th)),
    Diff = Max - Zero,
    NGreen = trunc(((Orange - Zero)/Diff) * NoOfColours),
    NOrange = trunc(((Red - Orange)/Diff) * NoOfColours),
    NRed = trunc(((Max - Red)/Diff) * NoOfColours),
    {NRed2, NOrange2} = case NGreen + NOrange + NRed of
                            NoOfColours -> {NRed,     NOrange};
                            NoOfCMinus1 -> {NRed + 1, NOrange};
                            NoOfCMinus2 -> {NRed + 1, NOrange + 1}
                        end,
    Cols = lists:concat([lists:duplicate(NGreen,   ?GREEN),
                         lists:duplicate(NOrange2, ?ORANGE),
                         lists:duplicate(NRed2,    ?RED)]),
    Labs = lists:concat([make_blanks(NoOfColours)]),
    Lables = {?axeslables, "0:|" ++  string:join(Labs, "|")},
    Colours = {?colours, ?BLACK ++ "," ++ string:join(Cols, "|")},
    V = ((Val - Zero)/Diff*100),
    {V, Colours, Lables}.

make_blanks(N) when N < 1 -> [];
make_blanks(N)            -> lists:duplicate(N, []).

barchart([Data]) ->
    bar(Data, 0, {{scale, auto}, [], []});
barchart([Data, O])           ->
    bar(Data, O, {{scale, auto}, [], []});
barchart([Data, O, XAxis]) ->
    bar(Data, O, {{scale, auto}, XAxis, []});
barchart([Data, O, XAxis, Cols]) ->
    bar(Data, O, {{scale, auto}, XAxis, Cols});
barchart([Data, O, XAxis, Cols, Min, Max]) ->
    bar(Data, O, {{Min, Max}, XAxis, Cols}).

bar(Data, Orientation, {Scale, Axes, Colours}) ->
    Orientation2 = cast_orientation(Orientation),
    case has_error([Data, Orientation2, Scale, Axes, Colours]) of
        {true, Error} -> Error;
        false         -> bar2(Data, Orientation2, Scale, Axes, Colours)
    end.

bar2(Data, Orientation, Scale, Axes, Colours) ->
    {Data2, _NoOfRows, _NoOfCols} = extract(Data, Orientation),
    Data3      = [cast_data(X) || X <- Data2],
    Colours2   = get_colours(Colours),
    {Min, Max} = get_scale(Scale, Data3),
    XAxis2     = get_axes(Axes),
    case has_error([Data3, Colours2, Min, Max, XAxis2]) of
        {true, Error} -> Error;
        false         -> bar3(rev(Data3), {Min, Max}, XAxis2, Colours2)
    end.

bar3(Data, {Min, Max}, XAxis, Colours) ->
    "<img src='http://chart.apis.google.com/chart?chs=350x150&amp;chd="
        ++ "t:" ++ conv_data(Data) ++ "&amp;cht=bvs&amp;"
        ++ "chds="++ tconv:to_s(Min) ++ "," ++ tconv:to_s(Max)
        ++ "&amp;"
        ++ "chxt=y&amp;"
        ++ "chxt="
        ++ conv_x_axis(XAxis)
        ++ "1:|" ++ tconv:to_s(Min) ++ "|" ++ tconv:to_s(Max)
        ++ conv_colours(Colours)
        ++ "' />".

linegraph([Data]) ->
    linegraph([Data, ?ROW]);
linegraph([Data, O])           ->
    lg1(Data, O, {{scale, auto}, [], []});
linegraph([Data, O, XAxis]) ->
    lg1(Data, O, {{scale, auto}, XAxis, []});
linegraph([Data, O, XAxis, Cols]) ->
    lg1(Data, O, {{scale, auto}, XAxis, Cols});
linegraph([Data, O, XAxis, Cols, Min, Max]) ->
    lg1(Data, O, {{Min, Max}, XAxis, Cols}).

lg1(Data, Orientation, {Scale, Axes, Colours}) ->
    Orientation2 = cast_orientation(Orientation),
    case has_error([Data, Orientation2, Scale, Axes, Colours]) of
        {true, Error} -> Error;
        false         -> lg2(Data, Orientation2, Scale, Axes, Colours)
    end.

lg2(Data, Orientation, Scale, Axes, Colours) ->
    {Data2, _NoOfRows, _NoOfCols} = extract(Data, Orientation),
    Data3      = [cast_data(X) || X <- Data2],
    Colours2   = get_colours(Colours),
    {Min, Max} = get_scale(Scale, Data3),
    XAxis2     = get_axes(Axes),
    case has_error([Data3, Colours2, Min, Max, XAxis2]) of
        {true, Error} -> Error;
        false         -> lg3(rev(Data3), {Min, Max}, XAxis2, Colours2)
    end.

lg3(Data, {Min, Max}, XAxis, Colours) ->
    "<img src='http://chart.apis.google.com/chart?chs=350x150&amp;chd="
        ++ "t:" ++ conv_data(Data) ++ "&amp;cht=lc&amp;"
        ++ "chds="++ tconv:to_s(Min) ++ "," ++ tconv:to_s(Max)
        ++ "&amp;chxt="
        ++ conv_x_axis(XAxis)
        ++ "1:|" ++ tconv:to_s(Min) ++ "|" ++ tconv:to_s(Max)
        ++ conv_colours(Colours)
        ++ "' />".

piechart([Data])                  -> pie1(Data, [], []);
piechart([Data, Titles])          -> pie1(Data, Titles, []);
piechart([Data, Titles, Colours]) -> pie1(Data, Titles, Colours).

histogram([D])                   -> hist1(D, {{scale, auto}, [], []});
histogram([D, Tt])               -> hist1(D, {{scale, auto}, Tt, []});
histogram([D, Tt, Cols])         -> hist1(D, {{scale, auto}, Tt, Cols});
histogram([D, Tt, Cols, Mn, Mx]) -> hist1(D, {{Mn, Mx}, Tt, Cols}).

%%
%% Internal Functions
%%
process_data_sbar(Data) ->
    Prefetched = cast_prefetch(Data),
    Data1 = [proc_dxy1(X) || X <- Prefetched],
    Data2 = [X || {X, _NoR, _NoC} <- Data1],
    Data3 = [lists:flatten([cast_linegraph_data(X) || X <- X1])
             || X1 <- Data2],
    {MinY, MaxY} = get_maxes_lg(Data3),
    % we need the real mins/maxes to normalise the data
    % if its a stacker we need the aggregate mins/maxs
    BottomMargin = case MinY of
                       0 -> ?NOMARGIN;
                       _ -> ?MARGIN
                   end,
    Diff = MaxY - MinY,
    MinY2 = MinY - BottomMargin * Diff,
    MaxY2 = MaxY + ?MARGIN * Diff,
    Data4 = normalize_linegraph(Data3, MinY2, MaxY2, []),
    {MinY2, MaxY2, Data4}.

process_data_hist(Aggregate, Data, Margin) ->
    Prefetched = cast_prefetch(Data),
    Data1 = [proc_dxy1(X) || X <- Prefetched],
    Data2 = [X || {X, _NoR, _NoC} <- Data1],
    Data3 = [lists:flatten([cast_linegraph_data(X) || X <- X1])
             || X1 <- Data2],
    {MinY, MaxY} = get_maxes_lg(Data3),
    % we need the real mins/maxes to normalise the data
    % if its a stacker we need the aggregate mins/maxs
    MaxY2 = case Aggregate of
                       false -> MaxY;
                       true  -> get_maxes_lg_agg(Data3)
                   end,
    Diff = MaxY2 - MinY,
    MinY3 = MinY - Margin * Diff,
    MaxY3 = MaxY2 + Margin * Diff,
    MinY3a = if
                MinY3 <  0 -> MinY3;
                MinY3 >= 0 -> 0
            end,
    Data4 = normalize_linegraph(Data3, MinY3a, MaxY3, []),
    {MinY3a, MaxY3, Data4}.

process_data_linegraph(Aggregate, Data, Margin) ->
    Prefetched = cast_prefetch(Data),
    Data1 = [proc_dxy1(X) || X <- Prefetched],
    Data2 = [X || {X, _NoR, _NoC} <- Data1],
    Data3 = [lists:flatten([cast_linegraph_data(X) || X <- X1])
             || X1 <- Data2],
    {MinY, MaxY} = get_maxes_lg(Data3),
    % we need the real mins/maxes to normalise the data
    % if its a stacker we need the aggregate mins/maxs
    MaxY2 = case Aggregate of
                       false -> MaxY;
                       true  -> get_maxes_lg_agg(Data3)
                   end,
    Diff = MaxY2 - MinY,
    MinY3 = MinY - Margin * Diff,
    MaxY3 = MaxY2 + Margin * Diff,
    Data4 = normalize_linegraph(Data3, MinY3, MaxY3, []),
    {MinY3, MaxY3, Data4}.

process_data_pie(Data) ->
    Prefetched = cast_prefetch(Data),
    Data1 = [proc_dxy1(X) || X <- Prefetched],
    Data2 = [X || {X, _NoR, _NoC} <- Data1],
    Fun = fun([Labs, Vals], Acc) ->
                  L2 = cast_strings(Labs),
                  L3 = string:join(L2, "|"),
                  V2 = normalize(lists:reverse(cast_data(Vals))),
                  V3 = string:join([tconv:to_s(X) || X <- V2], ","),
                  [[L3, V3] | Acc]
          end,
    lists:foldl(Fun, [], Data2).

process_data_xy(Data, Margin) ->
    Prefetched = cast_prefetch(Data),
    Data1 = [proc_dxy1(X) || X <- Prefetched],
    Data2 = [X || {X, _NoR, _NoC} <- Data1],
    Data3 = [[lists:reverse(cast_data_keep_blank(X)) || X <- X1] || X1 <- Data2],
    {MinX, MaxX, MinY, MaxY} = get_maxes(Data3),
    DiffY = MaxY - MinY,
    Data4 = normalize_xy(Data3, MinX, MaxX, MinY - Margin * DiffY,
                         MaxY + Margin * DiffY, []),
    Data5 = [conv_data(X) || X <- Data4],
    {MinX, MaxX, MinY, MaxY, "t:"++string:join(Data5, "|")}.

normalize_linegraph([], _, _, Acc) -> lists:reverse(Acc);
normalize_linegraph([H | T], Min, Max, Acc) ->
    NewAcc = lists:reverse(normalize_sp(H, Min, Max)),
    normalize_linegraph(T, Min, Max, [NewAcc | Acc]).

normalize_xy([], _, _, _, _, Acc) -> lists:reverse(Acc);
normalize_xy([[H1, H2] | T], MinX, MaxX, MinY, MaxY, Acc) ->
    NewH1 = lists:reverse(normalize_sp(H1, MinX, MaxX)),
    NewH2 = lists:reverse(normalize_sp(H2, MinY, MaxY)),
    normalize_xy(T, MinX, MaxX, MinY, MaxY, [[NewH1, NewH2] | Acc]).

proc_dxy1({Type, X} = R) when Type == range orelse Type == array->
    if
        length(X) ==  2 -> extract(R, ?ROW);
        length(X) =/= 2 -> extract(R, ?COLUMN)
    end.

get_maxes_lg_agg([H | _T] = List) ->
    Len = length(H),
    Acc = lists:duplicate(Len, 0),
    Agg = aggregate(List, Acc),
    stdfuns_stats:max(Agg).

aggregate([], Acc)      -> Acc;
aggregate([H | T], Acc) -> Acc2 = agg2(H, Acc, []),
                           aggregate(T, Acc2).

agg2([], [], Acc)                     -> lists:reverse(Acc);
agg2([blank | T1], [blank | T2], Acc) -> agg2(T1, T2, [0 | Acc]);
agg2([blank | T1], [H2 | T2],    Acc) -> agg2(T1, T2, [H2 | Acc]);
agg2([H1 | T1],    [blank | T2], Acc) -> agg2(T1, T2, [H1 | Acc]);
agg2([H1 | T1],    [H2 | T2],    Acc) -> agg2(T1, T2, [H1 + H2 | Acc]).

get_maxes_lg(List) -> get_mlg(List, none, none).

get_mlg([], Min, Max)        -> {Min, Max};
get_mlg([H | T], none, none) -> Min = stdfuns_stats:min(H),
                                Max = stdfuns_stats:max(H),
                                get_mlg(T, Min, Max);
get_mlg([H | T], Min, Max)   -> NewMin = stdfuns_stats:min([Min | H]),
                                NewMax = stdfuns_stats:max([Max | H]),
                                get_mlg(T, NewMin, NewMax).

get_maxes([[X, Y] | T]) -> get_m2(T,
                                  stdfuns_stats:min(X),
                                  stdfuns_stats:max(X),
                                  stdfuns_stats:min(Y),
                                  stdfuns_stats:max(Y)).

get_m2([], MinX, MaxX, MinY, MaxY) -> {MinX, MaxX, MinY, MaxY};
get_m2([[X, Y] | T], MinX, MaxX, MinY, MaxY) ->
    get_m2(T,
           stdfuns_stats:min([MinX | X]),
           stdfuns_stats:max([MaxX | X]),
           stdfuns_stats:min([MinY | Y]),
           stdfuns_stats:max([MaxY | Y])).

hist1(Data, {Scale, Titles, Colours}) ->
    Data2      = lists:reverse(cast_data(Data)),
    Titles2    = cast_titles(Titles),
    Colours2   = get_colours(Colours),
    {Min, Max} = get_scale(Scale, Data2),
    case has_error([Data2, Min, Max, Titles2, Colours2]) of
        {true, Error} -> Error;
        false         -> hist2(Data2, Min, Max, Titles2, Colours2)
    end.

hist2(Data, Min, Max, Titles, Colours) ->
    Data1    = make_data(normalize(Data)),
    Titles1  = make_titles(Titles),
    Colours1 = conv_colours(Colours),
    "<img src='http://chart.apis.google.com/chart?cht=bvs&amp;chd=t:"
        ++ Data1
        ++ "&amp;chxt=y&amp;chxl=0:|"
        ++ tconv:to_s(Min) ++ "|" ++ tconv:to_s(Max)
        ++ "&amp;chs=250x100&amp;chl="
        ++ Titles1
        ++ Colours1
        ++"' />".

pie1(Data, Titles, Colours) ->
    Data2    = cast_data(Data),
    Titles2  = cast_titles(Titles),
    Colours2 = get_colours(Colours),
    case has_error([Data2, Titles2, Colours2]) of
        {true, Error} -> Error;
        false         -> pie2(Data2, Titles2, Colours2)
    end.

pie2(Data, Titles, Colours) ->
    Data1    = make_data(normalize(Data)),
    Titles1  = make_titles(Titles),
    Colours1 = conv_colours(Colours),
    "<img src='http://chart.apis.google.com/chart?cht=p3&amp;chd=t:"
        ++ Data1
        ++ "&amp;chs=450x100&amp;chl="
        ++ Titles1
        ++ Colours1
        ++ "' />".

cast_prefetch(Data) ->
    muin_collect:col(Data, [fetch_ref], []).

cast_linegraph_data(Data) ->
    muin_collect:col([Data],
                     [eval_funs,
                      fetch, flatten,
                      {cast, bool, num},
                      empty_str_as_blank
                     ],
                     [return_errors]).

cast_dates(Data) ->
    muin_collect:col([Data],
                     [eval_funs,
                      fetch, flatten,
                      {cast, date, num},
                      {cast, bool, num},
                      {cast, blank, num},
                      {ignore, blank}
                     ],
                     [return_errors, {all, fun is_number/1}]).
cast_data(Data) ->
    muin_collect:col([Data],
                     [eval_funs,
                      fetch, flatten,
                      {cast, str, num, ?ERRVAL_VAL},
                      {cast, bool, num},
                      {cast, blank, num},
                      {ignore, str},
                      {ignore, blank}
                     ],
                     [return_errors, {all, fun is_number/1}]).

cast_data_keep_blank(Data) ->
    muin_collect:col([Data],
                     [eval_funs,
                      fetch, flatten,
                      {cast, bool, num},
                      {ignore, str}
                     ],
                     [return_errors]).

cast_strings(String) -> cast_titles(String).

cast_titles(Titles) ->
    muin_collect:col([Titles],
                     [eval_funs,
                      fetch, flatten,
                      {cast, bool, str},
                      {cast, num, str},
                      {cast, date, str},
                      {cast, blank, str}],
                     [return_errors]).

cast_orientation(Or) ->
    [CastOr] = muin_collect:col([Or],
                                [eval_funs,
                                 fetch,
                                 {cast, num, bool, ?ERRVAL_VAL},
                      {cast, str, bool, ?ERRVAL_VAL}],
                                [return_errors, {all, fun is_boolean/1}]),
    CastOr.

conv_colours([[]])    ->
    [];
conv_colours(Colours) ->
    "&amp;chco=" ++ make_colours(Colours).

conv_x_axis([]) ->
    "y&amp;chxl=";
conv_x_axis(XAxis) ->
    "x,y&amp;chxl=0:|" ++ string:join(XAxis, "|") ++ "|".



conv_data_rev(Data) ->
    conv_drev(Data, []).

conv_drev([], Acc) ->
    string:join(lists:reverse(Acc), "|");
conv_drev([H | T], Acc) ->
    conv_drev(T, [make_data_rev(H) | Acc]).

conv_data([X, Y]) ->
    conv_d1(X, Y, [], []).

conv_d1([], [], AccX, AccY) ->
    string:join(lists:reverse(AccX), ",") ++ "|"
        ++ string:join(lists:reverse(AccY), ",");
conv_d1([_HX | TX], [blank | TY],  AccX, AccY) ->
    conv_d1(TX, TY, AccX, AccY);
conv_d1([HX | TX], [HY | TY],  AccX, AccY) ->
    conv_d1(TX, TY, [tconv:to_s(HX) | AccX], [tconv:to_s(HY) | AccY]).

conv_data2(Data) -> conv_d2(Data, []).

conv_d2([], Acc)      -> string:join(lists:reverse(Acc), "|");
conv_d2([H | T], Acc) -> conv_d2(T, [make_data(H) | Acc]).

get_colours(Colours) ->
    muin_collect:col([Colours],
                     [eval_funs,
                      {ignore, bool},
                      {ignore, num},
                      {ignore,date},
                      fetch, flatten],
                     [return_errors, {all, fun is_list/1}]).

get_axes(XAxis)  ->
    muin_collect:col([XAxis],
                     [eval_funs,
                      fetch, flatten,
                      {cast, num, str},
                      {cast, bool, str},
                      {cast, date, str},
                      {cast, blank, str}],
                     [return_errors]).

get_scale({scale, auto}, [H | T]) when is_list(H) ->
    Min = tconv:to_s(stdfuns_stats:min(lists:merge([H | T]))),
    Max = tconv:to_s(stdfuns_stats:max(lists:merge([H | T]))),
    {Min, Max};
get_scale({scale, auto}, Data) ->
    Min = tconv:to_s(stdfuns_stats:min(Data)),
    Max = tconv:to_s(stdfuns_stats:max(Data)),
    {Min, Max};
get_scale(Scale, _Data) ->
    Scale.

extract({Type, Data}, ?ROW) when Type == range orelse Type == array ->
    tartup(Data);
extract({Type, Data}, ?COLUMN) when Type == range orelse Type == array ->
    tartup(hslists:transpose(Data)).

tartup(Data) ->
    [F | _T] = Data,
    NoOfCols = length(F), % rectangular matrix
    {chunk(Data), length(Data), NoOfCols}.

rev(List) -> rev1(List, []).

rev1([], Acc)      -> lists:reverse(Acc);
rev1([H | T], Acc) -> rev1(T, [lists:reverse(H) | Acc]).

chunk(Data) -> chk2(Data, []).

chk2([], Acc)      -> lists:reverse(Acc);
chk2([H | T], Acc) -> chk2(T, [{range, [H]} | Acc]).

has_error([]) ->
    false;
has_error([{errval, Val} | _T]) ->
    {true, {errval, Val}};
has_error([H | T]) when is_list(H) ->
    case has_error(H) of
        {true, E} -> {true, E};
        false     -> has_error(T)
    end;
has_error([_H | T]) ->
    has_error(T).

normalize(Data) ->
    Total = lists:sum(Data),
    Fun = fun(X) -> round(1000*X/Total)/10 end,
    lists:map(Fun, Data).

make_data_rev(List) ->
    make_drev(List, []).

make_drev([], Acc) ->
    string:join(Acc, ",");
make_drev([blank | T], Acc) ->
    make_drev(T, ["0" | Acc]);
make_drev([H | T], Acc) when is_integer(H) ->
    make_drev(T, [integer_to_list(H) | Acc]);
make_drev([H | T], Acc) when is_float(H) ->
    make_drev(T, [tconv:to_s(H) | Acc]);
make_drev(_List, _Acc) -> ?ERR_VAL.

make_data(List) ->
    make_d1(List, []).

make_d1([], Acc) ->
    string:join(lists:reverse(Acc), ",");
make_d1([H | T], Acc) when is_integer(H) ->
    make_d1(T, [integer_to_list(H) | Acc]);
make_d1([H | T], Acc) when is_float(H) ->
    make_d1(T, [tconv:to_s(H) | Acc]).

make_titles(List) ->
    string:join(List, "|").

make_colours(List) ->
    string:join([ replace_colour(Colour) || Colour <- List ], ",").

replace_colour(Colour) ->
    case lists:keysearch(Colour, 1, colours()) of
        {value, {Colour, Val}} -> Val;
        false                  -> Colour
    end.

allocate_colours(N, Colours) ->
    NoOfCols = length(Colours),
    NSets = trunc(N/NoOfCols),
    Rem = N rem NoOfCols,
    {Extra, _Rest} = lists:split(Rem, Colours),
    Dup = lists:concat(lists:duplicate(NSets, Colours)),
    NewList = lists:concat([Dup, Extra]),
    string:join(NewList, ",").

colours() -> [
              {"blue"    , "0000FF"},
              {"green"   , "008000"},
              {"red"     , "FF0000"},
              {"maroon"  , "800000"},
              {"navy"    , "000080"},
              {"black"   , "000000"},
              {"purple"  , "800080"},
              {"silver"  , "C0C0C0"},
              {"lime"    , "00FF00"},
              {"gray"    , "808080"},
              {"olive"   , "808000"},
              {"white"   , "FFFFFF"},
              {"teal"    , "008080"},
              {"fuchsia" , "FF00FF"},
              {"aqua"    , "00FFFF"},
              {"yellow"  , "FFFF00"}
             ].

make_sparksize(W, H) -> make_width(W) ++ "x" ++ make_sparkheight(H).

make_size(W, H) -> make_sparkwidth(W) ++ "x" ++ make_height(H).

make_sparkheight(N) -> integer_to_list(N * 22 - 1 - 4).

make_sparkwidth(N) -> integer_to_list(N * 80 - 10).

make_height(N) -> integer_to_list(N * 22 - 1).

make_width(N) -> integer_to_list(N * 80 - 14).

get_series_length(List) ->
    case hd(List) of
        {range, [L2]} -> length(L2);
        {range, L3}   -> length(L3);
        {array, [L4]} -> length(L4);
        {array, L5}   -> length(L5)
    end.

make_barsize(Size, Orientation, NoBars, NoGroups) ->
    Pixels = case Orientation of
                 horizontal -> list_to_integer(make_height(Size));
                 vertical   -> list_to_integer(make_width(Size))
             end,
    Padding = trunc(((NoGroups - 1) * ?SPKBARGRPSP)
        + (NoGroups * (NoBars/NoGroups - 1) * ?SPKBARSPACE)),
    Remainder = Pixels - Padding,
    Line = trunc(Remainder/NoBars),
    if
        Line < 2  -> {?barwidths, make_list(?SPKBARWIDTH, ?SPKBARSPACE,
                                            ?SPKBARGRPSP)};
        Line >= 2 -> {?barwidths, make_list(Line, ?SPKBARSPACE,
                                            ?SPKBARGRPSP)}
    end.

make_list(N, M, O) -> integer_to_list(N) ++ ","
                          ++ integer_to_list(M) ++ ","
                          ++ integer_to_list(O).
