#!/bin/bash
# To auto-run boltztrap
python ~/renjunsong/tools/EIGENVAL_up_down.py
function btp(){
    ~/soft/boltztrap-1.2.5/src/x_trans BoltzTraP
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
btp
cd ..
cd boltztrap_down
btp
cd ..
}


function check_up(){
    if [ ! -f "EIGENVAL_up" ] ; then
        vaspkit -task 731
        mkdir boltztrap_up
        mv case.intrans boltztrap_up/boltztrap_up.intrans
        mv case.energy boltztrap_up/boltztrap_up.energy
        mv case.struct boltztrap_up/boltztrap_up.struct
    else
        up_down
    fi
    cd boltztrap_up
    btp
    cd ..
}

check_up
rm FERMI_ENERGY

