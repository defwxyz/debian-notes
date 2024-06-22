## Exemples

Le calcul de factorielle d'un entier naturel programmé en erlang dans le fichier factorielle.erl suivant:

```
-module(factorielle).

-export([calcul/1]).

calcul(1) -> 1;
calcul(N) when N > 1 -> 
  calcul(N-1)*N.
```

On lance l'environnement erlang: 

```
$ erl
Erlang/OTP 24 [erts-12.2.1] [source] [64-bit] [smp:2:2] [ds:2:2:10] [async-threads:1] [jit]

Eshell V12.2.1  (abort with ^G)
1> c(factorielle).
{ok,factorielle}
2> factorielle:calcul(12).
479001600
3> 
```

Avec plus de tag pour la documentation, comme %% @doc

Et en lançant: 

```
edoc:files(["factorielle.erl"]).
```

On obtient un fichier html, comme [celui-là](factorielle.html).