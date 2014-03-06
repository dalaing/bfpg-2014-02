% The Yorgey Lectures - Part 1
% Dave Laing

-----

This is based on a university course run by Brent Yorgey at the Univesity of Pennsylvania.

It is great.

There are awesome homework problems.  

# What is Haskell?

- Functional
- Pure
- Lazy
- Statically typed
 
# Haskell is functional

Functions are values, exactly the same as any other value.

The meaning of programs are centered around evaluating expressions, rather than executing instructions.

# Haskell is pure

- No mutation - variables, data structures, all of it is immutable
- Expressions never have side effects
- Calling the same function with the same arguments results in the same output every time

# Benefits of purity

- Equational reasoning and refactoring
- Parallelism
- Fewer headaches

# Haskell is lazy

Expressions are not evaluated until their results are needed

This is something you can do in finite time:
```haskell
let
  p = primes
  doubledPrimes = map (* 2) p
in
  take 10 doubledPrimes
```

--- 

Actually takes no time at all.

---

This takes a finite amount of time:
```haskell
let
  p = primes
  doubledPrimes = map (* 2) p
  first10DoubledPrimes = take 10 doubledPrimes
in
  print first10DoubledPrimes
```

# Benefits of laziness

- Easy to define new control structures
- Can define and work with infinite data structures 
- Enables more composition and reuse
- *Although*, reasoning about time and space usage is pretty different

# Statically typed

- Every expression has a type
    + Although you don't have to... keystroke... them all
- All types are checked at compile-time
- Programs with type errors will not compile
    + The error was going to bite you anyway
    + Eat your greens and fix it now

# Themes of the course

- Types
- Abstraction
- Wholemeal Programming
 
# Types

- Not annoying (modulo C++ and Java)
- Help clarify thinking and express program structure
- Serve as a form of documentation
- Turn run-time errors into compile-time errors

# Abstraction

- Don't repeat yourself
- Parametric polymorphism, higher-order functions and typeclasses help with this.

# Wholemeal Programming

- Think big
- Solve for a general problem, transform into a specific one
    + Solve for a graph instead of a path
- Offers new perspectives
- Good for re-use, accreting expressive power

# Declarations and Variables

This is some Haskell code
```haskell
x :: Int
x = 3
```
declaring that `x` is a variables of type `Int` with value `3`.

---

This is an error
```haskell
x = 4
```
since `x` already has a value.

---

Variables are not mutable boxes.

`=` is not assignment.

`=` is a definition.
 
# Basic Types

# Integers

```haskell
-- Machine sized integer
-- (everything after '--' is a comment)
i :: Int
i = 5
```

```haskell
-- Arbitrary precision integers
n :: Integer
n = 12345678909876543211234567890987654321
```

# Floating point

```haskell
-- double precision floating point
d :: Double
d = 4.567
```
 
```haskell
-- single precision floating point
f :: Float
f = 4.567
```

# Booleans

```haskell
b1, b2 :: Bool
b1 = False
b2 = True
```

# Characters and Strings

Characters are unicode
```haskell
c1, c2 :: Char
c1 = 'x'
c2 = 'Ø'
```

Strings are lists of characters with special syntax
```haskell
s :: String
s = "This is a string"
```
 
# Arithmetic

```haskell
3 + 2       -- addition
19 - 27     -- subtraction
2.3 * 8.6   -- multiplication
8.7 / 3.1   -- floating point division
mod 19 3    -- modulo operator
19 `mod` 3  -- infix modulo operator
div 19 3    -- integral division
19 `div` 3  -- infix integral division
7 ^ 2       -- exponentiation
(-3) * (-7) -- need to put brackets around negative numbers
```

# Aside: Backticks and brackets

Backticks let us use regular functions like they were infix
```haskell
19 `div` 3
```

Brackets let us use infix functions like they were regular
```haskell
(/) 19.0 3.0
```

# Types have to match

```haskell
i :: Int
n :: Integer
d :: Double
i + i -- fine
i + n -- compile time error
i + d -- compile time error
```

# Conversions

`fromIntegral` converts from any integral type to any other numeric type

```haskell
i, j :: Int
i / j                           -- compile time error
                                -- (/) is not for integer types
fromIntegral i / fromIntegral j -- this is fine
i `div` j                       -- this is fine
```

`round`, `floor`, `ceil` convert floating point numbers to integral types
 
# Boolean logic

The usual suspects are in play
```haskell
True && False           -- logical and
not (False || True)     -- logical not, logical or
'a' == 'a'              -- equality
16 /= 3                 -- non-equality
(5 > 3) && ('p' <= 'q') -- comparisons
```

# If-then-else

