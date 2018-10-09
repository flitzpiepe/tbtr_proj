#! /bin/bash
#
# list_unused_includes.sh
# Copyright (C) 2016 streen <streen@gentoobox>
#
# Distributed under terms of the MIT license.
#


base=~/OpenTTD
ottd=$base/openttd
log=$base/project/log
src=$base/openttd/src

cd $ottd

[[ -d $log ]] || mkdir $log

for srcfile in $src/tbtr_*.cpp
do
    echo File: $srcfile

    while read line
    do
        line_=$(sed 's/\//\\\//g' <<< $line)
        sed -i "/$line_/d" $srcfile
        make >/dev/null 2>&1
        [[ $? == 0 ]] && echo "  $line"
        git reset --hard HEAD >/dev/null 2>&1
    done < <(grep ^\#include $srcfile)

    echo
done

popd
