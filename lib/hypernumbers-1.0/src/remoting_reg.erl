%%%-----------------------------------------------------------------------------
%%% File        remoting_reg.erl
%%% @author     Gordon Guthrie 
%%% @doc        remoting_reg handles registration from Flex remoting
%%% @copyright  Hypernumbers Ltd
%%%
%%% Created     : 6 Feb 2007 by gordonguthrie@backawinner.gg
%%% @private
%%%-----------------------------------------------------------------------------
-module(remoting_reg).

-behaviour(gen_server).

-define(SERVER, ?MODULE).
-include("spriki.hrl").

%% gen_server callbacks
-export([start_link/0, init/1, handle_call/3, handle_cast/2, 
    handle_info/2, terminate/2, code_change/3]).

%%==============================================================================
%% gen_server callbacks
%%==============================================================================
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
    {ok, []}.

%% Register a new Range, From will now receive updates
%% when a number in Page -> Range changes
handle_call({register,Page},{Pid,_},State) ->
    #ref{site=Site,path=Path} = Page,
    NewState = lists:append(State,[{Site,Path,Pid}]),
    {reply, {msg,"range registered"},NewState};

%% Unregisters a range, From will no longer
%% Receive updates
handle_call({unregister},From,State) ->
    N = lists:filter(
        fun(X) ->
            case X of 
            {_,_,_,From} -> false;
            _ -> true
            end 
        end,State),
    {reply,{msg,"range unregistered"},N};

%% Change Message, find everyone listening to 
%% that page then send them a change message
%% @TODO this is a bug! - all if there is the same page on multiple
%% sites on one server they all get the notification!
handle_call({change, _Site, Path, Msg}, _From, State) ->
    F = fun(Z) ->
                case Z of                    
                    %% @TODO : Ignoring site for now to work
                    %% behind reverse proxy
                    {_Site, Path, Pid} -> 
                        Pid ! {msg, Msg};
                    _ -> ok
                end
        end,
    lists:foreach(F,State),
    {reply,ok,State};

%% Invalid Message
handle_call(_Request,_From,State) ->
    {reply,invalid_message, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.
    
handle_info(_Info, State) ->    {noreply, State}.
terminate(_Reason, _State) ->    ok.
code_change(_Old, State, _E) -> {ok, State}.
