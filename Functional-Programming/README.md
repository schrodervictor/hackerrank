To compile the Erlang solution and run it against the sample input,
run the following command:

```
$ erlc solution.erl && erl -noshell -eval 'solution:main(),init:stop()' < input.txt
```
