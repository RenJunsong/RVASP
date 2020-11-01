#!/bin/bash
## Need to set the path where boltztrap is installed ,and the T of intrans##
boltztrap_path=$HOME/soft/boltztrap-1.2.5
## Settings ##

T1="300."
T2="300."
if [ $# -eq 2 ]; then
T1=$1
T2=$2
fi
python $RVASP_path/boltztrap/EIGENVAL_up_down.py
function btp(){
    $boltztrap_path/src/x_trans BoltzTraP
    rm :log
}
function up_down(){
mkdir boltztrap_up
mkdir boltztrap_down
mv EIGENVAL EIGENVAL_def
mv EIGENVAL_up EIGENVAL
vaspkit -task 731
mv case.intrans boltztrap_up/boltztrap_up.intrans
mv case.energy boltztrap_up/boltztrap_up.energy
mv case.struct boltztrap_up/boltztrap_up.struct
mv EIGENVAL EIGENVAL_up
mv EIGENVAL_down EIGENVAL
vaspkit -task 731
mv case.intrans boltztrap_down/boltztrap_down.intrans
mv case.energy boltztrap_down/boltztrap_down.energy
mv case.struct boltztrap_down/boltztrap_down.struct
mv EIGENVAL EIGENVAL_down
mv EIGENVAL_def EIGENVAL
rm EIGENVAL_up
rm EIGENVAL_down
cd boltztrap_up
sed -i "8c $T1 $T2" boltztrap_up.intrans
btp
cd ..
mv boltztrap_up/boltztrap_up.trace boltztrap_up.trace
rm boltztrap_up -r
cd boltztrap_down
sed -i "8c $T1 $T2" boltztrap_down.intrans
btp
cd ..
mv boltztrap_down/boltztrap_down.trace boltztrap_down.trace
rm boltztrap_down -r
}


function check_up(){
    if [ ! -f "EIGENVAL_up" ] ; then
        vaspkit -task 731
        mkdir boltztrap_up
        mv case.intrans boltztrap_up/boltztrap_up.intrans
        mv case.energy boltztrap_up/boltztrap_up.energy
        mv case.struct boltztrap_up/boltztrap_up.struct
        cd boltztrap_up
        sed -i "8c $T1 $T2" boltztrap_up.intrans
        btp
        cd ..
        mv boltztrap_up/boltztrap_up.trace boltztrap_up.trace
        rm boltztrap_up -r
    else
        up_down
    fi
}

check_up
rm FERMI_ENERGY

