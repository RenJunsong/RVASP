with open('OUTCAR', 'r') as f:
	## Modify the parameters if necessary ##
	NEDOS = 2000;	##NEDOS flag in file INCAR
	direction = 3;   ## optical direction, 1 for (100), 2 for (010), 3 for (001)
	## ##
	lines = f.readlines();
	imgmin = 3 + lines.index('  frequency dependent IMAGINARY DIELECTRIC FUNCTION (independent particle, no local field effects) density-density\n');
	realmin = 3 + lines.index('  frequency dependent      REAL DIELECTRIC FUNCTION (independent particle, no local field effects) density-density\n');
	dataEn = [0 for col in range(NEDOS)]   ## data for Energy
	imgdataOpt = [0 for col in range(NEDOS)] ## data for img	
	realdataOpt = [0 for col in range(NEDOS)] ## data for real
	refdataOpt = [0 for col in range(NEDOS)] ## data for Reflectivity
	absdataOpt = [0 for col in range(NEDOS)] ## data for Absorption rate
	for i in range(NEDOS):
		dataEn[i] = float(lines[imgmin + i].split()[0]);
		imgdataOpt[i] = float(lines[imgmin + i].split()[direction]);
		realdataOpt[i] = float(lines[realmin + i].split()[direction]);
		absdataOpt[i] = 2**0.5 * dataEn[i] * ((realdataOpt[i]**2 + imgdataOpt[i]**2)**0.5 - realdataOpt[i])**0.5;
		reftemp = complex(realdataOpt[i],imgdataOpt[i]);   ##create a temp complex number
		refdataOpt[i] = abs((reftemp**0.5-1)/(reftemp**0.5+1))**2;
	with open('optdata.csv', 'w') as f:
		for i in range(NEDOS):
			f.write(str(dataEn[i]))
			f.write(','+str(imgdataOpt[i]))
			f.write(','+str(realdataOpt[i]))
			f.write(','+str(refdataOpt[i]))
			f.write(','+str(absdataOpt[i]))
			f.write('\n')

