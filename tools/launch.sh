#!/bin/bash

openttd=/home/streen/code/openttd/tbtr/bin/openttd
cfg=/home/streen/.openttd/openttd.cfg

zoom=

while getopts ':z:' opt
do
	case $opt in
		z)
			zoom=$OPTARG
			;;
		*)
			echo unrecognized option, ignore
			;;
	esac
done

[[ $zoom != '' ]] && sed -i "s/^gui_zoom.*/gui_zoom = $zoom/" $cfg

$openttd -s null -g tbtr.sav
