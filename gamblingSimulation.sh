#!/bin/bash -x
#constants
BET=1
STAKE=100
WIN=1
MAX_PROFIT_PER_DAY=50
MAX_LOSS_PER_DAY=-50
#variables
earnMoney=0
totalAmount=0
for (( i=1; i<=20; i++))
do
	earnMoney=0
	while [ $earnMoney -gt $MAX_LOSS_PER_DAY -a $earnMoney -lt $MAX_PROFIT_PER_DAY ]
	do
		if [ $WIN -eq $((RANDOM%2)) ]
		then
			earnMoney=$(($earnMoney+$BET))
		else
			earnMoney=$(($earnMoney-$BET))
		fi
	done
	totalAmount=$(($totalAmount+$earnMoney))
done
if [ $totalAmount -gt 0 ]
then
	echo $totalAmount dollar won
else
	echo $totalAmount dollar loss
fi
