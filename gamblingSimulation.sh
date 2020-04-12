#!/bin/bash -x
#constants
BET=1
STAKE=100
WIN=1
MAX_PROFIT_PER_DAY=50
MAX_LOSS_PER_DAY=-50
#variables
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
echo $earnMoney
