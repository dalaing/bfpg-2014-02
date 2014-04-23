#!/bin/bash
cabal install pandoc
git clone https://github.com/hakimel/reveal.js
pushd reveal.js
git checkout 8b8cc607d4e02ca51c4256175b9cc861f75b70e3
patch -p1 < ../reveal.patch
popd
pandoc -t revealjs -s lecture1.md -o lecture1.html
