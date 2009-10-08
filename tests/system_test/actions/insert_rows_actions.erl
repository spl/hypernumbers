-module(insert_rows_actions).
-compile(export_all).

-include_lib("hypernumbers/include/hypernumbers.hrl").
-include_lib("hypernumbers/include/spriki.hrl").

run() ->
    Url  = "http://127.0.0.1:9000/insert_rows/",
    Type = "application/json",
    Accept = [{"Accept", "application/json"}],
    Data = "{\"insert\":\"before\"}",
    http:request(post,{Url++"8:8", Accept, Type, Data}, [], []),
    http:request(post,{Url++"10:11", Accept, Type, Data}, [], []),
    ok.

