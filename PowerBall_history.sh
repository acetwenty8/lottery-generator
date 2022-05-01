#!/bin/bash

#CHECK_NUMBERS="16,25,33,39,41"
#CHECK_BALL="06"

CHECK_NUMBERS=$1
CHECK_BALL=$2
r_value=0

IFS=', '
read -a numarr <<< $CHECK_NUMBERS

while read -r line; do
    MATCH_NUM=0
    MATCH_BALL=0
    IFS=', '
    read -a arr <<< $line
    i=1
    n=0
    #echo ${arr[0]}
    #echo ${arr[1]}
    #echo ${arr[2]}
    #echo ${arr[3]}
    #echo ${arr[4]}
    #echo ${arr[5]}
    #echo ${arr[6]}
    #echo ${arr[7]}
    #echo ${arr[8]}
    #exit

    while [[ $i -le 6 ]]; do 
        grep -q ^${numarr[$n]}$ <<< ${arr[$i]}
        RV=$?
        if [[ $RV -eq 0 ]]; then
            let MATCH_NUM=MATCH_NUM+1
            #echo "DEBUG MATCHED ^${numarr[$n]}$ ${arr[$i]}"
        fi
        let i=i+1
        let n=n+1
    done
    read -a arr <<< $line
    #echo $CHECK_BALL :: ${arr[6]}
    grep -q ^$CHECK_BALL$ <<< ${arr[6]}
    RV=$?
    if [[ $RV -eq 0 ]]; then 
        MATCH_BALL=1
    fi
    #echo "MATCH_NUM:$MATCH_NUM MATCH_BALL:$MATCH_BALL"
    if [[ $MATCH_NUM -eq 5 ]] && [[ $MATCH_BALL -eq 1 ]]; then 
        echo "JACKPOT MATCHED: $line" > PowerBall_history.out
        r_value=1
    elif [[ $MATCH_NUM -eq 5 ]]; then
        echo "5 MATCHED: $line" > PowerBall_history.out
        r_value=1
    fi

done < PowerBall.csv

echo $r_value
