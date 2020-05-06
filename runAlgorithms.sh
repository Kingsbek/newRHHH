#!/bin/bash

#A basic script for running and evaluating the different HHH algorithms of the paper 
#"Constant Time Updates in Hierarchical Heavy Hitters", ACM SIGCOMM 2017,
#by Ran Ben Basat, Gil Einziger, Roy Friedman, Marcelo Caggiani Luizelli, and Erez Waisbard.
#Implementation was done by Ran Ben Basat sran[at]cs.technion.ac.il.

make

#Start by running RHHH and 10-RHHH on 1D-byte level hierarchies (H=5)
echo "RHHH run on 1D-byte level hierarchies (H=5). 20M packets, 1000 counters per hierarchy node, 100K packets threshold."
./RandHHH 30000000 500 100000 OneD_Bytes_RHHH.out < trace
./check1 trace OneD_Bytes_RHHH.out | tail -1 

echo "10-RHHH on run 1D-byte level hierarchies (H=5). 20M packets, 1000 counters per hierarchy node, 100K packets threshold."
./10RandHHH 30000000 500 100000 OneD_Bytes_10RHHH.out < trace
./check1 trace OneD_Bytes_10RHHH.out | tail -1 

#Next, run RHHH and 10-RHHH on 1D-bit level hierarchies (H=33)
# echo "RHHH run on 1D-bit level hierarchies (H=33). 20M packets, 1000 counters per hierarchy node, 100K packets threshold."
# ./RandHHH_33 20000000 1000 100000 OneD_Bits_RHHH.out < trace
# ./check1_33 trace OneD_Bits_RHHH.out | tail -1 

# echo "10-RHHH run on 1D-bit level hierarchies (H=33). 20M packets, 1000 counters per hierarchy node, 100K packets threshold."
# ./10RandHHH_33 20000000 1000 100000 OneD_Bits_10RHHH.out < trace
# ./check1_33 trace OneD_Bits_10RHHH.out | tail -1 


#Finally, we run RHHH and 10-RHHH on 2D-byte level hierarchies (H=25)
# echo "RHHH run on 2D-byte level hierarchies (H=25). 20M packets, 1000 counters per hierarchy node, 100K packets threshold."
# ./RandHHH2D 20000000 1000 100000 TwoD_Bytes_RHHH.out < trace
# ./check2 trace TwoD_Bytes_RHHH.out | tail -1 

# echo "10-RHHH run on 2D-byte level hierarchies (H=25). 20M packets, 1000 counters per hierarchy node, 100K packets threshold."
# ./10RandHHH2D 20000000 1000 100000 TwoD_Bytes_10RHHH.out < trace
# ./check2 trace TwoD_Bytes_10RHHH.out | tail -1 
