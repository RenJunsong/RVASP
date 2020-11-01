#!/bin/bash

if [ -z "$1" ]; then
echo "error in par"
exit 0
fi
mkdir nofolder4copying
folderaddress="$(pwd)/nofolder4copying"

function copy1(){
cp 1 $folderaddress/$1 -r
}

function copy5.relax(){
mkdir $folderaddress/$1/5.relax
copybased 5.relax $1
rm $folderaddress/$1/5.relax/OUTCAR
}

function copy5.static(){
mkdir $folderaddress/$1/5.static
copybased 5.static $1
}

function copy7(){
mkdir $folderaddress/$1/7.chg
copybased 7.chg $1
cp 7.chg/CHGCAR  $folderaddress/$1/7.chg
}

function copy8(){
mkdir $folderaddress/$1/8.band
copybased 8.band $1
cp 8.band/EIGENVAL  $folderaddress/$1/8.band
cp 8.band/band.csv $folderaddress/$1/8.band
cp 8.band/banddown.csv  $folderaddress/$1/8.band
}

function copy9(){
mkdir $folderaddress/$1/9.dos
copybased 9.dos $1
cp 9.dos/DOSCAR  $folderaddress/$1/9.dos
cp 9.dos/pdos.csv $folderaddress/$1/9.dos
cp 9.dos/EIGENVAL $folderaddress/$1/9.dos
}

function copy10(){
mkdir $folderaddress/$i/10.optics
copybased 10.optics $1
cp 10.optics/optdata.csv $folderaddress/$1/10.optics
}

function copybased(){
cp $1/OUTCAR $folderaddress/$2/$1
cp $1/CONTCAR $folderaddress/$2/$1
cp $1/INCAR $folderaddress/$2/$1
cp $1/POSCAR $folderaddress/$2/$1
cp $1/KPOINTS $folderaddress/$2/$1
cp $1/OSZICAR $folderaddress/$2/$1
}


function main(){
t=$2
copy1 $1
if [ $(($t % 2)) == 0 ]; then
copy5.relax $1
fi
if [ $(($t % 3)) == 0 ]; then
copy5.static $1
fi
if [ $(($t % 5)) == 0 ]; then
copy7 $1
fi
if [ $(($t % 7)) == 0 ]; then
copy8 $1
fi
if [ $(($t % 11)) == 0 ]; then
copy9 $1
fi
if [ $(($t % 13)) == 0 ]; then
copy10 $1
fi
}

function loop(){
for i in $(ls -d */)
do
if [[ $i == no* ]] ; then
continue
fi
mkdir $folderaddress/$i
cd $i
main $i $1
cd ..
done
}


loop $1
