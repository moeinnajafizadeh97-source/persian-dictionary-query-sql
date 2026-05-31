# Persian Dictionary Query System (SQL Server)

## Overview
A recursive CTE stored procedure in Microsoft SQL Server that generates 
all valid Persian words from a set of input characters, validated against 
a 20,000-word dictionary.

## How It Works
The user provides:
- A string of characters (e.g. "آبپت")
- A comma-separated list of word lengths (e.g. "2,3,4")

The procedure generates all possible permutations of the input characters 
at each specified length, then filters results using a RIGHT JOIN against 
the dictionary — returning only real Persian words.

## Example
Input characters: "آبپت"
Input lengths: "2,3"
Output: All valid 2-letter and 3-letter Persian words from those characters

## Technical Details
- Recursive CTE generates permutations up to specified depth
- MAXRECURSION 0 to handle deep recursion for longer words
- RIGHT JOIN against Dictionary table filters invalid combinations
- STRING_SPLIT used to accept multiple target lengths in one call
- Supports up to 10 input characters

## Files
- `GenerateWords.sql` — stored procedure definition
- Dictionary file — 20,000 Persian words used for validation

## Tech Stack
- Microsoft SQL Server
- T-SQL (Recursive CTE, Stored Procedures, STRING_SPLIT, ROW_NUMBER)
