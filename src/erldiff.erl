-module(erldiff).
-export([diff/2]).

print(Level, Value) ->
    print(Level, Value, Value).

print(info, Value1, Value1) ->
    io:format("~s,", [binary_to_list(iolist_to_binary(color:green(lists:flatten(io_lib:format("~p", [Value1])))))]);
print(error, Value1, Value2) ->
    A = io_lib:format("~p", [Value1]),
    B = io_lib:format("~p", [Value2]),
    io:format(user, "~s/~s,", [binary_to_list(iolist_to_binary(color:red(lists:flatten(A)))), binary_to_list(iolist_to_binary(color:red(lists:flatten(B))))]).


diff(Value1, Value2) when is_tuple(Value1),
                          is_tuple(Value2) ->
    print(info, ${),
    diff(tuple_to_list(Value1), tuple_to_list(Value2)),
    print(info, $});
diff(Value1, Value2) when is_tuple(Value1);
                          is_tuple(Value2) ->
    print(info, ${),
    print(error, Value1, Value2),
    print(info, $});
diff([], []) ->
    ok;
diff([Hd|Tl], [Hd|Tl2]) ->
    print(info, Hd, Hd),
    diff(Tl, Tl2);
diff([L1|Tl1], [L2|Tl2]) when is_list(L1), is_list(L2) ->
    print(info, $[),
    diff(L1, L2),
    print(info, $]),
    diff(Tl1, Tl2);
diff([Hd1|Tl], [Hd2|Tl2]) when Hd1 /= Hd2, not is_tuple(Hd1), not is_tuple(Hd2) ->
    print(error, Hd1, Hd2),
    diff(Tl, Tl2);
diff([T1|Tl1], [T2|Tl2]) when is_tuple(T1), is_tuple(T2) ->
    diff(tuple_to_list(T1), tuple_to_list(T2)),
    print(info, ${),
    diff(Tl1, Tl2),
    print(info, $});
diff(V1, V2) ->
    print(error, V1, V2).







