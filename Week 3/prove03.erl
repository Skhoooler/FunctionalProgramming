% CSE 382 Prove 03

% (c) BYU-Idaho - It is an honor code violation to post this
% file completed or uncompleted in a public file sharing site.

% Instructions: Use this template file for this prove assignment.
% The details of what to do for each problem are found in 
% the reading. IMPORTANT: Comment out code that is not 
% running properly.  The `test_ps#` functions should return `ok`.
% When writing tests use the `expected_result` = `actual result` format.

-module(prove03).
-export([test_ps1/0, test_ps2/0, test_ps3/0]).

% Problem 1.1
map(_Lambda, []) -> [];
map(Lambda, [First | Rest]) -> [Lambda(First) | map(Lambda, Rest)].

% Problem 1.3
map_2(Lambda, Data) -> [Lambda(X) || X <- Data].

% Problem 2.1
filter(_Lambda, []) -> [];
filter(Lambda, [First | Rest]) -> 
    case Lambda(First) of
        true -> [First | filter(Lambda, Rest)];
        _    -> filter(Lambda, Rest)
    end.

% Problem 2.2
filter_2(Lambda, Data) -> [X || X <- Data, Lambda(X) == true].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Test Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test code for problem set 1
test_ps1() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code below to convert a list of measurements
    Data_In = [1, 2, 3, 4, 5],
    In_to_Cm_Lambda = fun(Length) -> Length * 2.54 end,
    Data_Cm = map(In_to_Cm_Lambda, Data_In),
    [2.54, 5.08, 7.62, 10.16, 12.7] = Data_Cm,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code below to implement a simple cipher using map
	Password = "PASSWORD",
    Cipher_Lambda = fun(Letter) -> Letter + 1 end,
    Encrypted = map(Cipher_Lambda, Password),
    "QBTTXPSE" = Encrypted,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 1.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code below to implement a simple cipher using map2
    Password_2 = "TEST",
    Encrypted_2 = map_2(Cipher_Lambda, Password_2),
    "UFTU" = Encrypted_2,

    ok.

% Test code for problem set 2
test_ps2() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code below to get the even numbers from a list using filter
    Numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    Even_Lambda = fun(Integer) -> Integer rem 2 == 0 end,
    Even_Numbers = filter(Even_Lambda, Numbers),
    [2, 4, 6, 8, 10] = Even_Numbers,

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code below to get the even numbers from a list using filter2
    Even_Numbers_2 = filter_2(Even_Lambda, Numbers),
    [2, 4, 6, 8, 10] = Even_Numbers_2,


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.3
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Modify the test code to get liquid temperatures from a list using filter
    Is_Water_Lambda = fun(Temp) ->
        case Temp of 
            Temp when Temp > 0, Temp < 100  -> true;
            _ -> false end 
        end,
	[20, 80] = filter(Is_Water_Lambda, [-10, 20, -15, 110, 80]),

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 2.4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    Messages = ["INFO: Reading the data",
        "INFO: Validating the data",
        "WARNING: Missing meta data",
        "ERROR: Column 2 Row 5 expected number",
        "WARNING: Row 12 unexpected line terminator",
        "INFO: Validation complete",
        "INFO: Processing data",
        "ERROR: Command 7 unknown",
        "INFO: Processing complete"],

    % Write test code using the Messages variable above to get only
    % ERROR messages using filter.
    Error_Lambda = fun(String) -> string:prefix("E", String) /= "nomatch" end,

    Messages = [
        "INFO: Reading the data",
        "INFO: Validating the data",
        "WARNING: Missing meta data",
        "WARNING: Row 12 unexpected line terminator",
        "INFO: Validation complete",
        "INFO: Processing data",
        "INFO: Processing complete"] = filter_2(Error_Lambda, Messages),
    
    ok.

% Test code for problem set 3
test_ps3() ->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to demonstrate the identity for filter
    Identity_List = [1, 2, 3 , 4 ,5],
    Identity_Lambda = fun(Num) -> Num =:= Num end,

    Identity_List = filter(Identity_Lambda, Identity_List),


    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Test Problem 3.2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Write test code to demonstrate the distributive property for filter



    ok.