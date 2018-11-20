#!/bin/bash

base=/home/streen/code/openttd
tbtr=tbtr_new
log=$base/src/fetch.log
remote=bb
ret=1

echo fetch base
cd $base
while [[ $ret != 0 ]]
do
	printf ' .'
	date >>$log
	git fetch $remote >>$log
	ret=$?
	[[ ret != 0 ]] && sleep 1
done
echo

echo fetch tbtr
cd $tbtr
while [[ $ret != 0 ]]
do
	printf ' .'
	date >>$log
	git fetch $remote >>$log
	ret=$?
	[[ ret != 0 ]] && sleep 1
done
echo
