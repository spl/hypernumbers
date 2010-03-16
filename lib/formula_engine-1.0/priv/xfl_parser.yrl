%%% -*- erlang -*-
%%% @doc Parser for the formula language.
%%% @author Hasan Veldstra <hasan@hypernumbers.com>

%%% TODO: use list_to_existing_atom (& catch errors).
%%% TODO: handle invalid arrays propely.
%%% TODO: clean error reporting

Nonterminals

Formula E Uminus Uplus List Funcall Args
ArrayLiteral ArrayRow ArrayRows Array
.

Terminals

cellref rangeref namedexpr 
name
'=' '<>' '>' '<' '>=' '<='
'+' '-' '*' '/' '^'
'&' '%' '^^'
int float bool str
errval
'(' ')' ',' '{' '}' ';'
.

Rootsymbol Formula.
Endsymbol  '$end'.

Unary    50  Uplus.
Left     100 '=' '<>' '>' '<' '>=' '<='.
Left     200 '&'.
Left     300 '+' '-'.
Left     400 '*' '/'.
Left     500 '^'.
Left     600 '%'.
Unary    700 Uminus.
Left     900 '^^'.

Formula -> E : postproc('$1').

E -> E '='  E : op('$1', '$2', '$3').
E -> E '<>' E : op('$1', '$2', '$3').
E -> E '>'  E : op('$1', '$2', '$3').
E -> E '<'  E : op('$1', '$2', '$3').
E -> E '>=' E : op('$1', '$2', '$3').
E -> E '<=' E : op('$1', '$2', '$3').
E -> E '&' E  : op('$1', {concatenate,1}, '$3').    
E -> E '+' E  : op('$1', '$2',  '$3').
E -> E '-' E  : op('$1', '$2',  '$3').
E -> E '*' E  : op('$1', '$2',  '$3').
E -> E '/' E  : op('$1', '$2', '$3').
E -> E '^' E  : op('$1', {power,1}, '$3').
E -> E '%'    : ['/', '$1', 100].

E      -> Uminus : '$1'.
Uminus -> '-' E  : [negate, '$2'].
E      -> Uplus  : '$1'.
Uplus  -> '+' E  : '$2'.

E -> E '^^' E : ['^^', '$1', '$3'].
E -> rangeref rangeref  : ['^^', lit('$1'), lit('$2')].
%%% parenthesized expressions.

E -> '(' E ')' : '$2'.    

%%% special cases for slash ambiguity

E -> E namedexpr Args : special_div1('$1', lit('$2'), '$3').
E -> E cellref        : special_div2('$1', lit('$2')).

%%% TRUE() and FALSE() functions:

E -> bool '(' ')' : lit('$1').

%%% funcalls
E -> Funcall : '$1'.

%%% ref lists
E -> List : '$1'.
List -> '(' Args ')' : arglist('$2').

%%% constants / literals

E -> int       : lit('$1').
E -> float     : lit('$1').
E -> bool      : lit('$1').
E -> str       : lit('$1').
E -> errval    : lit('$1').
E -> Array     : '$1'.
E -> cellref   : lit('$1').
E -> name      : lit('$1').
E -> namedexpr : lit('$1').
E -> rangeref  : lit('$1').

%%% funcall productions

Funcall -> name '(' ')'      : [func_name('$1')].
Funcall -> name '(' Args ')' : func('$1', '$3').
%% Special case for functions with names like ATAN2
Funcall -> cellref '(' ')'       : [func_name('$1')].
Funcall -> cellref '(' Args ')'  : func('$1', '$3').

%% eugh, wrong way to do undefined args
Args -> E                    : ['$1'].
Args -> E ',' ',' Args       : ['$1'] ++ [undef] ++ '$4'.
Args -> E ',' ',' ',' Args   : ['$1'] ++ [undef, undef] ++ '$5'.
Args -> E ',' Args           : ['$1'] ++ '$3'.


%%% arrays ( = lists of rows, which are lists of values of allowed types)
Array -> '{' ArrayRows '}' : to_native_list('$2').

ArrayRows -> ArrayRow : [{row, '$1'}].
ArrayRows -> ArrayRow ';' ArrayRows : [{row, '$1'}] ++ '$3'.

