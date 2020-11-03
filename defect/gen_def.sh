#!/bin/bash
## Finction:To automatically generate defects

# To add parameters from config.txt
name_A=`grep "AAAA" config.txt | awk '{print \$2}'`
name_B=`grep "BBBB" config.txt | awk '{print \$2}'`
name_O=`grep "OOOO" config.txt | awk '{print \$2}'`
num_A=`grep "AAAA" config.txt | awk '{print \$3}'`
num_B=`grep "BBBB" config.txt | awk '{print \$3}'`
num_O=`grep "OOOO" config.txt | awk '{print \$3}'`
val_A=`grep "AAAA" config.txt | awk '{print \$4}'`
val_B=`grep "BBBB" config.txt | awk '{print \$4}'`
val_O=`grep "OOOO" config.txt | awk '{print \$4}'`
ele_A=`grep "AAAA" config.txt | awk '{print \$5}'`
ele_B=`grep "BBBB" config.txt | awk '{print \$5}'`
ele_O=`grep "OOOO" config.txt | awk '{print \$5}'`
ISPIN=`grep "PPPP" config.txt | awk '{print \$2}'`
let tmp=1+`grep -n "MNNM" config.txt |cut -f1 -d:`
nor_M=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "MRRM" config.txt |cut -f1 -d:`
rep_M=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "CCAI" config.txt |cut -f1 -d:`
c_Ai=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "CCBI" config.txt |cut -f1 -d:`
c_Bi=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "CCOI" config.txt |cut -f1 -d:`
c_Oi=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "RRVA" config.txt |cut -f1 -d:`
r_VA=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "RRVB" config.txt |cut -f1 -d:`
r_VB=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "RRVO" config.txt |cut -f1 -d:`
r_VO=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "RRAB" config.txt |cut -f1 -d:`
r_AB=`sed -n "${tmp}p" config.txt`
let tmp=1+`grep -n "RRBA" config.txt |cut -f1 -d:`
r_BA=`sed -n "${tmp}p" config.txt`
r_nele=`grep -n "NELECT" nopure/1/INCAR |cut -f1 -d:`
if [ -z $r_nele ]; then
    r_nele=10
    sed -i "${r_nele}i \#NELECT = " nopure/1/INCAR
fi
r_mag=`grep -n "MAGMOM" nopure/1/INCAR |cut -f1 -d:`
if [ -z $r_mag ]; then
    r_mag=34
    sed -i "${r_mag}i \#MAGMOM = " nopure/1/INCAR
fi
let total_Nelect=num_A*ele_A+num_B*ele_B+num_O*ele_O

function makedir(){
mkdir ${name_A}i ${name_B}i ${name_O}i
mkdir V${name_A} V${name_B} V${name_O}
mkdir ${name_A}${name_B} ${name_B}${name_A}
}

function gen_i(){
#For Ai
mkdir ${name_A}i/1
cp nopure/1/INCAR nopure/5.static/CONTCAR nopure/1/POTCAR nopure/1/KPOINTS ${name_A}i/1
cd ${name_A}i/1/
mv CONTCAR POSCAR
sed -i 's/ISIF = 3/ISIF = 2/g' INCAR
let temp_A=num_A+1
let temp_B=num_B
let temp_O=num_O
let temp=total_Nelect+ele_A-val_A
sed -i "${r_nele}c NELECT = ${temp}" INCAR
if [ $ISPIN = '2' ]; then
    sed -i "${r_mag}c MAGMOM = ${temp_A}*0 $nor_M ${temp_O}*0" INCAR
fi
let temp=8+num_A
sed -i "${temp}a   ${c_Ai}" POSCAR
sed -i "7c   ${temp_A} ${temp_B} ${temp_O}" POSCAR
cd ../..

#For Bi
mkdir ${name_B}i/1
cp nopure/1/INCAR nopure/5.static/CONTCAR nopure/1/POTCAR nopure/1/KPOINTS ${name_B}i/1
cd ${name_B}i/1/
mv CONTCAR POSCAR
sed -i 's/ISIF = 3/ISIF = 2/g' INCAR
let temp_A=num_A
let temp_B=num_B+1
let temp_O=num_O
let temp=total_Nelect+ele_B-val_B
sed -i "${r_nele}c NELECT = ${temp}" INCAR
if [ $ISPIN = '2' ]; then
    sed -i "${r_mag}c MAGMOM = ${temp_A}*0 $nor_M 0 ${temp_O}*0" INCAR
fi
let temp=8+num_A+num_B
sed -i "${temp}a   ${c_Bi}" POSCAR
sed -i "7c   ${temp_A} ${temp_B} ${temp_O}" POSCAR
cd ../..

#For Oi
mkdir ${name_O}i/1
cp nopure/1/INCAR nopure/5.static/CONTCAR nopure/1/POTCAR nopure/1/KPOINTS ${name_O}i/1
cd ${name_O}i/1/
mv CONTCAR POSCAR
sed -i 's/ISIF = 3/ISIF = 2/g' INCAR
let temp_A=num_A
let temp_B=num_B
let temp_O=num_O+1
let temp=total_Nelect+ele_O-val_O
sed -i "${r_nele}c NELECT = ${temp}" INCAR
if [ $ISPIN = '2' ]; then
    sed -i "${r_mag}c MAGMOM = ${temp_A}*0 $nor_M ${temp_O}*0" INCAR
fi
let temp=8+num_A+num_B+num_O
sed -i "${temp}a   ${c_Oi}" POSCAR
sed -i "7c   ${temp_A} ${temp_B} ${temp_O}" POSCAR
cd ../..
}

