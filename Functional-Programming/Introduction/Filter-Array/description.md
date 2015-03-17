# [Filter Array]
Authored by idlecool on Jul 04 2013

## Problem Statement

Filter a given array of integers and leave only that values which are less than a specified value X. The integers in the output should be in the same sequence as they were in the input. You need to write a function with the recommended method signature for the languages mentioned below. For rest of language you have to write complete code.

## Input Format 

The first line contains the delimiter X. This is followed by a list of integers, which represents the elements of list/array. You have to read input to the End-Of-File.

## Output Format 

Print integers in separate line from the array which are less than an upper-limit X in value. The sequence should be same as it was in the original array.

## Constraints 
1 &lt;= size of array &lt;= 100 
For any element in the array, say Y, -100 &lt;= Y &lt;= 100 
-100 &lt;= X &lt;= 100

Note 
You have to write your own implementation of filter function. It is recommended to not use inbuilt library function.

## Sample Input

```
3
10
9
8
2
7
5
1
3
0
```

## Sample Output

```
2
1
0
```

Explanation 2, 1, 0 are the members of the list which are less than the delimiter (3). Also, they are displayed in the same order as they were in the original list.

## Recommended Method Signature

Number Of Parameters: 2
Parameters: [upper-limit(X) list]
Returns: List or Vector

## For Hackers Using Clojure

This will be the outline of your function body (fill up the blank portion marked by underscores):

```
 (fn[delim lst]___________________________)
```

## For Hackers Using Scala

This will be the outline of your function body (fill up the blank portion marked by underscores):

```
 def f(delim:Int,arr:List[Int]):List[Int] = __________________
```

## For Hackers Using Haskell

This will be the outline of your function body (fill up the blank portion marked by underscores):

```
f n arr = _____________________
```

## For Hackers Using other Languages

You have to read input from standard input and write output to standard output. Please follow input/output format mentioned above.

Please note that you only need to submit the code above, after filling in the blanks appropriately. The input and output section will be handled by us. The focus is on writing the correct function.

Copyright (c) 2015 HackerRank.
All Rights Reserved

[Filter Array]:https://www.hackerrank.com/challenges/fp-filter-array
