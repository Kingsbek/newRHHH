#!/bin/bash

if [[ $# < 2 ]]; then
	exit "Please pass a log folder and a mode
Call: ./run_tests_per_mode.sh log_folder mode"
fi
log_folder=$1
mode=$2

sub_log_folder=$log_folder/logs_m$mode
mkdir -p $sub_log_folder

main_log=$sub_log_folder/log_m$mode

make

echo > $main_log

nb_trials=20

nb_successes=0
nb_fails=0

for i in $(seq 1 $nb_trials); do
	exp_log=$sub_log_folder/log_m${mode}_t$i
	echo > $exp_log

	echo "
------------------
test $i" | tee -a $exp_log $main_log

	./RandHHH_33 20000000 1000 100000 $mode OneD_Bits_RHHH.out < trace > $exp_log 2>&1

	echo "after run"

	if [[ -s $exp_log ]]; then
		(( nb_successes+=1))
		echo "
head
$(head -n5 $exp_log)

tail
$(tail -n5 $exp_log)

		" | tee -a $main_log

		rm $exp_log
	else
		(( nb_fails+=1))
	fi
done


# store stats
echo "

successes: ${nb_successes}/${nb_trials}
fails: ${nb_fails}/${nb_trials}
" | tee -a $main_log
