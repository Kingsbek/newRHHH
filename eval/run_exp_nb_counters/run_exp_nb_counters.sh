# one-off
# all packets of processed at once
./RandHHH 20000000 300 100000 OneD_Bytes_RHHH.out 
./RandHHH 20000000 500 100000 OneD_Bytes_RHHH.out 
./RandHHH 20000000 1000 100000 OneD_Bytes_RHHH.out 


#

# first window - processing first window of 100 packets
# ML tells us which paramete to use based on history
counter=300
./RandHHH 100 $counter 100000 OneD_Bytes_RHHH.out 

# second window - processing second window of 100 packets
# ML tells us which paramete to use based on history
counter=500
./RandHHH 100 $counter 100000 OneD_Bytes_RHHH.out 

