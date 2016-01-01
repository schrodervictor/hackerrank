#!/bin/bash
read -r -d '' ANSWER <<- ANSWER
Primitive : double
Primitive : char
Primitive : boolean
Primitive : int
Referenced : String
Primitive : boolean
Primitive : double
Primitive : char
Referenced : String
ANSWER

echo "$ANSWER"
