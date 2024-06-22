-module(factorial).

-export([run/1]).

run(1) -> 1;
run(N) when N > 1 -> 
  run(N-1)*N.

