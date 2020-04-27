
function runvasp(){
cp ~/renjunsong/tools/host $(pwd)
mpirun -np 20 -hostfile host  vasp_std
}

function check(){
if [ ! -f "OUTCAR" ] ;then
echo "$(pwd) error_no_OUTCAR" > ~/renjunsong/tools/errorinfo
exit
fi
tail "OUTCAR" > "OUTINFO"
outcheck=$(grep "Voluntary context switches:" OUTINFO) 
rm OUTINFO
if [ -z "$outcheck" ]
then
echo "$(pwd) error" > ~/renjunsong/tools/errorinfo
exit
fi
}


function s5.relax(){
cp 1 5.relax -r
cd 5.relax
runvasp
check
cd ..
}

function s5.static.opt(){
bash ~/renjunsong/tools/static_opt
cd 5.static
runvasp
check
cd ..
}

function s5.static(){
bash ~/renjunsong/tools/static
cd 5.static
runvasp
check
cd ..
}

function s7(){
bash ~/renjunsong/tools/chg
cd 7.chg
runvasp
check
cd ..
}

function s8(){
bash ~/renjunsong/tools/band
cd 8.band
runvasp
check
python ~/renjunsong/tools/bandscript.py
cd ..
}


function s9(){
bash ~/renjunsong/tools/dos
cd 9.dos
runvasp
check
python ~/renjunsong/tools/dosscript.py
cd ..
}

function s10(){
bash ~/renjunsong/tools/optics
cd 10.optics
runvasp
check
python ~/renjunsong/tools/optscript.py
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

##choose
loop
