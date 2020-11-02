%%%-------------------------------------------------------------------
%% @doc web_soc public API
%% @end
%%%-------------------------------------------------------------------

-module(web_soc_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
		{'_', [
			{"/websocket", ws_handler, []}
		]}
	]),
	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}),
    web_soc_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
