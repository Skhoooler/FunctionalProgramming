% CSE 382 Prove 05

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in 
% the reading. IMPORTANT: Comment out code that is not 
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove05).
-export([test_ps1/0, test_ps2/0, test_ps3/0, test_curry/0]).

% Problem 1.2
multiply_list(Value) -> fun(List) -> lists:map(fun(Item) -> Value * Item end, List) end.

greater_list(N) -> fun(List) -> lists:filter(fun(Item) -> Item > N end, List) end.

% Problem 1.3
% Provide specification and definition (as comments) along with the code
% spec multiple_of_list :: real -> (lambda :: [real] -> [real]).
% spec lambda_filter :: real -> real.
% def multiple_of_list :: Value -> (lambda :: List -> (filter(lambda_filter :: Item -> Item rem Value == 0 end , List)).
multiples_of_list(Value) -> fun(List) -> lists:filter(fun(Item) -> Item rem Value == 0 end, List) end.

% Problem 2.1

% Implemented the curry function above test_ps2()


% Problem 3.1
map_filter_fold2(Value) ->
    List = lists:seq(1, Value),
    fun (MapL) -> 
        MapList = lists:map(MapL, List),
        fun (FilterL) ->
            FilterList = lists:filter(FilterL, MapList),
            fun (FoldInit, FoldL) ->
                FoldResult = lists:foldl(FoldL, FoldInit, FilterList),
                FoldResult
            end
        end
    end.

% Problem 3.2
process_dataset2() -> ok.% Didn't know how to do this one


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The following functions are fully implemented for you to use in the problem sets.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Display a formatted alert message with three parts.
alert(Location, Category, Message) -> io:format("~p for ~p : ~p~n", [Category, Location, Message]).

% Return True if the Value is within range
range_check(Low, High, Value) -> (Value >= Low) and (Value =< High).

% Calculate the average of list of numbers.
list_average(List) -> 
    lists:foldl(fun (Item, Total) -> Item + Total end, 0, List) / length(List).

% Create a one arity function that counts all items in a list that have 
% the specified Term in the string.
list_text_count(Term) ->
    fun(List) -> lists:foldl(fun (Item, Total) -> 
        case string:find(Item,Term) of
            nomatch -> Total;
            _Else -> Total + 1
        end
    end, 0, List) end.

% Open the file, skip the header row, and begin reading
% each row one at a time to produce a list of lists.
read_csv_file(Filename) -> 
    {ok, FileHandle} = file:open(Filename, read),
    file:read_line(FileHandle), % Skip header row
    read_csv_file(FileHandle, []).

% Read each line of the CSV file and split the line by the comma
% delimeter.  Each line will be represented by a list and the file
% will be represented as a list of lists.
read_csv_file(FileHandle, Lines) ->
    Result = file:read_line(FileHandle),
    case Result of
        {ok, Line} -> read_csv_file(FileHandle, [string:split(Line,",",all)|Lines]);
        eof -> Lines
    end.

% Extract the specified column as text
extract_column_array(text, Array, ColumnId) ->
    ExtractColumn = fun(Row) -> lists:nth(ColumnId, Row) end,
    lists:map(ExtractColumn, Array);

% Extract the specified column as integers
extract_column_array(int, Array, ColumnId) ->
    ExtractColumn = fun(Row) -> 
        {Result, _} = string:to_integer(lists:nth(ColumnId, Row)),
        Result
     end,
    lists:map(ExtractColumn, Array);

% Extract the specified column as floats
extract_column_array(float, Array, ColumnId) ->
    ExtractColumn = fun(Row) -> 
        {Result, _} = string:to_float(lists:nth(ColumnId, Row)),
        Result
     end,
    lists:map(ExtractColumn, Array).

% Extract a column (with the specified type of text, int, or float) 
% from the file and perfom the specified function on the data.
process_dataset(Filename, ColumnId, ColumnType, CalcFunction) ->
    Data = read_csv_file(Filename),
    DataColumn = extract_column_array(ColumnType, Data, ColumnId),
    Result = CalcFunction(DataColumn),
    Result.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Chain the map, filter, and foldl functions in a single line as described in the problem
    Values_1_1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    Map_lambda = fun(X) -> X * 3 end,
    Filter_lambda = fun(X) -> X rem 2 == 0 end,
    Foldl_lambda = fun(X, Acc) -> X * Acc end,
    933120 = lists:foldl(Foldl_lambda, 1, lists:filter(Filter_lambda, lists:map(Map_lambda, Values_1_1))),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    L = [2, 4, 6, 8, 10, 12],
    [12,16,20,24] = (greater_list(10))((multiply_list(2))(L)),
    [24] = (multiply_list(2))((greater_list(10))(L)),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    Multiples7 = multiples_of_list(7),
    [7,14,21,28] = Multiples7(lists:seq(1,30)),
    [42,49] = Multiples7(lists:seq(40,50)),


    ok.

curry(Function) ->
    {_, Arity} = erlang:fun_info(Function, arity),
    curry_helper(Function, Arity, []).

curry_helper(Function, 0, Parameters) -> apply(Function, lists:reverse(Parameters));
curry_helper(Function, Iteration, Parameters) ->
    fun(Parameter) -> curry_helper(Function, Iteration - 1, [Parameter] ++ Parameters) end.

test_curry() ->
    Create_car = fun(Color, Year, Make, Model, Trim) -> Year ++ " " ++ Color ++ " " ++ Make ++ " " ++ Model ++ " " ++ Trim end,
    
    Color_ingredient = curry(Create_car),
    Year_ingredient = Color_ingredient("Blue"),
    Make_ingredient = Year_ingredient("2001"),
    Model_ingredient = Make_ingredient("Volkswagen"),
    Trim_ingredient = Model_ingredient("Bug"),
    
    Curried_car = Trim_ingredient("Basic"),
    Curried_car.
    

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    alert("Madison County","Winter Storm Warning","Expect 8-12 inches of Snow"),
    %((((curry3(fun alert/3))("Madison County")))("Winter Storm Warning"))("Expect 8-12 inches of Snow"),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to curry the first parameter and test the intermediate function twice


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to curry the first and second parameter and test the intermediate function twice


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to curry the range_check and use it with a filter as described in the instructions
    %Range_Check_10_to_20 = put_your_code_here_using_curry3,
    %Full_List_of_Numbers = [3, 15, 23, 19, 6, 16, 13, -5, -20, 30],
    %[15,19,16,13] = put_your_code_here_using_filter_and_the_two_variables_above,

    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Useful lambdas for the map_filter_fold2 to use.
    Square = fun(X) -> X * X end,
    Triple = fun(X) -> 3 * X end,
    Odd = fun(X) -> X rem 2 == 1 end,
    Even = fun(X) -> X rem 2 == 0 end,
    Sum = fun(X,Y) -> X+Y end,
    Product = fun(X,Y) -> X*Y end,

    % Example not using any partial applications    
    35 = (((map_filter_fold2(6))(Square))(Odd))(0, Sum),
    
    % Example creating and using partial application
    First10Squares = (map_filter_fold2(10))(Square),
    165 = (First10Squares(Odd))(0, Sum),
    14745600 = (First10Squares(Even))(1,Product),

    % Write and test a partial application function to obtain the first 20 triples that are even and
	% test per the instructions.
    First20TriplesOnlyEven = (((map_filter_fold2(20))(Triple))(Even)),
    330 = First20TriplesOnlyEven(0, Sum),
    219419659468800 = First20TriplesOnlyEven(1, Product),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Examples not using any partial applications  
     Avg_Temp = process_dataset("weather.csv", 6, int, fun list_average/1),
     io:format("Avg Temp = ~p~n",[Avg_Temp]), % Answer = 24.8472
     Count_Snow = process_dataset("weather.csv", 5, text, list_text_count("Snow")),
     io:format("Count Snow = ~p~n",[Count_Snow]), % Answer = 38

    % Test partial application to read entire dataset only once 
     Weather = process_dataset2("weather.csv"),
     Avg_WindChill = (Weather(8, int))(fun list_average/1), 
     io:format("Avg WindChill ~p~n",[Avg_WindChill]), % Answer = 12.0
     Avg_Pressure = (Weather(9,float))(fun list_average/1),
     io:format("Avg Pressure ~p~n",[Avg_Pressure]), % Answer = 29.735

    % Test partial application to read the entire dataset and extract the 
    % Observation column (column 5; text) only once 
     Weather_Obs = Weather(5, text),
     Count_Windy = Weather_Obs(list_text_count("Windy")), % Answer = 19
     io:format("Count Windy = ~p~n",[Count_Windy]),
     Count_Mist = Weather_Obs(list_text_count("Mist")), % Answer = 7
     io:format("Count Mist = ~p~n",[Count_Mist]),
    
    
    ok.