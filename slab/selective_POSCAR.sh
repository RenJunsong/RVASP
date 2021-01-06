#!/bin/sh
## Function: The value greater or less than a certain z-axis is selected to relax.By Ren JS
## Usage, ./thisfile.sh or ./thisfile.sh > 0.01
## Setting ##
value='>0.24'    ##  `>0.01` is means if the z of atom >0.01, the atom will be selected to relax(add T T T),nor add F F F
file_name=POSCAR-0
dos2unix $file_name
out_file_name=POSCAR
## Done ##
head -n 7 $file_name > $out_file_name
echo -e "Selective\nDirect" >> $out_file_name
## the number of last line at POSCAR
for i in {9..168}
do
low=`sed -n ${i}p $file_name`
z=`sed -n ${i}p $file_name | awk '{print $3}'`
check_value=`echo "${z}${value}" | bc` 
if [ $check_value -eq 1 ]; then
echo $low T T T >> $out_file_name
else
echo $low F F F >> $out_file_name
fi
done
