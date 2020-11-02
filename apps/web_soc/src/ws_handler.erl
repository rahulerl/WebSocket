-module(ws_handler).
-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).

init(Req, Opts) ->
	{cowboy_websocket, Req, Opts}.

websocket_init(State) ->
	{[], State}.

websocket_handle({text, Data}, State) ->
    List_Data = binary_to_list(Data),
    Token = string:tokens(List_Data, " "),
    [Num1, Num2, Operation] = Token,
    case Operation of
        "ADD" -> {[{text, integer_to_list(list_to_integer(Num1) + list_to_integer(Num2))}], State};
        "MINUS" -> {[{text, integer_to_list(list_to_integer(Num1) - list_to_integer(Num2))}], State};
        "MUL" -> {[{text, integer_to_list(list_to_integer(Num1) * list_to_integer(Num2))}], State};
        "DIV" -> {[{text, integer_to_list(list_to_integer(Num1) / list_to_integer(Num2))}], State};
        _ ->  {[{text, <<"INVALID OPERATER! ">>}], State}
    end.

websocket_info(stop, State) ->
	{[], State}.