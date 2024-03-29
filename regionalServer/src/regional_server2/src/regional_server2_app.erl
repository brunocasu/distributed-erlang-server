%%%-------------------------------------------------------------------
%%% @author brunocasu

%% @private
-module(regional_server2_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).
-export([start_task/2]).
-export([rpc_task/2]).

%% -import(listener_task, [start_monitoring_listener/1]).

%% API.
%% This function is called by cowboy Makefile
start(_Type, _Args) ->
	%% start_task(avg, average_calc_task),
	start_task(log, data_log_task),
	%% start_task(event, event_handler_task),
	%% start_monitoring_listener(listener_task), %% Removed Communication between regional servers
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/regional_server", toppage_h, []}
		]}
	]),																	%% DEFAULT IP AND PORT
	{ok, _} = cowboy:start_clear(http, [{ip, {10,2,1,34}},{port, 8080}], #{ %% ranch.erl line 340
		env => #{dispatch => Dispatch}
	}),
	regional_server2_sup:start_link().

stop(_State) ->
	ok = cowboy:stop_listener(http).

%% Spawn the process for the tasks in the server
start_task(LoopID, Module) ->
	register(LoopID, spawn(fun()->loop_task(LoopID, Module, Module:init()) end)).

rpc_task(LoopID, Req) ->
	LoopID ! {self(), Req},
	receive {LoopID, Response} -> Response
	end.

loop_task(LoopID, Module, State) ->
	receive
		{From, Req} ->
			{Response, NewState} = Module:handle(Req, State),
			From ! {LoopID, Response},
			loop_task(LoopID, Module, NewState)
	end.
