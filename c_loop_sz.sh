#!/bin/bash
#To change the ##LLLL## for loop_sz.lsf file

if [ -z "$1" ]; then
echo "Error, usege: bash ~/renjunsong/tools/c_loop_sz.sh <-c> <-m> [temp1] [temp2]"
echo "Please read the README (~/renjunsong/tools) carefully"
exit 0
fi

if [[ $1 != "-c" ]] && [[ $1 != "-m" ]]; then
if [ "$1" -gt 0 ] 2>/dev/null ;then 
    echo "Submitting"
else 
echo "Parameter input error, usege: bash ~/renjunsong/tools/c_loop_sz.sh <-c> <-m> [temp1] [temp2]"
echo "Please read the README (~/renjunsong/tools) carefully"
exit 0
fi
fi

let tmp=1+`grep -n "LLLL" ~/renjunsong/tools/loop_sz.lsf |cut -f1 -d:`

if [ $1 = "-m" ]; then
sed -i "${tmp}c main $2 $3" ~/renjunsong/tools/loop_sz.lsf
elif [ $1 = "-c" ]; then
sed -i "${tmp}c choose $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} ${28} ${29} ${30} ${31} ${32} ${33} ${34} ${35} ${36} ${37} ${38} ${39} ${40} ${41} ${42} ${43}" ~/renjunsong/tools/loop_sz.lsf
else
sed -i "${tmp}c loop $1 $2" ~/renjunsong/tools/loop_sz.lsf
fi



bsub ~/renjunsong/tools/loop_sz.lsf
