#!/bin/bash

cd ~/
if [ ! -d "soft/" ] ; then
    mkdir -p soft
fi
cp -a /tmp/rbtp/. soft/
cd ~/soft/
tar -jxvf ~/soft/BoltzTraP*
cp Makefile ~/soft/boltztrap-1.2.5/src/Makefile_ifort
cd ~/soft/boltztrap-1.2.5/src/
make -f Makefile_ifort
cat >> ~/.bashrc <<!
alias rbtp='~/soft/boltztrap-1.2.5/src/x_trans BoltzTraP'
!

source ~/.bashrc
echo "#######################"
echo "########  Done ########"
echo "#######################"




