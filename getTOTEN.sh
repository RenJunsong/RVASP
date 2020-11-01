#!/bin/bash
for i in $(ls -d */)
do
if [[ $i == no* ]] ; then
continue
fi
echo -n "$i" >> TOTENfile
grep TOTEN $i/5.static/OUTCAR|tail -n 1 >> TOTENfile
done
