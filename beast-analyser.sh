#!/bin/bash

# Make sure the she-bang line above is correct by typing "which bash" on the CLI

echo "+--------------------------------------------------------------------+"
echo "| BEAST analysis simplifyer by Albe van der Merwe                    |"
echo "| Email: albe.vdmerwe@gmail.com                                      |"
echo "| Git clone: https://github.com/albevdmerwe/beast-analyser           |"
echo "|                                                                    |"
echo "| Output files should be named <name>.run01.xml <name>.run02.xml etc |"
echo "| where <name> is an arbitrary name chosen by you consisting only of |"
echo "| alphanumeric characters and _. No spaces or other special chars    |"
echo "| are allowed.                                                       |"
echo "|                                                                    |"
echo "| If analysis fails with an out-of-memory error, increase your Java  |"
echo "| VM's RAM allowance or analyse fewer files.                         |"
echo "+--------------------------------------------------------------------+"

echo ""

echo "Choose a task:"
echo "a) Set burnin"
echo "b) Combine log files"
echo "c) Combine tree files"
echo "d) Analyse log files"
echo "e) Annotate trees"
echo "x) Exit"

read CHOICE

case $CHOICE in

a|A) echo "Burnin amount:"
read NEWBURNIN
export BURNIN=${NEWBURNIN}
echo "Burnin set at ${BURNIN}"
sleep 1
`which beast-analyser.sh`;;

b|B) echo "RUNNING:"
echo "logcombiner -burnin ${BURNIN} `ls *run*.log` logcombiner.out.logs"
sleep 10
logcombiner -burnin ${BURNIN} `ls *run*.log` logcombiner.out.logs
echo "LOGCOMBINER finished with logs..."
sleep 10
`which beast-analyser.sh`;;

c|C) echo "RUNNING logcombiner..." 
logcombiner -trees -burnin ${BURNIN} `ls *run*.trees` logcombiner.out.trees
echo "LOGCOMBINER finished with trees..."
sleep 10
`which beast-analyser.sh`;;

d|D) echo "RUNNING loganalyser..."
loganalyser logcombiner.out.logs loganalyser.out.logs
echo "LOGANALYSER finished analysing logs..."
sleep 10
`which beast-analyser.sh`;;

e|E) echo "RUNNING treeannotator..."
treeannotator -burnin 0 -heights mean logcombiner.out.trees treeannotator.out
echo "TREEANNOTATOR finished analysing trees..."
sleep 10
`which beast-analyser.sh`;; 

x|X) clear;
echo "+--------------------------------------------------------------------+"
echo "| You can now view the trace files (logs) using TRACER or load the   |"
echo "| treeannotator.out file in FIGTREE.                                 |"
echo "+--------------------------------------------------------------------+"
exit;;

esac
