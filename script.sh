#!/bin/sh

ROOT_UID=0          # Only users with $UID 0 have root privileges.
TESTCASES=2         # Default number of testcases.
MIN_VERTICES=5      # Minimum number of vertices in DAG
MAX_VERTICES=100    # Maximum number of vertices in DAG
MIN_EDGES=10        # Minimum number of edges in DAG
MAX_EDGES=10        # Maximum number of edges in DAG
MAX_EDGE_WEIGHT=100 # Maximum edge weight
NUM_VMS=5           # Number of VMs available
MAX_POWER=100      # Max Power of VM
MIN_POWER=10       # Min Power of VM
E_NOTROOT=87        # Non-root exit error.

# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi  

if [ -n "$1" ]
# Test whether command-line argument is present (non-empty).
then
  num_testcases=$1
else  
  echo "Usage: bash script.sh <NUM_TESTCASES> <MIN_VERTICES> <MAX_VERTICES> <MIN_EDGES> <MAX_EDGES> <MAX_EDGE_WEIGHT> <NUM_VMs>"
  num_testcases=$TESTCASES # Default, if not specified on command-line.
fi 

if [ -n "$2" ]
# Test whether command-line argument is present (non-empty).
then
  MIN_VERTICES=$2
fi 

if [ -n "$3" ]
# Test whether command-line argument is present (non-empty).
then
  MAX_VERTICES=$3
fi 

if [ -n "$4" ]
# Test whether command-line argument is present (non-empty).
then
  MIN_EDGES=$4
fi 

if [ -n "$5" ]
# Test whether command-line argument is present (non-empty).
then
  MAX_EDGES=$5
fi 

if [ -n "$6" ]
# Test whether command-line argument is present (non-empty).
then
  MAX_EDGE_WEIGHT=$6
fi 

if [ -n "$7" ]
# Test whether command-line argument is present (non-empty).
then
  NUM_VMS=$7
fi 

if [ -n "$8" ]
# Test whether command-line argument is present (non-empty).
then
  MIN_POWER=$8
fi 

if [ -n "$9" ]
# Test whether command-line argument is present (non-empty).
then
  MAX_POWER=$9
fi 

for ((t = 1; t <= num_testcases; t++))
do
    dag_choice=4
    num_vertices=$(((($RANDOM) % ($MAX_VERTICES - $MIN_VERTICES + 1)) + $MIN_VERTICES))
    num_edges=$(((($RANDOM) % ($MAX_EDGES - $MIN_EDGES + 1)) + $MIN_EDGES))
    weighted_choice=2
    
    echo $dag_choice > output.txt
    echo $num_vertices >> output.txt
    echo $num_edges >> output.txt
    echo $weighted_choice >> output.txt
    echo $MAX_EDGE_WEIGHT >> output.txt

    outfile="TEST_OUTP_${t}"
    topofile="TEST_TOPO_${t}"

    echo $outfile >> output.txt
    echo $topofile >> output.txt
    echo 0 >> output.txt

    ./a.out < output.txt > /dev/null

    echo $NUM_VMS >> $outfile

    for ((task = 1; task <= num_vertices; task++)) 
    do
      for ((vm = 1; vm <= NUM_VMS; vm++))
      do
        power=$(((($RANDOM) % ($MAX_POWER - $MIN_POWER + 1)) + $MIN_POWER))
        printf "%d " $power >> $outfile
      done
      printf "\n" >> $outfile
    done

    ./process < $outfile > output.txt
    cp output.txt $outfile
done




