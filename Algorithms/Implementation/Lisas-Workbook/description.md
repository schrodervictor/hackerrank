# [Lisa's Workbook]
by Errichto

Difficulty: Easy

## Problem Statement

Lisa just got a new math workbook. A workbook contains exercise problems,
grouped into chapters.

* There are `n` chapters in Lisa's workbook, numbered from 1 to `n`.
* The `i`-th chapter has `t` problems, numbered from 1 to `t`<sub>i</sub>.
* Each page can hold up to `k` problems. There are no empty pages or
  unnecessary spaces, so only the last page of a chapter may contain fewer than
  `k` problems.
* Each new chapter starts on a new page, so a page will never contain problems
from more than one chapter.
* The page number indexing starts at 1.

Lisa believes a problem to be special if its index (within a chapter) is the
same as the page number where it's located. Given the details for Lisa's
workbook, can you count its number of special problems?

**Note**: See the diagram in the Explanation section for more details.

## Input Format

The first line contains two integers `n` and `k` — the number of chapters and
the maximum number of problems per page respectively.

The second line contains `n` integers `t`<sub>1</sub>,
`t`<sub>2</sub>,...,`t`<sub>n</sub>, where `t`<sub>i</sub> denotes the number
of problems in the `i`-th chapter.

## Constraints

* 1 &le; `n`, `k`, `t`<sub>i</sub> &le; 100

## Output Format

Print the number of special problems in Lisa's workbook.

## Sample Input

```
5 3
4 2 6 1 10
```

## Sample Output

```
4
```

## Explanation

The diagram below depicts Lisa's workbook with `n` = 5 chapters and a maximum
of `k` = 3 problems per page. Special problems are outlined in red, and page
numbers are in yellow squares.

![book example](bear_workbook.png?raw=true)

There are 4 special problems and thus we print the number 4 on a new line.

[Lisa's Workbook]:https://www.hackerrank.com/challenges/bear-and-workbook
