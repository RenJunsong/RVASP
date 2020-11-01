#!/bin/bash

##需要两个文件，一个BoltzTraP安装包，一个Makefile，放在~/soft/文件夹下
cd ~/soft/
tar -jxvf ~/soft/BoltzTraP*
cp Makefile ~/soft/boltztrap-1.2.5/src/Makefile_ifort
cd ~/soft/boltztrap-1.2.5/src/
make -f Makefile_ifort

echo "#######################"
echo "########  Done ########"
echo "#######################"




