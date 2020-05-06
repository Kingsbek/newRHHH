
# XRHHH - Flexible Constant-Time Hierarchical Heavy Hitter Tracking


## Acknowledgments

Code by Ran Ben Basat, Gil Einziger, Roy Friedman, Marcelo Caggiani Luizelli, and Erez Waisbard

Extended by Damien Foucard (damienfoucard@tu-berlin.de)

Implementation of the ""Constant Time Updates in Hierarchical Heavy Hitters" paper, ACM SIGCOMM 2017



## Intro

This is an open source implementation of the "Constant Time Updates in Hierarchical Heavy Hitters" paper,
published in ACM SIGCOMM 2017, by Ran Ben Basat, Gil Einziger, Roy Friedman, Marcelo Caggiani Luizelli, and Erez Waisbard.

Implementation was done by Ran Ben Basat (sran[at]cs.technion.ac.il), 2017.

The code here contains the implementation of our RHHH and 10-RHHH algorithms.
For the algorithms we compared to (MST, Partial Ancestry and Full Ancestry), 
please refer to Thomas Steinke's implementation (http://people.seas.harvard.edu/~tsteinke/hhh/).


## Setup

In order to run the code, first (after ```bash
	chmod +x```
	) use the "createDataset" file that downloads data from CAIDA and parses a packet trace.
Note that you need to edit the script to enter your CAIDA credentials (http://www.caida.org/data/passive/passive_dataset_request.xml).
Alternatively, you can parse you own .pcap file into the "dataSample" file format (see "createDataset" for the exact command).
This creates a 20M+ long packet stream in a file named "trace". 
Note that in the paper we evaluated on longer traces (up to 1B packets).


## Run & Check

Next, run the "runAlgorithms" script. It runs RHHH and 10-RHHH on the parsed trace and measures both time and HHH precision metrics.
Specifically, its output allows computation of the metrics proposed in the paper:
1. Accuracy -- the percentage of prefixes whose frequency estimation was off by more than eps*(stream length). 
For example, the 10-RHHH 2D-bytes (last algorithm) below had accuracy error rate of 8/177.
2. Coverage errors -- the precentage of real HHH missing from the algorithm's report. For 10-RHHH 2D-bytes below it would be 2/161.
3. False Positive Rate - the percentage of reported prefixes which is not a real HHH. For 10-RHHH 2D-bytes below it would be 16/177.
4. Speed -- the mean time for processing the 20M packets of 10-RHHH 2D-bytes was 0.4173s, with a confidence interval of (0.4171s-0.4176s). 
This translates to 47.92 Million Packets per Second (Mpps) with a confidence interval of 47.89-47.95 Mpps.

Below is the output of "runAlgorithms", as measured on our server:

```
make: Nothing to be done for `all'.
RHHH run on 1D-byte level hierarchies (H=5). 20M packets, 1000 counters per hierarchy node, 100K packets threshold.
20000000 ips took 0.820631s (0.819163s-0.822099s) 73 HHHs
0 accErrors 0 covErrors 67 exact hhhs
10-RHHH on run 1D-byte level hierarchies (H=5). 20M packets, 1000 counters per hierarchy node, 100K packets threshold.
20000000 ips took 0.335286s (0.325752s-0.344820s) 73 HHHs
3 accErrors 0 covErrors 67 exact hhhs
RHHH run on 1D-bit level hierarchies (H=33). 20M packets, 1000 counters per hierarchy node, 100K packets threshold.
20000000 ips took 1.257063s (1.256465s-1.257661s) 245 HHHs
2 accErrors 0 covErrors 158 exact hhhs
10-RHHH run on 1D-bit level hierarchies (H=33). 20M packets, 1000 counters per hierarchy node, 100K packets threshold.
20000000 ips took 0.384982s (0.384722s-0.385242s) 229 HHHs
21 accErrors 0 covErrors 158 exact hhhs
RHHH run on 2D-byte level hierarchies (H=25). 20M packets, 1000 counters per hierarchy node, 100K packets threshold.
20000000 pairs took 1.592494s (1.574401s-1.610587s) 178 HHHs
1 accErrors 3 covErrors 161 exact hhhs
10-RHHH run on 2D-byte level hierarchies (H=25). 20M packets, 1000 counters per hierarchy node, 100K packets threshold.
20000000 pairs took 0.417347s (0.417088s-0.417606s) 177 HHHs
8 accErrors 2 covErrors 161 exact hhhs
```


June 2018: Tommy Fan and Austin Poore from Stanford did an awesome job reproducing some of the results of the paper. They partially implemented the algorithms and provide additional scripts for running, analyzing, and plotting the data. See their repo here: https://github.com/lechengfan/RHHH




## Documentation

### Function Call
Before Extension:
```bash
./RandHHH n counters threshold fp
```
After extension,
```bash
./RandHHH n counters threshold fp mode verbosity
```
The ```mode``` decides which IPs to parse on packets:

- ```mode = 6```: parsing only source IPs
- ```mode = 7```: parsing only destination IPs
- ```mode = 67```: parsing both source and destination IPs, and keeping a single tree of counts for the two (default previous behavior)


### overview format existing data

- check
	- format 1D
		- pattern
```bash
./check1 data output
```
	- format 2D
		- pattern
```bash
./check2 data output
```
- RHHH
	- format 1D
		- pattern
			command:
```bash
./RandHHH n counters threshold num time
```

			soutput:
```
item mask upper lower
```
		- example
```bash
./RandHHH_33 20000000 1000 100000 245 1.222201
25 0.0.0.0 3733818 3733818
```
		- NB:
			counts simultaneously IP sources and IP destinations: increment an IP each time the IP is either source or - destination
	- format 2D
		- pattern
```bash
./RandHHH2D n counters threshold num time
item mask upper lower
```
		- example
```bash
./RandHHH2D 20000000 1000 100000 25 0.522896
0 31.86.160.214 31.0.0.0 20003375 20003375
```
		- NB:
			in our current runs on 2D, RHHH works on /0, /8, /16, /24 and /32 on each of the two dimensions (5 * 5=25 possibilities, H=25)




## trace - RHHH format
header (not in the actual data):
```source IP	destination IP```

```
111 37 227 254	1 148 201 155
128 42 32 38	1 96 166 181
101 133 64 239	5 252 100 69
109 147 8 86	1 152 171 145
119 226 192 68	1 96 166 199
121 36 251 209	1 96 166 240
118 178 44 143	1 107 142 244
58 13 161 116	153 193 47 116
72 189 201 155	111 205 228 241
137 195 64 142	198 85 16 230
```


## tree - RHHH format
header (not in the actual data):
```item mask upper lower```

```
29 0.0.0.0 231 231
31 0.0.0.0 957 957
32 0.0.0.0 1122 1122
26 64.0.0.0 231 231
30 64.0.0.0 627 627
22 65.128.0.0 198 198
29 96.0.0.0 198 198
29 192.0.0.0 363 363
```

Example command to generate that data:
```bash
./RandHHH_33 1000 100 1000 8 0.000036
```

Item Sizes:
	```Size of the output generated by the algorithm```
	```Number of items output```
