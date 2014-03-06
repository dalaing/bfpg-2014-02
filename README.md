The slides are in the `slides` directory.
From there you can do
```
./build.sh
```
to build them, provided you have git and the Haskell Platform installed.

There is some started code for the homework in the `code` directory.
If you do
```
cabal install doctest
```
then you should be able to work on filling out the code in `Week01.hs`, then type
```
doctest Week01.hs
```
from the same directory, and the examples in the comments will be used as unit tests to let you know how you're going.
