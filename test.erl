%% @author vasigarans
%% @doc @todo Add description to test.


-module(test).

%% ====================================================================
%% API functions
%% ====================================================================
-export([bench/2,bench1/2]).



bench(Host,Port)->
	Start=now(),
	run(100,Host,Port),
	Finish=now(),
	%io:fwrite("~w~n",[Start]),
	%io:fwrite("~w~n",[Finish]),
	timer:now_diff(Finish,Start).


bench1(Host,Port)->
	Start=erlang:system_time(micro_seconds),
	run1(1,Start,Host,Port).
	

	
run1(N,Start,Host,Port)->
	Cur=erlang:system_time(micro_seconds),
	Pos=Cur-Start,
	if
		 Pos>100000->
			%io:fwrite("~w~n",[N]),
			io:fwrite("~w~n",[N]),
			ok;
		 N==2600->
			% io:fwrite("~w~n",[Pos]),
	         
			 ok;
		true->
			request(Host,Port),
			run1(N+1,Start,Host,Port)
	end.	

run(N,Host,Port)->
	if
		N==0->
			ok;
		true->
			request(Host,Port),
			run(N-1,Host,Port)
	end.



request(Host,Port)->
	Opt=[list,{active,false},{reuseaddr,true}],
	{ok,Server}=gen_tcp:connect(Host,Port,Opt),
	gen_tcp:send(Server,http:get("foo")),
	Recv=gen_tcp:recv(Server,0),
	case Recv of
		{ok,_}->
			ok;
		{error,Error}->
			io:format("test: error: ~w~n",[Error])
	end,
	gen_tcp:close(Server).






%% ====================================================================
%% Internal functions
%% ====================================================================


