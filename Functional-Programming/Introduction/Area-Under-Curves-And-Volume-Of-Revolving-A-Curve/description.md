# [Area Under Curves and Volume of Revolving a Curve]
Authored by idlecool on Mar 15 2013

## Problem Statement

Definite Integrals via Numerical Methods

This relates to definite integration via numerical methods.

Consider the algebraic expression given by:

(a<sub>1</sub>)x<sup>b<sub>1</sub></sup> + (a<sub>2</sub>)x<sup>b<sub>2</sub></sup> + (a<sub>3</sub>)x<sup>b<sub>3</sub></sup> ......(a<sub>n</sub>)x<sup>b<sub>n</sub></sup>

For the purpose of numerical computation, the area under the curve y = f(x) between the limits a and b can be computed by the Limit Definition of a Definite Integral.

Some background about areas and volume computation.

Using equal Sub-Intervals of length = 0.001, you need to

Evaluate the area bounded by a given polynomial function of the kind described above, between given limits L and R.

Evaluate the volume of the solid obtained by revolving this polynomial curve around the X-Axis.

A relative error margin of 0.01 will be tolerated.

## Input Format 

First line will contain N integers separated by spaces, which are the values of a<sub>1</sub>, a<sub>2</sub>...a<sub>N</sub>.

Second Line will contain N integers separated by spaces, which are the values of b<sub>1</sub>, b<sub>2</sub>...b<sub>N</sub>.

The third Line will contain two space separated integers, L, R, which are the lower and upper limits of the range in which integration needs to be performed.

## Constraints 

-1000 &lt;= a &lt;= 1000 

-20 &lt;= b &lt;= 20 

1 &lt;= L &lt; R &lt;= 20

## Output Format

The first Line will contain the area between the curve and the x-axis, bound between the specified limits. The second Line will contain the volume of the solid obtained by rotating the curve around the x-axis, between the specified limits.

## Sample Input

```
1 2 3 4 5
6 7 8 9 10
1 4
```

## Explanatory Note

The algebraic expression represented by

(1)x<sup>6</sup> + (2)x<sup>7</sup> + (3)x<sup>8</sup> + (4)x<sup>9</sup> + (5)x<sup>10</sup>

We need to find the area of the curve enclosed under this curve, between the limits x=1 and 4. And, we also need to find the volume of the solid formed by revolving this curve around the x-axis between the limits x = 1 and 4.

## Sample Output

```
2435300.3
26172951168940.8
```

## Scoring

All test cases are weighted equally. You need to clear all the tests in a test case.

Copyright (c) 2015 HackerRank.
All Rights Reserved

[Area Under Curves and Volume of Revolving a Curve]:https://www.hackerrank.com/challenges/area-under-curves-and-volume-of-revolving-a-curv
