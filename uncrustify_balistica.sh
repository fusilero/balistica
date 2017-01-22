#!/bin/bash

# make our working directory
mkdir -p uncrustify_out

# find all of our vala files
find -name "*.vala" > uncrustify_out/files.txt
files=$(<uncrustify_out/files.txt)

# run uncrustify on all the vala files and create a temp copy of it
for item in $files ; do
  dn=$(dirname $item)
  mkdir -p uncrustify_out/$dn
  uncrustify -f $item -c .uncrustify.cfg > uncrustify_out/$item
done

# copy over all our canonical source files with the uncrusted version
cp -r uncrustify_out/src/* src/
cp -r uncrustify_out/test/* test/

# cleanup
rm -rf uncrustify_out/
