# [Problem Statement]

Given a list repeat each element of the list n times. The input and output portions will be handled automatically by the grader. You need to write a function with the recommended method signature.

## Input Format
First line has integer S where S is the number of times you need to repeat elements. After this there are X lines, each containing an integer. These are the X elements of the array.

## Output Format
Repeat each element of the original list S times. So you have to return list/vector/array of S\*X integers. The relative positions of the values should be same as the original list provided as input.

## Constraints
0&lt;=X&lt;=10
1&lt;=S&lt;=100

## Sample Input

```
3
1
2
3
4
```

## Sample Output

```
1
1
1
2
2
2
3
3
3
4
4
4
```

## Recommended Method Signature

Number Of Parameters: 2
Parameters: [number of times to replicate elements, list]
Returns: List or Vector

## For Hackers Using Clojure

This will be the outline of your function body (fill up the blank portion marked by underscores):

```
 (fn[num lst]___________________________)
```

## For Hackers Using Scala

This will be the outline of your function body (fill up the blank portion marked by underscores):

```
 def f(num:Int,arr:List[Int]):List[Int] = __________________
```

## For Hackers Using Haskell

This will be the outline of your function body (fill up the blank portion marked by underscores):

```
 f n arr = ___________________
```

## For Hackers Using OCaml

This will be the outline of your function body (fill up the blank portion marked by underscores):
```
 let f n arr = (*Complete this function*)
```

## For Hackers Using other Languages

You have to read input from standard input and write output to standard output. Please follow input/output format mentioned above.

Please note that you only need to submit the code above, after filling in the blanks appropriately. The input and output section will be handled by us. The focus is on writing the correct function.

Copyright (c) 2015 HackerRank.
All Rights Reserved

[Problem Statement]:https://www.hackerrank.com/challenges/fp-list-replication