If-then-else is an expression
```haskell
if b then t else f
```
Both `t` and `f` have to have the same type.

The result is the same type as `t` and `f`.

There is no `if` without an `else`.

Not that common in Haskell.

---

Fine:
```haskell
if even 2 
    then "OK"
    else "Error: wrong universe" 
```

---

Compile error:
```haskell
if even 2 
    then "OK"
    else 0 
```

---

A beating is imminent:
```haskell
if 1 
    then "This is not C or"
    else "Python you demonspawn."
```

# Functions

# Function types

```haskell
functionName :: T1 -> T2 -> R
```

First argument has type `T1`.

Second argument has type `T2`.

Return type is `R`.

# Using functions

To use a function
```haskell
f :: Int -> Int -> Int -> Int
f x y z = x * y + z
```

List the arguments after the function, separated by spaces
```haskell
f 3 5 2
```

# Function application

Function application has higher precedence than any infix operator

---

This is a mistake
```haskell
f 3 n+1 7
```

---

Because it parses as
```haskell
(f 3 n) + (1 7)
```

---

You should probably write
```haskell
f 3 (n+1) 7
```
 
# Writing functions

We write functions by cases, based on values.

Matches are done from top to bottom.

---

Let us define a function
```haskell
sumtorial :: Integer -> Integer
sumtorial 0 = 0
sumtorial n = n + sumtorial (n - 1)
``` 
and work through an example evaluation
```haskell
sumtorial 2
sumtorial 2 = 2 + sumtorial (2 - 1)
sumtorial 2 = 2 + sumtorial 1

    sumtorial 1 = 1 + sumtorial (1 - 1)
    sumtorial 1 = 1 + sumtorial 0

        sumtorial 0 = 0

    sumtorial 1 = 1 + 0 = 1

sumtorial 2 = 2 + 1 = 3
```

# Guards

We can use guards to break down the choices by *boolean expressions*.

```haskell
hailstone :: Integer -> Integer
hailstone n
    | n `mod` 2 == 0    = n `div` 2
    | otherwise         = 3 * n + 1 
```

Guards are matched from top to bottom.

'otherwise` is the catch-all, just a synonym for True.

---

```haskell
hailstone 4
    | 4 `mod` 2 == 0    = 4 `div` 2 -- <-- condition matches
    | otherwise         = 3 * 4 + 1

hailstone 4             = 4 `div` 2

hailstone 4             = 2
```

```haskell
hailstone 5
    | 5 `mod` 2 == 0    = 5 `div` 2
    | otherwise         = 3 * 5 + 1 -- <-- condition matches

hailstone 5             = 3 * 5 + 1

hailstone 5             = 16
```

# Pairs and tuples

Pairs use brackets and a comma for both types and values.
```haskell
p :: (Int, Char)
p = (3, 'x')
```

We can extract the values with *pattern matching*
```haskell
sumTriple :: (Int, Int, Int) -> Int
sumTriple (x,y,z) = x + y + z
```
 
# Lists

```haskell
nums, range, evenRange :: [Integer]
nums = [1,2,3,19]
range = [1..100]
evenRange = [2,4..100]
```

# String are lists

```haskell
hello1 :: [Char]
hello1 = ['h', 'e', 'l', 'l', 'o']

hello2 :: String
hello2 = "hello"

helloSame = hello1 == hello2
```

So all the standard library functions for lists work for processing strings.
 
# Empty lists

The simplest list is the empty list
```haskell
emptyList = []
```

# Less empty lists

We build other lists by prepending elements.

We do this with the *cons* operator `(:)`
```haskell
-- various lists
1 : []         == [1]
1 : (2 : [])   == [1, 2]
1 : 2 : 3 : [] == [1, 2, 3] -- right associativity helps
```

# Functions can act on lists 

Pattern matching can take apart structure.

A list is either empty, or a value prepended onto another list.


```haskell 
-- Compute the length of a list of Integers.
intListLength :: [Integer] -> Integer
intListLength []     = undefined
intListLength (x:xs) = undefined
```

---

```haskell 
-- Compute the length of a list of Integers.
intListLength :: [Integer] -> Integer
intListLength []     = 0
intListLength (_:xs) = 1 + intListLength xs
```

---

```haskell
intListLength [5,10,15]
intListLength (5 : 10 : 15: [])
intListLength (_ : 10 : 15: []) = 1 + intListLength (10 : 15 : [])

    intListLength (10 : 15 : []) 
    intListLength (_ : 15 : []) = 1 + intListLength (15 : [])

        intListLength (15 : [])
        intListLength (_ : []) = 1 + intListLength []

            intListLength [] = 0

        intListLength (_ : []) = 1 + 0 = 1

    intListLength (_ : 15 : []) = 1 + 1 = 2

intListLength (_ : 10 : 15: []) = 1 + 2 = 3
```

