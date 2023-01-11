% CSE 382 Prove 01

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed in a public file sharing site.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in
% the reading. IMPORTANT: Comment out code that is not
% running properly.  The `test_ps#` functions should return `ok`.

% To run your Erlang code:
% 1) Make sure you terminal is in the same folder as your code
% 2) Run from the terminal: erl
% 3) Compile your code form the erlang prompt: c(module_name)
% Note that the module name is shown within the "-module" tag below
% Note that you must re-compile your code after changing your code
% 4) Run your test functions 'module_name:function_name().'  For example: prove01:test_ps1().

-module(prove01).
-export([test_ps1/0, test_ps2/0]).

% Problem 1.1
hello() -> io:format("Hello World!~n").

% Problem 1.2
add(A, B) -> A + B.

% Problem 1.3
multiply(A) -> A.
multiply(A, B) -> A * B.
multiply(A, B, C) -> A * B * C.

% Problem 1.4
water(Temperature) when Temperature =< 32 -> "Frozen";
water(Temperature) when Temperature > 32, Temperature < 212 -> "Liquid";
water(Temperature) when Temperature >= 212 -> "Gas".

% Problem 1.5
fib(N) when N =< 2 -> 1;
fib(N) -> fib(N - 1) + fib(N - 2).

% Problem 1.6
sum(N) when N == 0 -> 0;
sum(N) -> N + sum(N - 1).

% Problem 1.7
% Don't change this function.  Add your test code to the
% test_ps1 function below.
plot(Lambda) ->
    X = lists:seq(-3,3),
    Y = lists:map(Lambda, lists:seq(-3,3)),
    lists:zip(X,Y).

% Problem 2.1
stack_push(Stack, Number) -> [Number | Stack].

% Problem 2.2
stack_pop(Stack) -> [ _ | A] = Stack,
                    A.

% Problem 2.3
% Modify the code below to add your list comprehensions
quicksort([]) -> [];
quicksort([First|Rest]) ->
    quicksort([X || X <- Rest, X < First])
    ++ [First] ++
    quicksort([X || X <- Rest, X > First]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    hello(),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    5 = add(2,3),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    4 = multiply(4),
    12 = multiply(4,3),
    60 = multiply(4,3,5),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    "Frozen" = water(31),
    "Liquid" = water(33),
    "Gas" = water(212),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.5
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    1 = fib(1),
    1 = fib(2),
    2 = fib(3),
    3 = fib(4),
    5 = fib(5),
    8 = fib(6),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.6
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    0 = sum(0),
    55 = sum(10),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.7
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
	Square = fun(N) -> N * N end,
	Subtract = fun(N) -> N - 1 end,
	DivThree = fun(N) -> math:floor(N/3) end,

    % Replace 'put_function_here' with your lambda function
    [{-3,9},{-2,4},{-1,1},{0,0},{1,1},{2,4},{3,9}] = plot(Square),
    [{-3,-4},{-2,-3},{-1,-2},{0,-1},{1,0},{2,1},{3,2}] = plot(Subtract),
    [{-3,3},{-2,2},{-1,1},{0,0},{1,1},{2,2},{3,3}] = plot(fun(N) -> abs(N) end),
    [{-3,-1.0},{-2,-1.0},{-1,-1.0},{0,0.0},{1,0.0},{2,0.0},{3,1.0}] = plot(DivThree),

    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    S1 = stack_push([],10),
    S2 = stack_push(S1,20),
    S3 = stack_push(S2,30),
    [30,20,10] = S3,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [30|_] = S3,
    S4 = stack_pop(S3),
    [20|_] = S4,
    S5 = stack_push(S4,40),
    [40|_] = S5,
    S6 = stack_pop(S5),
    [40|_] = S5,
    S7 = stack_pop(S6),
    [10] = S7,
    S8 = stack_pop(S7),
    [] = S8,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.5
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    [] = quicksort([]),
    [1,2,3,4,5] = quicksort([3,1,5,4,2]),

    ok.

