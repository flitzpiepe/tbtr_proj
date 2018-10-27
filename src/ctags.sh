#! /bin/sh

base=~/code/openttd
src=tbtr/src
tags=tags

cd $base

echo removing previous tags file
rm $tags

echo generating new tags from base source
ctags -o $tags $src/*

echo appending tags for all source subdirectories
find $src -type d | while read d ; do ctags -a $tags $d/* ; done
