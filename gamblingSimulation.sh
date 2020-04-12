#!/bin/bash -x
#constants
BET=1
STAKE=100
WIN=1
if [ $WIN -eq $((RANDOM%2)) ]
then
	echo won 1 dollar
else
	echo loose 1 dollar
fi
