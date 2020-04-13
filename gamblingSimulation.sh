#!/bin/bash -x
#constants
BET=1
WIN=1
MAX_PROFIT_PER_DAY=50
MAX_LOSS_PER_DAY=-50
#variables
numOfWinsPerMonth=0
numOfLossesPerMonth=0
prevDayWon=0
prevDayLoss=0
luckyDay=0
unluckyDay=0
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
                ((numOfWinsPerMonth++))
                if [ $(($prevDayWon+1)) -eq $day ]
                then
                        luckyDay=$day
                fi
                prevDayWon=$day

        else
                loose[$day]=-50
                ((numOfLossesPerMonth++))
                if [ $(($prevDayLoss+1)) -eq $day ]
                then
                        unluckyDay=$day
                fi
                prevDayLoss=$day

        fi
done
if [ $luckyDay -eq 1 -o $luckyDay -eq 0 ]
then
        luckyDay=$prevDayWon
fi
if [ $unluckyDay -eq 1 -o $unluckyDay -eq 0 ]
then
        unluckyDay=$prevDayLoss
fi
totalAmount=$((50*(($numOfWinsPerMonth-$numOfLossesPerMonth))))
if [ $totalAmount -gt 0 ]
then
        echo $totalAmount dollar won
else
        echo $totalAmount dollar loss
fi
echo On ${!win[@]} days he won $((50*$numOfWinsPerMonth)) dollar
echo On ${!loose[@]} days he lost $((50*$numOfLossesPerMonth)) dollar
echo Lucky day is $luckyDay and unlucky day is $unluckyDay