# Functions can produce lists

```haskell
hailstoneSeq :: Integer -> [Integer]
hailstoneSeq 1 = [1]
hailstoneSeq n = n : hailstoneSeq (hailstone n)
```

---
 
```haskell
hailstoneSeq 3 = 3 : hailstoneSeq (hailstone 3)
hailstoneSeq 3 = 3 : hailstoneSeq 10
hailstoneSeq 3 = 3 : 10 : hailstoneSeq (hailstone 10)
hailstoneSeq 3 = 3 : 10 : hailstoneSeq 5
hailstoneSeq 3 = 3 : 10 : 5 : hailstoneSeq (hailstone 5)
hailstoneSeq 3 = 3 : 10 : 5 : hailstoneSeq 16
hailstoneSeq 3 = 3 : 10 : 5 : 16 : hailstoneSeq (hailstone 16)
hailstoneSeq 3 = 3 : 10 : 5 : 16 : hailstoneSeq 8
hailstoneSeq 3 = 3 : 10 : 5 : 16 : 8 : hailstoneSeq (hailstone 8)
hailstoneSeq 3 = 3 : 10 : 5 : 16 : 8 : hailstoneSeq 4
hailstoneSeq 3 = 3 : 10 : 5 : 16 : 8 : 4 : hailstoneSeq (hailstone 4)
hailstoneSeq 3 = 3 : 10 : 5 : 16 : 8 : 4 : hailstoneSeq 2
hailstoneSeq 3 = 3 : 10 : 5 : 16 : 8 : 4 : 2 : hailstoneSeq (hailstone 2)
hailstoneSeq 3 = 3 : 10 : 5 : 16 : 8 : 4 : 2 : hailstoneSeq 1
hailstoneSeq 3 = 3 : 10 : 5 : 16 : 8 : 4 : 2 : 1 : []
hailstoneSeq 3 = [3, 10, 5, 16, 8, 4, 2, 1]
```

# Nested patterns

```haskell 
sumEveryTwo :: [Integer] -> [Integer]
sumEveryTwo []         = []     -- Do nothing to the empty list
sumEveryTwo (x:[])     = [x]    -- Do nothing to lists with a single element
sumEveryTwo (x:(y:zs)) = (x + y) : sumEveryTwo zs
```

---

We can use list literals on the LHS for fixed sized lists

```haskell
sumEveryTwo (x:[])     = [x]
```
becomes
```haskell
sumEveryTwo [x]        = [x]
```

---

We can remove some of the parentheses to clear things up.
```haskell 
sumEveryTwo (x:(y:zs)) = (x + y) : sumEveryTwo zs
```
becomes
```haskell 
sumEveryTwo (x:y:zs)   = (x + y) : sumEveryTwo zs
```

---

```haskell 
sumEveryTwo :: [Integer] -> [Integer]
sumEveryTwo []       = []
sumEveryTwo [x]      = [x]
sumEveryTwo (x:y:zs) = (x + y) : sumEveryTwo zs
```

---

Pairs inside lists work as well:
```haskell
sumPairs :: [(Integer, Integer)] -> [Integer]
sumPairs []           = []
sumPairs ((x,y) : zs) = x + y : sumPairs zs
```

# Combining functions

Build solutions from other functions
 
```haskell
-- The number of hailstone steps needed to reach 1 from a starting
-- number.
hailstoneLen :: Integer -> Integer
hailstoneLen n = intListLength (hailstoneSeq n) - 1
```

Can be more efficient than it appears, thanks to laziness.

# Error messages

# Don't panic

---

```
Prelude> 'x' ++ "foo"

<interactive>:1:1:
    Couldn't match expected type `[a0]' with actual type `Char'
    In the first argument of `(++)', namely 'x'
    In the expression: 'x' ++ "foo"
    In an equation for `it': it = 'x' ++ "foo"
```

# Homework 

- Install the Haskell Platform
- Read the notes, then do the homework
- For the first lecture, you're not meant to use 
  anything not mentioned in the notes

# GHCi

- `:cd dir` to change directory
- `:l filename` to load a module
- `:r` to reload modules
- `:t expression` to get type information 
- `:i name` to get general information

# Credit Card Validation

- broken down into lots of little functions
- think about the recursive parts

# Towers of Hanoi

- this one can be done in one function
- the recursive part is key

# Links

- http://www.seas.upenn.edu/~cis194/lectures.html
- Google: yorgey haskell lectures
- Contact me via BFPG for my email address for homework feedback

# Next month, in the Yorgey Lectures...

- Algebraic Data Types
- More pattern matching
- Case expressions

