#!/bin/bash
cabal install pandoc
git clone https://github.com/hakimel/reveal.js
pushd reveal.js
patch -p1 < ../reveal.patch
popd
pandoc -t revealjs -s lecture1.md -o lecture1.html
