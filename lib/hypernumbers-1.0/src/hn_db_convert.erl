%%% @author    Gordon Guthrie
%%% @copyright (C) Ericsson
%%% @doc       Functions for manipulating mnesia backups
%%%
%%%            Partly copied from the Mnesia User Guide published
%%%            with Erlang docs
%%% @end
%%% Created :  7 Jun 2012 by gordon@vixo.com

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

-module(hn_db_convert).

-export([
         change_node_name/4,
         restore_site/3
        ]).

restore_site(Backup, FromSite, ToSite) ->

    % first work out what tables are being retored
    Tables = [X || {X, _, _, _, _, _} <- hn_setup:tables()],
    Tables2 = make_tables(Tables, FromSite, ToSite, []),

    % then clear down the target
    [{atomic, ok} = mnesia:clear_table(Target) || {_, Target} <- Tables2],

    % now traverse the backup
    % this fun is for the side effects so it returns a empty list for all
    % records and produces no output
    WriteOut =
        fun
            (X, Acc) ->
                Tab = element(1, X),
                case lists:keyfind(Tab, 1, Tables2) of
                    false ->
                        ok;
                    {Tab, NewTab} ->
                        % we don't write records with the table name
                        % in the first field - we use a generic record name
                        Rec = get_rec(NewTab),
                        NewX = setelement(1, X, Rec),
                        Fun = fun() ->
                                      ok = mnesia:write(NewTab, NewX, write)
                              end,
                        mnesia:transaction(Fun)
                end,
                {[], Acc}
        end,
    mnesia:traverse_backup(Backup, mnesia_backup, dummy, read_only, WriteOut, restored).

change_node_name(From, To, Source, Target) ->
    Switch =
        fun
            (Node) when Node == From ->
                %io:format("     - Replacing nodename: ~p with: ~p~n",
                %                                             [From, To]),
                To;
            (Node) when Node == To -> throw({error, already_exists});
            (Node) ->
                %io:format("     - Node: ~p will not be modified "
                %          ++ "(it is not ~p)~n", [Node, From]),
                Node
        end,
    Convert =
        fun
            ({schema, db_nodes, Nodes}, Acc) ->
                io:format(" +++ db_nodes ~p~n", [Nodes]),
                {[{schema, db_nodes, lists:map(Switch, Nodes)}], Acc};
            ({schema, version, Version}, Acc) ->
                io:format(" +++ version: ~p~n", [Version]),
                {[{schema, version, Version}], Acc};
            ({schema, cookie, Cookie}, Acc) ->
                io:format(" +++ cookie: ~p~n", [Cookie]),
                {[{schema, cookie, Cookie}], Acc};
            ({schema, Tab, CreateList}, Acc) ->
                io:format("~n * Checking table: ~p~n", [Tab]),
                % io:format("  . Initial content: ~p~n", [CreateList]),
                OptSwitch =
                    fun
                        ({Key, Val}) when Key == ram_copies orelse
                                          Key == disc_copies orelse
                                          Key == disc_only_copies ->
                            %io:format("   + Checking key: ~p~n", [Key]),
                            {Key, lists:map(Switch, Val)};
                        ({cookie, {Ck, Node}}) ->
                            %io:format("   + Checking key: ~p~n", [cookie]),
                            {cookie, {Ck, Switch(Node)}};
                        ({version, {N, {Node, Vr}}}) ->
                            %io:format("   + Checking key: ~p~n", [version]),
                            {version, {N, {Switch(Node), Vr}}};
                        ({Key, Val}) ->
                            {Key, Val}
                    end,
                Res = {[{schema, Tab, lists:map(OptSwitch, CreateList)}], Acc},
                % io:format("  . Resulting content: ~p~n", [Res]),
                Res;
            (Other, Acc) ->
                % io:format(" --- ~p~n", [Other]),
                {[Other], Acc}
        end,
    mnesia:traverse_backup(Source, Target, Convert, switched).

make_tables([], _From, _To, Acc) ->
    lists:reverse(Acc);
make_tables([H | T], From, To, Acc) ->
    NewAcc = {new_db_wu:trans(From, H), new_db_wu:trans(To, H)},
    make_tables(T, From, To, [NewAcc | Acc]).

get_rec(Table) -> T2 = atom_to_list(Table),
                  [_Site, _Port, T3] = string:tokens(T2, "&"),
                  list_to_existing_atom(T3).
