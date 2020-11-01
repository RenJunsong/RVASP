#!/bin/bash
#To add the alias and RVASP_path to .bashrc, including rpotcar, rtotal, rcopy and rmgi.
chmod a+x bader_charge/bader
chmod a+x bader_charge/chgsum.pl
R_path=`pwd`
if [ "$(cat $HOME/.bashrc | grep RVASP)" == "" ]; then
cat >> $HOME/.bashrc <<!
## RVASP Settings Start ##
export RVASP_path=$R_path
alias rbtp="bash \$RVASP_path/boltztrap/autoBTP.sh"
alias rpotcar="bash \$RVASP_path/getPOTCAR.sh"
alias rtotal="bash \$RVASP_path/getTOTEN.sh"
alias rcopy="bash \$RVASP_path/copytool.sh"
alias rmgi="bash \$RVASP_path/c_loop_mgi.sh"
alias rsz="bash \$RVASP_path/c_loop_sz.sh"
## RVASP Settings Done ##
!
source $HOME/.bashrc
else
    echo "RVASP has been installed, or the ~/.bashrc file has not been deleted cleanly"
fi
