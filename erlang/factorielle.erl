%% @author defxwyz
%% @doc exemple de code erlang
-module(factorielle).

-export([calcul/1]).

%% @doc calcul factorielle 
calcul(1) -> 1;
calcul(N) when N > 1 -> 
  calcul(N-1)*N.

