## script to calculate the PDOS for VASP, spin-up and spin-down are in the same column.
## Modify the parameters if necessary ##
NEDOS = 1000;		##NEDOS flag in file INCAR
## ##
nums = [];
fermi = 0;
LORBITNUM = 1;	
with open('POSCAR', 'r') as numfile:
	linesnum = numfile.readlines()
	nums = linesnum[6].split()  ## number of atoms for each element in file POSCAR,save as type list
	
with open('DOSCAR', 'r') as fe:
	lines = fe.readlines()
	fermi = float(lines[5].split()[3])		##fermi value
	LORBITNUM = int(lines[0].split()[2])	##NUM = 1(LORBIT = 11),NUM = 0(LORBIT =Default)
	NEDOS = int(lines[5].split()[2])
	
	if len(lines[6].split()) == 5:		##ISPIN = 2 OR 1	
		dataEnergy = [0 for col in range(NEDOS)];  ##data for Energy
		dataTotalUp = [0 for col in range(NEDOS)];	##data for TotalUp
		dataTotalDown = [0 for col in range(NEDOS)]; ##data for TotalDown
		for i in range(NEDOS):
			dataEnergy[i] = float(lines[i+6].split()[0])-fermi;
			dataTotalUp[i] = float(lines[i+6].split()[1]);
			dataTotalDown[i] =-float(lines[i+6].split()[2]);
		if LORBITNUM == 1:
			prej = len(nums);
			prek = NEDOS;
			dataPTotalUp = [[0 for col in range(prej)] for row in range(prek)]	 ##data for Total UP of each element
			dataPTotalDown = [[0 for col in range(prej)] for row in range(prek)]	##data for Total DOWN of each element
			datasUp = [[0 for col in range(prej)] for row in range(prek)]	##data for s UP of each element
			datasDown = [[0 for col in range(prej)] for row in range(prek)]
			datapUp = [[0 for col in range(prej)] for row in range(prek)]
			datapDown = [[0 for col in range(prej)] for row in range(prek)]
			datadxyzUp = [[0 for col in range(prej)] for row in range(prek)]
			datadxyzDown = [[0 for col in range(prej)] for row in range(prek)]
			datad2Up = [[0 for col in range(prej)] for row in range(prek)]
			datad2Down = [[0 for col in range(prej)] for row in range(prek)]
			calclines = NEDOS + 7
			for j in range(len(nums)):		#if have 3 elements ,j = 0 ,1 ,2
				for k in range(NEDOS):
					for i in range(int(nums[j])):
						rl = calclines + k + (NEDOS+1)*i
						datasUp[k][j] += float(lines[rl].split()[1]);
						datasDown[k][j] += -float(lines[rl].split()[2]);
						datapUp[k][j] += (float(lines[rl].split()[3]) + float(lines[rl].split()[5]) + float(lines[rl].split()[7]));
						datapDown[k][j] += (-float(lines[rl].split()[4]) - float(lines[rl].split()[6]) - float(lines[rl].split()[8]));
						datadxyzUp[k][j] += (float(lines[rl].split()[9]) + float(lines[rl].split()[11]) + float(lines[rl].split()[13]));
						datadxyzDown[k][j] += (-float(lines[rl].split()[10]) - float(lines[rl].split()[12]) - float(lines[rl].split()[14]));
						datad2Up[k][j] += (float(lines[rl].split()[15]) + float(lines[rl].split()[17]));
						datad2Down[k][j] += (-float(lines[rl].split()[16]) - float(lines[rl].split()[18]));
					dataPTotalUp[k][j] = datasUp[k][j] + datapUp[k][j] + datadxyzUp[k][j] + datad2Up[k][j];
					dataPTotalDown[k][j] = datasDown[k][j] + datapDown[k][j] + datadxyzDown[k][j] + datad2Down[k][j];
				calclines += int(nums[j])*(NEDOS+1);
			with open('pdos.csv', 'w') as f:
				for i in range(NEDOS):
					f.write(str(dataEnergy[i]))
					f.write(','+str(dataTotalUp[i]))
					for j in range(len(nums)):
						f.write(','+str(dataPTotalUp[i][j]))
						f.write(','+str(datasUp[i][j]))
						f.write(','+str(datapUp[i][j]))
						f.write(','+str(datadxyzUp[i][j]))
						f.write(','+str(datad2Up[i][j]))
					f.write('\n')
				f.write('\n')	
				for i in range(NEDOS):
					f.write(str(dataEnergy[i]))
					f.write(','+str(dataTotalDown[i]))
					for j in range(len(nums)):
						f.write(','+str(dataPTotalDown[i][j]))
						f.write(','+str(datasDown[i][j]))
						f.write(','+str(datapDown[i][j]))
						f.write(','+str(datadxyzDown[i][j]))
						f.write(','+str(datad2Down[i][j]))
					f.write('\n')
					
		else:
			with open('dos.csv', 'w') as f:
				for i in range(NEDOS):
					f.write(str(dataEnergy[i]))
					f.write(','+str(dataTotalUp[i]))
					f.write('\n')
				f.write('\n')	
				for i in range(NEDOS):
					f.write(str(dataEnergy[i]))
					f.write(','+str(dataTotalDown[i]))
					f.write('\n')
	else:
		dataEnergy = [0 for col in range(NEDOS)];  ##data for Energy
		dataTotal = [0 for col in range(NEDOS)];	##data for Total
		for i in range(NEDOS):
			dataEnergy[i] = float(lines[i+6].split()[0])-fermi;
			dataTotal[i] = float(lines[i+6].split()[1]);
		if LORBITNUM == 1:
			prej = len(nums);
			prek = NEDOS;
			dataPTotal = [[0 for col in range(prej)] for row in range(prek)]	 ##data for Total of each element
			datas = [[0 for col in range(prej)] for row in range(prek)]	##data for s UP of each element
			datap = [[0 for col in range(prej)] for row in range(prek)]
			datadxyz = [[0 for col in range(prej)] for row in range(prek)]
			datad2 = [[0 for col in range(prej)] for row in range(prek)]
			calclines = NEDOS + 7
			for j in range(len(nums)):		#if have 3 elements ,j = 0 ,1 ,2
				for k in range(NEDOS):
					for i in range(int(nums[j])):
						rl = calclines + k + (NEDOS+1)*i
						datas[k][j] += float(lines[rl].split()[1]);
						datap[k][j] += (float(lines[rl].split()[2]) + float(lines[rl].split()[3]) + float(lines[rl].split()[4]));
						datadxyz[k][j] += (float(lines[rl].split()[5]) + float(lines[rl].split()[6]) + float(lines[rl].split()[7]));
						datad2[k][j] += (-float(lines[rl].split()[8]) - float(lines[rl].split()[9]));
					dataPTotal[k][j] = datas[k][j] + datap[k][j] + datadxyz[k][j] + datad2[k][j];
				calclines += int(nums[j])*(NEDOS+1);
			with open('pdos.csv', 'w') as f:
				for i in range(NEDOS):
					f.write(str(dataEnergy[i]))
					f.write(','+str(dataTotal[i]))
					for j in range(len(nums)):
						f.write(','+str(dataPTotal[i][j]))					
					#'''
						f.write(','+str(datas[i][j]))
						f.write(','+str(datap[i][j]))
						f.write(','+str(datadxyz[i][j]))
						f.write(','+str(datad2[i][j]))
					#'''
					f.write('\n')	
		else:
			with open('dos.csv', 'w') as f:
				for i in range(NEDOS):
					f.write(str(dataEnergy[i]))
					f.write(','+str(dataTotal[i]))
					f.write('\n')

					
