-module(challenge).
-export([test/0, extract_numbers/1]).

% If there is an even number of each number, true
% else, false

extract_numbers([]) -> [];
extract_numbers([{First, Second} | T]) -> [First] ++ [Second] ++ extract_numbers(T). 

add_matching_numbers(_Previous, []) -> [];
add_matching_numbers(Previous, [First | T]) when Previous =:= First-> [Previous + First | add_matching_numbers(First, T)];
add_matching_numbers(Previous, [First | T]) -> add_matching_numbers(First, T).


check_dominos(Dominos) -> 
    All_Numbers = extract_numbers(Dominos),
    Sorted_Numbers = lists:sort(All_Numbers),
    Accumulated_Numbers = add_matching_numbers(0, Sorted_Numbers) ,

    Filter_Lambda = fun(Num) -> Num rem 2 == true end,
    Result = lists:filter(Filter_Lambda, Accumulated_Numbers),
    
    case length(Accumulated_Numbers) =:= length(Result) of 
        true -> true;
        _Else -> false
    end.

test() ->
    Test_1 = [{1, 3}, {3, 2}, {2, 1}], % Already in order
    Test_2 = [{5, 2}, {5, 6}, {6, 3}, {1, 4}], % Shouldn't work
    Test_3 = [{2, 6}, {3, 5}, {1, 4}, {3, 4}, {6, 1}, {2, 5}], % Should work

    true = check_dominos(Test_1),
    false = check_dominos(Test_2),
    true = check_dominos(Test_3).