#!/bin/bash

# Cleanup youtube download fragments


if [ "$1" == "" ]; then
	find -type f -iname '*.f*.*'
	echo "To clean, run $0 -clean"

elif [ "$1" == "-clean" ]; then
	find -type f -iname '*.f*.*' -delete
fi
