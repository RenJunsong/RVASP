#!/bin/bash
p=~/POTCAR/PAW_PBE
if [ $# = 1 ]; then
cat $p/$1/POTCAR > POTCAR
elif [ $# = 2 ]; then
cat $p/$1/POTCAR > POTCAR
cat $p/$2/POTCAR >> POTCAR
elif [ $# = 3 ]; then
cat $p/$1/POTCAR > POTCAR
cat $p/$2/POTCAR >> POTCAR
cat $p/$3/POTCAR >> POTCAR
elif [ $# = 4 ]; then
cat $p/$1/POTCAR > POTCAR
cat $p/$2/POTCAR >> POTCAR
cat $p/$3/POTCAR >> POTCAR
cat $p/$4/POTCAR >> POTCAR
elif [ $# = 5 ]; then
cat $p/$1/POTCAR > POTCAR
cat $p/$2/POTCAR >> POTCAR
cat $p/$3/POTCAR >> POTCAR
cat $p/$4/POTCAR >> POTCAR
cat $p/$5/POTCAR >> POTCAR
elif [ $# = 6 ]; then
cat $p/$1/POTCAR > POTCAR
cat $p/$2/POTCAR >> POTCAR
cat $p/$3/POTCAR >> POTCAR
cat $p/$4/POTCAR >> POTCAR
cat $p/$5/POTCAR >> POTCAR
cat $p/$6/POTCAR >> POTCAR
elif [ $# = 7 ]; then
cat $p/$1/POTCAR > POTCAR
cat $p/$2/POTCAR >> POTCAR
cat $p/$3/POTCAR >> POTCAR
cat $p/$4/POTCAR >> POTCAR
cat $p/$5/POTCAR >> POTCAR
cat $p/$6/POTCAR >> POTCAR
cat $p/$7/POTCAR >> POTCAR
elif [ $# = 8 ]; then
cat $p/$1/POTCAR > POTCAR
cat $p/$2/POTCAR >> POTCAR
cat $p/$3/POTCAR >> POTCAR
cat $p/$4/POTCAR >> POTCAR
cat $p/$5/POTCAR >> POTCAR
cat $p/$6/POTCAR >> POTCAR
cat $p/$7/POTCAR >> POTCAR
cat $p/$8/POTCAR >> POTCAR
fi
