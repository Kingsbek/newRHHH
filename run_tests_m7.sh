#!/bin/bash

if [[ $# < 1 ]]; then
	exit "Please pass a log folder
Call: ./run_tests_m7.sh log_folder"
fi
log_folder=$1


main_log=$log_folder/log_m7

make
echo > $main_log

nb_trials=20
for i in $(seq 1 $nb_trials); do
	exp_log=$log_folder/log_dbg_m7_1_t$i
	echo > $exp_log

	echo "
------------------
test $i" | tee -a $exp_log $main_log

	./RandHHH_33 20000000 1000 100000 OneD_Bits_RHHH.out < trace > $exp_log 2>&1
	
	echo "
head
$(head -n5 $exp_log)

tail
$(tail -n5 $exp_log)

	" | tee -a $main_log

done


# display stats
nb_sucesses=$(grep -c "done with packet processing" $main_log)
nb_fails=$(( $nb_trials - $nb_sucesses ))

echo "

successes: $nb_sucesses
fails: $nb_fails/$nb_trials
" | tee -a $main_log

