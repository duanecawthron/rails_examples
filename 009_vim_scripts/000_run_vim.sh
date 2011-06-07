#!/bin/bash

rm -rf tmp
cp -pr src tmp
cd tmp
cp input.txt output.txt

echo The file looks like this:
cat output.txt
echo

echo Run this script:
cat add_some_text.vim
echo

vim -s add_some_text.vim output.txt

echo Now, the file looks like this:
cat output.txt
