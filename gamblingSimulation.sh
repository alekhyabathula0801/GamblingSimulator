#!/bin/bash -x
#constants
BET=1
STAKE=100
WIN=1
MAX_PROFIT_PER_DAY=50
MAX_LOSS_PER_DAY=-50
#variables
earnMoney=0
numOfWins=0
numOfLosses=0
for (( day=1; day<=20; day++))
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
	if [ $earnMoney -eq 50 ]
	then
		win[$day]=50
		((numOfWins++))
	else
		loose[$day]=-50
		((numOfLosses++))
	fi
done
totalAmount=$((50*(($numOfWins-$numOfLosses))))
if [ $totalAmount -gt 0 ]
then
	echo $totalAmount dollar won
else
	echo $totalAmount dollar loss
fi
echo On ${!win[@]} days he won $((50*$numOfWins)) dollar
echo On ${!loose[@]} days he lost $((50*$numOfLosses)) dollar
