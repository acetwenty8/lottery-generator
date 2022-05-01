#!/bin/bash

if [[ $1 == MegaMillions ]]; then
    #MegaMillions
    CAT_A=1-9
    CAT_B=10-19
    CAT_C=20-29
    CAT_D=30-39
    CAT_E=40-49
    CAT_F=50-59
    CAT_G=60-70
    CAT_BALL=1-25
else
    #PowerBall
    CAT_A=1-9
    CAT_B=10-19
    CAT_C=20-29
    CAT_D=30-39
    CAT_E=40-49
    CAT_F=50-59
    CAT_G=60-69
    CAT_BALL=1-26
fi

translate_category(){
    if [[ $1 -eq 1 ]]; then
        echo $CAT_A
    elif [[ $1 -eq 2 ]]; then
        echo $CAT_B
    elif [[ $1 -eq 3 ]]; then
        echo $CAT_C
    elif [[ $1 -eq 4 ]]; then
        echo $CAT_D
    elif [[ $1 -eq 5 ]]; then 
        echo $CAT_E
    elif [[ $1 -eq 6 ]]; then
        echo $CAT_F
    elif [[ $1 -eq 7 ]]; then
        echo $CAT_G
    fi
}

double_cat() {
    DOUBLE_CAT=`translate_category "$1"`
    RANGE_LINE="$DOUBLE_CAT,$DOUBLE_CAT,"
    USED_ARRAY=($1)
    for ((i=0; i<=2; i++)) do
        while true; do
            USED=0
            RAND=`shuf -i1-7 -n 1`
	        for (( r=0; r<${#USED_ARRAY[@]}; r++ )) do
    	        if [[ $RAND == ${USED_ARRAY[$r]} ]]; then
        	        USED=1
                    #echo "Found Used Number!"
                fi
            done
                if [[ RAND -eq 7 ]] && [[ PREF -lt 2 ]]; then
                    USED=1
                    let PREF=PREF+1
                fi
     	        if [[ $USED -eq 0 ]]; then
        	        break
                fi
        done
        USED_ARRAY=(${USED_ARRAY[@]} $RAND)
        RANGE=`translate_category $RAND`
        RANGE_LINE="${RANGE_LINE}$RANGE,"
    done
    echo "$RANGE_LINE$CAT_BALL"
}

double_two_cat_seed() {
    USED_ARRAY=()
    for ((i=0; i<=1; i++)) do
        while true; do
            USED=0
            RAND=`shuf -i1-7 -n 1`
            for (( r=0; r<${#USED_ARRAY[@]}; r++ )) do
                if [[ $RAND == ${USED_ARRAY[$r]} ]]; then
                    USED=1
                    #echo "Found Used Number!"
                fi
            done
                if [[ $RAND -eq 7 ]] && [[ $PREF -lt $PREF_NUM ]]; then
                    USED=1
                    let PREF=PREF+1
                fi
                if [[ $USED -eq 0 ]]; then
                    break
                fi
        done
        USED_ARRAY=(${USED_ARRAY[@]} $RAND)
        RANGE=$RAND
        RANGE_LINE="${RANGE_LINE}$RANGE "
    done
    echo "$RANGE_LINE"
}

double_two_cat() {
    USED_ARRAY=()
    CAT_ONE=`translate_category "$1"`
    CAT_TWO=`translate_category "$2"`
    RANGE_LINE="$CAT_ONE,$CAT_ONE,$CAT_TWO,$CAT_TWO,"
    USED_ARRAY=(${USED_ARRAY[@]} $1)
    USED_ARRAY=(${USED_ARRAY[@]} $2)
    for ((i=0; i<1; i++)) do
        while true; do
            USED=0
            RAND=`shuf -i1-7 -n 1`
            for (( r=0; r<${#USED_ARRAY[@]}; r++ )) do
                if [[ $RAND == ${USED_ARRAY[$r]} ]]; then
                    USED=1
                    #echo "Found Used Number!"
                fi
            done
                if [[ $RAND -eq 7 ]] && [[ $PREF -lt $PREF_NUM ]]; then
                    USED=1
                    let PREF=PREF+1
                fi
                if [[ $USED -eq 0 ]]; then
                    break
                fi
        done
        USED_ARRAY=(${USED_ARRAY[@]} $RAND)
        RANGE=`translate_category $RAND`
        RANGE_LINE="${RANGE_LINE}$RANGE,"
    done
    echo "$RANGE_LINE$CAT_BALL"
}


PREF=1
PREF_NUM=1

DOUBLE_A=`double_cat 1`
echo $DOUBLE_A

DOUBLE_B=`double_cat 2`
echo $DOUBLE_B

DOUBLE_C=`double_cat 3`
echo $DOUBLE_C

DOUBLE_D=`double_cat 4`
echo $DOUBLE_D

DOUBLE_E=`double_cat 5`
echo $DOUBLE_E

DOUBLE_F=`double_cat 6`
echo $DOUBLE_F

DOUBLE_G=`double_cat 7`
echo $DOUBLE_G

DTC_1_SEED=`double_two_cat_seed`
DTC_1=`double_two_cat $DTC_1_SEED`
echo $DTC_1

DTC_2_SEED=`double_two_cat_seed`
DTC_2=`double_two_cat $DTC_2_SEED`
echo $DTC_2

DTC_3_SEED=`double_two_cat_seed`
DTC_3=`double_two_cat $DTC_3_SEED`
echo $DTC_3