function gen_v(){
#For VA
mkdir V${name_A}/1
cp nopure/1/INCAR nopure/5.static/CONTCAR nopure/1/POTCAR nopure/1/KPOINTS V${name_A}/1
cd V${name_A}/1/
mv CONTCAR POSCAR
sed -i 's/ISIF = 3/ISIF = 2/g' INCAR
let temp_A=num_A-1
let temp_B=num_B
let temp_O=num_O
let temp=total_Nelect-ele_A+val_A
sed -i "${r_nele}c NELECT = ${temp}" INCAR
if [ $ISPIN = '2' ]; then
    sed -i "${r_mag}c MAGMOM = ${temp_A}*0 $nor_M ${temp_O}*0" INCAR
fi
sed -i "${r_VA}d" POSCAR
sed -i "7c   ${temp_A} ${temp_B} ${temp_O}" POSCAR
cd ../..

#For VB
mkdir V${name_B}/1
cp nopure/1/INCAR nopure/5.static/CONTCAR nopure/1/POTCAR nopure/1/KPOINTS V${name_B}/1
cd V${name_B}/1/
mv CONTCAR POSCAR
sed -i 's/ISIF = 3/ISIF = 2/g' INCAR
let temp_A=num_A
let temp_B=num_B-1
let temp_O=num_O
let temp=total_Nelect-ele_B+val_B
sed -i "${r_nele}c NELECT = ${temp}" INCAR
if [ $ISPIN = '2' ]; then
    sed -i "${r_mag}c MAGMOM = ${temp_A}*0 ${rep_M} ${temp_O}*0" INCAR
fi
sed -i "${r_VB}d" POSCAR
sed -i "7c   ${temp_A} ${temp_B} ${temp_O}" POSCAR
cd ../..

#For VO
mkdir V${name_O}/1
cp nopure/1/INCAR nopure/5.static/CONTCAR nopure/1/POTCAR nopure/1/KPOINTS V${name_O}/1
cd V${name_O}/1/
mv CONTCAR POSCAR
sed -i 's/ISIF = 3/ISIF = 2/g' INCAR
let temp_A=num_A
let temp_B=num_B
let temp_O=num_O-1
let temp=total_Nelect-ele_O+val_O
sed -i "${r_nele}c NELECT = ${temp}" INCAR
if [ $ISPIN = '2' ]; then
    sed -i "${r_mag}c MAGMOM = ${temp_A}*0 $nor_M ${temp_O}*0" INCAR
fi
sed -i "${r_VO}d" POSCAR
sed -i "7c   ${temp_A} ${temp_B} ${temp_O}" POSCAR
cd ../..
}

function gen_ABBA(){
#For AB
mkdir ${name_A}${name_B}/1
cp nopure/1/INCAR nopure/5.static/CONTCAR nopure/1/POTCAR nopure/1/KPOINTS ${name_A}${name_B}/1
cd ${name_A}${name_B}/1/
mv CONTCAR POSCAR
sed -i 's/ISIF = 3/ISIF = 2/g' INCAR
let temp_A=num_A+1
let temp_B=num_B-1
let temp_O=num_O
let temp=total_Nelect+ele_A-ele_B-val_A+val_B
sed -i "${r_nele}c NELECT = ${temp}" INCAR
if [ $ISPIN = '2' ]; then
    sed -i "${r_mag}c MAGMOM = ${temp_A}*0 $rep_M ${temp_O}*0" INCAR
fi
temp=`sed -n "${r_AB}p" POSCAR`
sed -i "${r_AB}d" POSCAR
let temp1=8+num_A
sed -i "${temp1}a ${temp}" POSCAR
sed -i "7c ${temp_A} ${temp_B} ${temp_O}" POSCAR
cd ../..

#For BA
mkdir ${name_B}${name_A}/1
cp nopure/1/INCAR nopure/5.static/CONTCAR nopure/1/POTCAR nopure/1/KPOINTS ${name_B}${name_A}/1
cd ${name_B}${name_A}/1/
mv CONTCAR POSCAR
sed -i 's/ISIF = 3/ISIF = 2/g' INCAR
let temp_A=num_A-1
let temp_B=num_B+1
let temp_O=num_O
let temp=total_Nelect-ele_A+ele_B+val_A-val_B
sed -i "${r_nele}c NELECT = ${temp}" INCAR
if [ $ISPIN = '2' ]; then
    sed -i "${r_mag}c MAGMOM = ${temp_A}*0 $nor_M 0 ${temp_O}*0" INCAR
fi
temp=`sed -n "${r_BA}p" POSCAR`
sed -i "${r_BA}d" POSCAR
let temp1=7+num_A+num_B
sed -i "${temp1}a ${temp}" POSCAR
sed -i "7c ${temp_A} ${temp_B} ${temp_O}" POSCAR
cd ../..
}

function makedirtemp(){
mkdir ${name_A}i ${name_B}i ${name_O}i
}
makedir
##makedirtemp
gen_i
gen_v
gen_ABBA
