#!/bin/bash

base=/home/streen/code/openttd
tbtr=/home/streen/code/openttd/tbtr_new/src

cp $base/src/tbtr_debug.h $tbtr

file=$tbtr/tbtr_template_vehicle.h

if ! grep -q tbtr_debug.h $file
then
	sed -i -r 's/^(typedef uint32 TemplateID.*)/\1\n#include "tbtr_debug.h"/' $file
fi
