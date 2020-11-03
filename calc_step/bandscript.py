import os
'''
Applies to python2 and may apply to python3
When the vasp band is calculated, running this script can generate the band data file 'band.csv'. 
For systems with spin, band.csv (spin-up) and banddown.csv (spin-down) will be generated.
By: Junsong Ren
'''

fermi = 0
isspin = 0


fermi_file=os.popen("grep E-fermi OUTCAR | tail -n 1")
fermi=float(fermi_file.readlines()[0].split()[2])
with open('EIGENVAL', 'r') as f:
    lines = f.readlines()
    if len(lines[8].split())==5:
        isspin = 1
    k = int(lines[5].split()[1])
    bars = int(lines[5].split()[2])
    data = [[0 for col in range(bars)] for row in range(k)]
    for i in range(k):
        for j in range(bars):
            data[i][j] = float(lines[8+(bars+2)*i+j].split()[1])-fermi
    datadown = [[0 for col in range(bars)] for row in range(k)]
    for i in range(k):
        for j in range(bars):
            datadown[i][j] = float(lines[8+(bars+2)*i+j].split()[2])-fermi

with open('band.csv', 'w') as f:
    for i in range(k):
        f.write(str(i+1))
        for j in range(bars):
            f.write(','+str(data[i][j]))
        f.write('\n')

if isspin:
    with open('banddown.csv', 'w') as f:
        for i in range(k):
            f.write(str(i+1))
            for j in range(bars):
                f.write(','+str(datadown[i][j]))
            f.write('\n')





