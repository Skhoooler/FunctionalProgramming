-module(challenge).
-export([lazy_main/0]).

fibonaccify() -> 0.
fibonaccify(Initial) -> fun(Next) -> Initial + (fibonaccify(Next))() end.

lazy_main() ->
    F1 = fibonaccify(1),
    F2 = F1(2),
    5 = F2().
