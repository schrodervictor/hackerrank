# [Divisible Sum Pairs]
by wanbo

**Difficulty**: Easy

## Problem statement

You are given an array of `n` integers, a<sub>0</sub>, a<sub>1</sub>,...,
a<sub>n-1</sub>, and a positive integer, `k`. Find and print the number of
`(i, j)` pairs where `i`&lt;`j` and a<sub>i</sub> + a<sub>j</sub> is evenly
divisible by `k`.

## Input Format

The first line contains 2 space-separated integers, `n` and `k`, respectively.
The second line contains `n` space-separated integers describing the
respective values of a<sub>0</sub>, a<sub>1</sub>,..., a<sub>n-1</sub>.

## Constraints

* 2 &le; `n` &le; 100
* 1 &le; `k` &le; 100
* 1 &le; a<sub>i</sub> &le; 100

## Output Format

Print the number of `(i, j)` pairs where `i` &le; j  and a<sub>i</sub> +
a<sub>j</sub> is evenly divisible by `k`.

## Sample Input

```
6 3
1 3 2 6 1 2
```

## Sample Output

```
 5
```

## Explanation

Here are the 5 valid pairs:

* (0,2) -> a<sub>0</sub> + a<sub>2</sub> = 0 + 2 = 3
* (0,5) -> a<sub>0</sub> + a<sub>5</sub> = 0 + 5 = 3
* (1,3) -> a<sub>1</sub> + a<sub>3</sub> = 1 + 3 = 9
* (2,4) -> a<sub>2</sub> + a<sub>4</sub> = 2 + 4 = 3
* (4,5) -> a<sub>4</sub> + a<sub>5</sub> = 4 + 5 = 3

[Divisible Sum Pairs]:https://www.hackerrank.com/challenges/divisible-sum-pairs
