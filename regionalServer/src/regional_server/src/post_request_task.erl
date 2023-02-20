%%%-------------------------------------------------------------------
%%% @author brunocasu
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. Feb 2023 04:57
%%%-------------------------------------------------------------------
-module(post_request_task).
-author("brunocasu").

%% API
-export([init/0, handle/2, post_msg/3]).

-import(regional_server_app, [rpc_task/2]).

init() -> [].

post_msg(_ServerIDBin, _DataValBin, _TimeBin) -> rpc_task(post_req, {}).

handle(msg, {}) -> msg.

%io:fwrite("~p~n", ["Sensor Threshold Crossed - Sending Msg to http://localhost:8080"]),
  %Url = "http://localhost:8080",
  %ContentType = "text/plain; charset=utf-8",
  %Msg1 = <<"msg_type=th_crossed&sensor_id=">>,
  %Msg2 = <<"&sensor_data=">>,
  %Msg3 = <<"&time=">>,
  %Body = <<Msg1/binary, SensorIDBin/binary, Msg2/binary, AvgBin/binary, Msg3/binary, TimeBin/binary>>,
  %io:fwrite("~p~n", [binary_to_list(Body)]).
%% httpc:request(post, {Url, [], ContentType, Body}, [], []).
%(Method, Request, HttpOptions, Options)
%Request: {uri_string:uri_string(),[HttpHeader],ContentType :: uri_string:uri_string(),HttpBody},