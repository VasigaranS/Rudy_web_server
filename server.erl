%% @author vasigarans
%% @doc @todo Add description to server.


-module(server).

%% ====================================================================
%% API functions
%% ====================================================================
-import(rudy,[init/1]).
-export([start/2,stop/0]).

%start(0,Port)->
%	ok;

start(Port,N)->

register(rudy,spawn(rudy2,init,[Port,N])).

stop()->
	exit(whereis(rudy),"time to die").



%% ====================================================================
%% Internal functions
%% ====================================================================


