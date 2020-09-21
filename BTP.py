with open('EIGENVAL', 'r') as f:
	lines = f.readlines()
	linesup = list(lines)  ## spin up for BoltzTraP
	linesdown = list(lines)  ## spin down for BoltzTraP
	k = int(lines[5].split()[1])   ## this is k number
	bars = int(lines[5].split()[2])  ## this is count of k 
	for i in range(k):
		for j in range(bars):
			temp = lines[8+(bars+2)*i+j].split()
			linesup[8+(bars+2)*i+j] = "  " + temp[0] + "  " + temp[1] + "  " + temp[3] + '\n'
			linesdown[8+(bars+2)*i+j] = "  " + temp[0] + "  " + temp[2] + "  " + temp[4] + '\n'
with open('EIGENVAL_up', 'w') as f:
	f.writelines(linesup)
with open('EIGENVAL_down', 'w') as f:
	f.writelines(linesdown)


