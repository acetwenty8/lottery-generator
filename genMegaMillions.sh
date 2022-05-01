#!/bin/bash

OLD_IFS=$IFS
IFS=", "

USED_ARRAY=()
BALL_ARRAY=()

while read -r line; do

    read -a RANGE <<< $line

    while true; do
        for (( i=0; i<${#RANGE[@]}; i++ )) do
            if [[ $i -le 4 ]]; then
                for (( s=0; s<=100; s++ )) do
                    USED=0
                    SKIP=0
                    RAND=`shuf -i${RANGE[$i]} -n 1`
                    for (( r=0; r<${#USED_ARRAY[@]}; r++ )) do
                        if [[ $RAND == ${USED_ARRAY[$r]} ]]; then
                            USED=1
                            #echo "Found Used Number!"
                        fi
                        if [[ $i -gt 0 ]]; then
                            #echo "RAND is $RAND RAND-1 is $((RAND-1)) RAND+! is $((RAND+1)) Array is ${USED_ARRAY[-1]}"
                            if [[ $((RAND+1)) == ${USED_ARRAY[-1]} ]]; then
                                USED=1
                            fi
                            if [[ $((RAND-1)) == ${USED_ARRAY[-1]} ]]; then
                                USED=1
                            fi
                        fi

                        done
                    if [[ $USED -eq 0 ]]; then
                        break
                    fi
                done
                USED_ARRAY=(${USED_ARRAY[@]} $RAND)
            else
                for (( s=0; s<=100; s++ )) do
                    USED=0
                    RAND=`shuf -i${RANGE[$i]} -n 1`
                    for (( r=0; r<${#BALL_ARRAY[@]}; r++ )) do
                        if [[ $RAND == ${BALL_ARRAY[$r]} ]]; then
                            USED=1
                            #echo "Found Used Number!"
                        fi
                    done
                    if [[ $USED -eq 0 ]]; then
                        break
                    fi
                done
                BALL_ARRAY=(${BALL_ARRAY[@]} $RAND)
            fi
            NUM=`echo $(printf %02d $RAND)`
            NUM_STR="${NUM_STR} $NUM"
        done
        MY_NUMBERS=`echo $NUM_STR | perl -pe 's/(\d\d \d\d \d\d \d\d \d\d) \d\d/$1/g' | xargs -n1 | sort -g | xargs`
        MY_BALL=`echo $NUM_STR | perl -pe 's/\d\d \d\d \d\d \d\d \d\d (\d\d)/$1/g' | xargs -n1 | sort -g | xargs`
        #MY_HISTORY=`./MegaMillions_history.sh "$MY_NUMBERS" "$MYBALL"`
        if [[ $MY_HISTORY -eq 0 ]]; then
            break
        else
            echo "Found Winning Numbers! $NUM_STR"
            unset USED_ARRAY[-1]
            unset USED_ARRAY[-1]
            unset USED_ARRAY[-1]
            unset USED_ARRAY[-1]
            unset USED_ARRAY[-1]
            unset BALL_ARRAY[-1]
            NUM_STR=""
        fi
    done

    echo "$MY_NUMBERS - $MY_BALL"
    NUM_STR=""

done < MegaMillions_range.txt

IFS=$OLD_IFS


