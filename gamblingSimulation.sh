#!/bin/bash -x
#constants
BET=1
WIN=1
MAX_DAYS=20
MAX_PROFIT_PER_DAY=50
MAX_LOSS_PER_DAY=-50
#variables
month=1
nextMonth=yes
function findNumOfWinsOrLossesPerMonth(){
        for (( day=1; day<=$MAX_DAYS; day++ ))
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
                else
                        loose[$day]=-50
                        ((numOfLossesPerMonth++))
                fi
        done
}
function findLuckyDay(){
        prevDayWon=0
        luckyDay=0
        for days in "${!win[@]}"
        do
                if [ $(($prevDayWon+1)) -eq $days ]
                then
                        luckyDay=$days
                fi
                prevDayWon=$days
        done
        if [ $luckyDay -eq 1 -o $luckyDay -eq 0 ]
        then
                luckyDay=$prevDayWon
        fi
}
function findUnluckyDay(){
        prevDayLoss=0
        unluckyDay=0
        for days in "${!loose[@]}"
        do
                if [ $(($prevDayLoss+1)) -eq $days ]
                then
                        unluckyDay=$days
                fi
                prevDayLoss=$days
        done
        if [ $unluckyDay -eq 1 -o $unluckyDay -eq 0 ]
        then
                unluckyDay=$prevDayLoss
        fi
}
while [ $nextMonth = yes ]
do
        numOfWinsPerMonth=0
        numOfLossesPerMonth=0
        #calling function to find number of wins and losses in a month
        findNumOfWinsOrLossesPerMonth
        totalAmount=$((50*(($numOfWinsPerMonth-$numOfLossesPerMonth))))
        if [ $totalAmount -gt 0 ]
        then
                echo $totalAmount dollar won in month $month
                nextMonth=yes
        else
                echo $totalAmount dollar loss in month $month
                nextMonth=no
        fi
        #calling function to find lucky day
        findLuckyDay
        #calling function to find unlucky day
        findUnluckyDay
        echo On ${!win[@]} days he won $((50*$numOfWinsPerMonth)) dollar in month $month
        echo On ${!loose[@]} days he lost $((50*$numOfLossesPerMonth)) dollar in month $month
        echo Lucky day is $luckyDay and unlucky day is $unluckyDay in month $month
        ((month++))
        unset win
        unset loose
done
