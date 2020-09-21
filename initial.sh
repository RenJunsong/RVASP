#/bin/bash
#To add the alias to .bashrc, including rpotcar, rtotal, rcopy and rmgi.
if [ "$(tail -n 1 ~/.bashrc | grep renjunsong)" == "" ]; then
cat >> ~/.bashrc <<!
alias rbtp='bash ~/renjunsong/tools/autoBTP.sh'
alias rpotcar='bash ~/renjunsong/tools/getPOTCAR.sh'
alias rtotal='bash ~/renjunsong/tools/getTOTEN.sh'
alias rcopy='bash ~/renjunsong/tools/copytool.sh'
alias rmgi='bash ~/renjunsong/tools/c_loop_mgi.sh'
alias rsz='bash ~/renjunsong/tools/c_loop_sz.sh'
!
source ~/.bashrc
fi
