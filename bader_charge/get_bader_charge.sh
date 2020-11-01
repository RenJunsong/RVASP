#!/bin/sh
cp $RVASP_path/bader_charge/chgsum.pl $RVASP_path/bader_charge/bader .
./chgsum.pl  AECCAR0  AECCAR1 AECCAR2
./bader CHGCAR -ref CHGCAR_sum
rm chgsum.pl bader AVF.dat  BCF.dat CHGCAR_sum
