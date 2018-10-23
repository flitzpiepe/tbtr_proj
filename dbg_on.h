#!/bin/bash

base=/home/streen/code/openttd
tbtr=/home/streen/code/openttd/tbtr_new/src

cp $base/src/tbtr_debug.h $tbtr
cp $base/src/tbtr_debug.cpp $tbtr

file=$tbtr/tbtr_template_vehicle.h

sources=$base/tbtr_new/source.list
if ! grep -q tbtr_debug.cpp $sources
then
	sed -i -r 's/^(tbtr_template_vehicle.cpp)/\1\ntbtr_debug.cpp/' $sources
fi
