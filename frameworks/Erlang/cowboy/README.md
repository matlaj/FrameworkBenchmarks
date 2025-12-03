# Cowboy Benchmarking Test

### Test Type Implementation Source Code

* [JSON](src/hello_world_handler_json.erl)
* [PLAINTEXT](src/hello_world_handler_plaintext.erl)
* [DB](src/hello_world_handler_db.erl)
* [QUERY](src/hello_world_handler_query.erl)
* CACHED QUERY (not implemented)
* UPDATE (not implemented)
* FORTUNES (not implemented)

## Important Libraries
The tests were run with:
* [Erlang/OTP 28.2](https://github.com/erlang/otp/releases/tag/OTP-28.2)
* [Cowboy 2.14.2](https://github.com/ninenines/cowboy/releases/tag/2.14.2)
* [epgsql 4.8.0](https://github.com/epgsql/epgsql/releases/tag/4.8.0)
* [pooler 1.6.0](https://github.com/epgsql/pooler/releases/tag/1.6.0)

## Test URLs
### JSON

http://localhost:8080/json

### PLAINTEXT

http://localhost:8080/plaintext

### DB

http://localhost:8080/db

### QUERY

http://localhost:8080/query?queries=
