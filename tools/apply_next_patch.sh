#/bin/bash

# apply the next patch file from the given base directory in the CURRENT directory (i.e. "./")
# patches will be searched in the BASE directory
# the patch selected will be the smallest one
# the patch files can be filtered by using the first command line argument to this script
#	- the first expression will be given to grep as string
#	- the string of $1 is eval'ed, i.e. it is possible to input something like '-P "abc" | grep -v def'

BASE=../__split_patches/
FILTER='.*'
if [[ $1 != "" ]]; then
	FILTER=$1
fi
PID_VIM=

function killvim
{
	kill $PID_GVIM 1>/dev/null 2>&1
}

echo " * Filter for patch files: $FILTER"

echo " * Next 4 patches:"
ex="wc -l $BASE/* | grep $FILTER | sort -nr | tail -4"
eval $ex

ex="wc -l $BASE/* | grep $FILTER | sort -nr | tail -1 | awk '{print \$2}'"
next=$(eval $ex)
echo " * Next patch: $next"
gvim $next 1>/dev/null 2>&1 &
PID_GVIM=$(($! + 1))
echo " --- gvim running on $PID_GVIM"

xxx=
while [[ $xxx != "y" && $xxx != "n" ]]; do
	printf "Apply the patch ? (yn): "
	read xxx
done
echo a: $xxx

if [[ $xxx == "n" ]]; then
	echo " * Ok, quit"
	killvim
	exit 0
fi

patch -p0 < $next | tee __tmp

if grep -q FAILED __tmp ; then
	echo Hunk failed, please go check
	killvim
else
	fn=$(sed -r 's/.*\///' <<< $next)
	target=../applied_patches/$fn
	echo " * Moving $next   to   $target"
	mv $next $target
	echo " * commit to repo"
	git commit -a -m "applied $fn"
	echo " * All done"
	killvim
	echo ____________
	ls ../applied_patches
fi

echo ""