ArrayRow -> ArrayLiteral : ['$1'].
ArrayRow -> ArrayLiteral ',' ArrayRow : ['$1'] ++ '$3'.

ArrayLiteral -> int       : lit('$1').
ArrayLiteral -> float     : lit('$1').
ArrayLiteral -> '-' int   : neg(lit('$2')).
ArrayLiteral -> '-' float : neg(lit('$2')).
ArrayLiteral -> '+' int   : lit('$2').


ArrayLiteral -> '+' float : lit('$2').
ArrayLiteral -> bool      : lit('$1').
ArrayLiteral -> str       : lit('$1').
ArrayLiteral -> errval    : lit('$1').    

Erlang code.

-include("handy_macros.hrl").
-include("muin_records.hrl").
-include("typechecks.hrl").

neg(X) when is_integer(X) -> -X;
neg({float, F, S}) -> {float, -F, S}.

%% Make a function name for the AST from lexer tokens:
func_name({name, _, Name}) ->
    list_to_atom(string:to_lower(Name));
func_name({cellref, _, #cellref{text = Text}}) ->
    list_to_atom(string:to_lower(Text)). % ATAN2 &c.

%%% stuff from lexer -> stuff for AST.

%%% Literals:
lit({name, _, Name}) when is_record(Name, namedexpr) -> Name;
lit({name, _, Name}) -> #namedexpr{path = "./", text = Name};
lit({cellref, _, Cellref}) when is_record(Cellref, cellref) -> Cellref;
lit({rangeref, _, Rangeref}) when is_record(Rangeref, rangeref) -> Rangeref;
lit({errval, _, Errval}) -> {errval, Errval};
%% OrigStr is used in normalization and then thrown away -- only float values make it
%% to the final AST.
lit({float, _, {F, OrigStr}}) -> {float, F, OrigStr};
lit({_Type, _, Data}) -> Data.

%% operator function calls
op(Arg1, {Op,_}, Arg2) -> [Op, Arg1, Arg2]; % used by production rule actions.
op(Arg1, Op, Arg2)     -> [Op, Arg1, Arg2]. % used by helpers.

%% token + list of args -> function call for AST.
func(Tuple, Args) -> [func_name(Tuple)] ++ Args.

arglist(Args) -> {list, Args}.

%% Convert representation of array in AST into Erlang's native list-of-lists.
to_native_list(Ary) ->
    RowLen = length(element(2, hd(Ary))),
    Rectp = all(fun({row, Vals}) -> length(Vals) == RowLen end, Ary),
    ?IF(not(Rectp), throw(invalid_array)),

    {array, tl(foldl(fun(Row, Acc) ->
                             {row, Elts} = Row,
                             Acc ++ [Elts]
                     end,
                     [[]],
                     Ary))}.

%% special case #1 for division:
%%
%% #namedexpr where path = "/" is a function call in divisor if:
%%   1. preceded by an expression
%%   2. followed by function args
%%
special_div1(Expr, #namedexpr{path="/", text=T}, Args0) ->
    Args = case Args0 of 
               [{list, As}] -> As;
               _ -> Args0
           end,
    ['/', Expr, [list_to_atom(string:to_lower(T))] ++ Args].

%% special case #2 for division:
%%
%% Expression followed by a #cellref is a division if:
%%   1. path of #cellref is "/"
%%
special_div2(E, CR2) when ?is_cellref(CR2) ->
    case CR2#cellref.path == "/" of
        true  ->
            Divisor = #cellref{col  = CR2#cellref.col,
                               row  = CR2#cellref.row,
                               path = "./",
                               text = string:substr(CR2#cellref.text, 2)},
            ['/', E, Divisor];
        false ->
            throw(invalid_formula)
    end.

postproc(Ast) ->
    replace_float(Ast).

%% Replace {Float, OriginalString} tuples with Floats in the AST.
replace_float({float, F, Str}) when is_float(F), ?is_string(Str) ->
    F;
replace_float(X) when is_list(X) ->
    [ replace_float(Y) || Y<-X ];
replace_float({array, Values}) ->
    Vals = [ [ replace_float(Y) || Y <- X ] || X <- Values ],
    {array, Vals};
replace_float(Else) ->
    Else.

%%% TESTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-ifdef(debug).
-include_lib("eunit/include/eunit.hrl").
-include("xfl_parser_test.erl").
-endif.
