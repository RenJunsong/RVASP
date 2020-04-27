#!/bin/bash
#To change the $1 $2 for loop_mgi.pbs file

if [ -z "$1" ]; then
echo "error"
exit 0
fi

sed -i "171c temp1=$1" ~/renjunsong/tools/loop_mgi.pbs
sed -i "172c temp2=$2" ~/renjunsong/tools/loop_mgi.pbs

qsub ~/renjunsong/tools/loop_mgi.pbs
