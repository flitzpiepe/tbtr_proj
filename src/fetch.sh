#!/bin/bash

base=/home/streen/code/openttd
tbtr=tbtr
env=$(dirname $0)/fetch.env
if [[ -f $env ]]
then
	base=$(head -1 $env)
	tbtr=$(tail -1 $env)
fi
log=$base/src/fetch.log
remote=bb
dosleep=2
ret=0

echo fetch base: $base
cd $base
while [[ $ret != 0 ]]
do
	printf '.'
	date >>$log
	git fetch $remote >>$log 2>&1
	ret=$?
	[[ ret != 0 ]] && sleep $dosleep
done
echo

echo fetch tbtr: $tbtr
ret=1
cd $tbtr
while [[ $ret != 0 ]]
do
	printf '.'
	date >>$log
	git fetch $remote >>$log 2>&1
	ret=$?
	[[ ret != 0 ]] && sleep $dosleep
done
echo
