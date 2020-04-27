#!/bin/bash

function runvasp(){
bsub sz_vasp_yw.lsf
}

function check(){
if [ ! -f "OUTCAR" ] ;then
return 0
fi
tail "OUTCAR" > "OUTINFO"
outcheck=$(grep "Voluntary context switches:" OUTINFO) 
rm OUTINFO
if [ -z "$outcheck" ]
then
return 0
fi
return 1
}

function checkdone(){
while :
do
    echo "At $(pwd),now is $(date +%X+%x),and will wait 20min"
    sleep 1200
	check
	if [ $? -eq 1 ] ; then 
		break
	fi
done
}

function s5.relax(){
cp 1 5.relax -r
cd 5.relax
cp ~/renjunsong/tools/sz_vasp_yw.lsf sz_vasp_yw.lsf
runvasp
checkdone
rm sz_vasp_yw.lsf
cd ..
}

function s5.static(){
bash ~/renjunsong/tools/static
cd 5.static
cp ~/renjunsong/tools/sz_vasp_yw.lsf sz_vasp_yw.lsf
runvasp
checkdone
rm sz_vasp_yw.lsf
cd ..
}

function s5.static.opt(){
bash ~/renjunsong/tools/static_opt
cd 5.static
cp ~/renjunsong/tools/sz_vasp_yw.lsf sz_vasp_yw.lsf
runvasp
checkdone
rm sz_vasp_yw.lsf
cd ..
}

function s7(){
bash ~/renjunsong/tools/chg
cd 7.chg
cp ~/renjunsong/tools/sz_vasp_yw.lsf sz_vasp_yw.lsf
runvasp
checkdone
rm sz_vasp_yw.lsf
cd ..
}

function s8(){
bash ~/renjunsong/tools/band
cd 8.band
cp ~/renjunsong/tools/sz_vasp_yw.lsf sz_vasp_yw.lsf
rm OUTCAR
runvasp
checkdone
python ~/renjunsong/tools/bandscript.py
rm sz_vasp_yw.lsf
cd ..
}

function s8_up_down(){
bash ~/renjunsong/tools/band
cd 8.band
cp ~/renjunsong/tools/sz_vasp_yw.lsf sz_vasp_yw.lsf
rm OUTCAR
runvasp
checkdone
python ~/renjunsong/tools/bandscript.py
python ~/renjunsong/tools/bandscriptdown.py
rm sz_vasp_yw.lsf
cd ..
}

function s9(){
bash ~/renjunsong/tools/dos
cd 9.dos
cp ~/renjunsong/tools/sz_vasp_yw.lsf sz_vasp_yw.lsf
rm OUTCAR
runvasp
checkdone
python ~/renjunsong/tools/dosscript.py
rm sz_vasp_yw.lsf
cd ..
}

function s10{
bash ~/renjunsong/tools/optics
cd 10.optics
cp ~/renjunsong/tools/sz_vasp_yw.lsf sz_vasp_yw.lsf
runvasp
checkdone
python ~/renjunsong/tools/optscript.py
rm sz_vasp_yw.lsf
cd ..
}

function main(){
s5.relax
s5.static
##s5.static.opt
s7
s8
s9
s10
}

function loop(){
for i in $(ls -d */)
do
if [[ $i == no* ]] ; then
continue
fi
cp KPOINTS_band $i/KPOINTS_band
cp KPOINTS_dos $i/KPOINTS_dos
cd $i
main
rm KPOINTS_band
rm KPOINTS_dos
cd ..
done
}

function choose(){
for i in name1 2
do
cp KPOINTS_band $i/KPOINTS_band
cp KPOINTS_dos $i/KPOINTS_dos
cd $i
main
rm KPOINTS_band
rm KPOINTS_dos
cd ..
done
}

loop
##choose
