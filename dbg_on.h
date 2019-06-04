#!/bin/bash

base=/home/streen/code/openttd
tbtr=/home/streen/code/openttd/tbtr/src

cp $base/src/tbtr_debug.h $tbtr

file=$tbtr/tbtr_template_vehicle.h

sources=$base/tbtr/source.list
if ! grep -q tbtr_debug.h $sources
then
	sed -i -r 's/^(tbtr_template_vehicle.cpp)/\1\ntbtr_debug.h/' $sources
fi
