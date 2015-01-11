#!/bin/bash

# apply all patches found in a given base directory one-by-one
# if a patch succeeds, make a git commit containing the name of the patch file as message and move the patch file into a certain archive directory
# otherwise, just notify on the failed patch and leave it for examination
# patches are applied in the order that they are listed by ls

BASE=../__split_patches
ARCHIVE=../applied_patches

_IFS=$IFS
IFS=$(echo -en "\n\b")
for patch in $BASE/*; do

	fn=$(sed -r 's/.*\///' <<< $patch)

	printf "patch $fn ... "

	# get the name of the patched file
	pf=$(head -2 $patch | tail -1 | sed -r 's/^--- //' | sed -r 's/\t.*//')

	if patch -s -t -p0 < $patch 1>/dev/null 2>&1; then
		printf "ok\n"
		mv $patch $ARCHIVE
		git add $pf >/dev/null
		git commit -m "applied patch $fn (file $pf)" >/dev/null
	else
		printf "failed\n"
		git reset --hard HEAD
	fi

done
IFS=$_IFS


