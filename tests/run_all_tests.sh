#!/bin/bash

if [[ $# < 1 ]]; then
	exit "Please pass a log folder and a mode
Call: ./run_tests_per_mode.sh log_folder mode"
fi
log_folder=$1 #e.g., /Users/damienfoucard/Documents/work/projects/FS_crunching/data/logs/RHHH_exp_m6+7

./tests/run_tests_per_mode.sh $log_folder 6

./tests/run_tests_per_mode.sh $log_folder 7
