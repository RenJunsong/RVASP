# RVASP使用说明
## 介绍
RVASP是为了将VASP计算过程中重复的操作自动化，结合了数据处理和循环提交任务，以及对常用材料计算的方法的自动化。

目前主要功能包括:

* 任务的提交和自动循环，能够在计算完某一步后自动计算下一步，这些步骤包括:优化、静态、自洽电荷，能带，态密度，光学。

* 数据处理上，可以在任务计算过程中处理，也可以单独处理，包括:bader charge，band，dos，boltztrap，optics。

* 常有计算方法:缺陷

## 首次使用

### 初始化
进入脚本目录，运行`source initial.sh`，此脚本是为了生成别名alias，包括rpotcar，rcopy，rtotal，rbtp，rmgi。可以通过alias或者`~/.bashrc`查看.

之后可以利用相应的别名来实现功能，或者使用`bash $RVASP_path/脚本名称`来使用

### 参数设置
对于计算和数据处理，有些脚本具有初始值，可以根据情况做出修改，在对应的脚本中也给出了相应的修改方法

* DOS(`calc_step/dos`)计算, 自动添加的`NEDOS=1000`;同时dos数据处理(`calc_step/dosscript.py`)，也默认使用的是`NEDOS=1000`.

* 在计算光学(`calc_step/optics`)时，自动添加的`NEDOS=2000`, 在处理光学数据(`calc_step/optscript.py`)时，默认处理(001)面.

* boltztrap的使用中(`boltztrap/autoBTP.sh`)，需要修改boltztrap软件安装位置

* POTCAR生成脚本(getPOTCAR.sh)需要修改PBE位置


## Usage

### rmgi
此命令是自动计算任务并作处理的脚本(mgi上)

在需要计算的文件夹中输入`rmgi <-c> <-m> num1 num2`即可开始提交并计算

其中num1表示需要计算的步骤的代号乘积，对应为2:优化,3:静态,5:chg,7:band,11:dos,13:optics。num2表示功能的代号乘积，对应为2:静态是否保留WAVECAR,3:chg待定,5:dos待定, 7：金属物质的光学计算(若不设则碰到金属会先用非金属的计算，再自动用金属的计算)

-c: 表示选择choose，如`rmgi -c 6 2 pure1 pure2 pure3`表示计算pure1 pure2 pure3文件夹中的优化和静态并保留WAVECAR

-m: 表示单个文件夹的计算，此命令需要进入对应的文件夹，然后`rmgi -m 78 14`表示`(78=2*3*13, 14=2*7)`优化，静态并计算金属的光学

`rmgi 6 2`表示目录下所有(除了no开头)文件夹的优化和静态并保留WAVECAR 

### 复制rcopy
`rcopy num1`可以复制出需要的文件，其中num1对应的功能和cmgi中相同,生成no开头的一个文件夹，此文件夹中删除了CHAGER，WAVECAR等大文件和无用文件，方便复制到本地

### boltztrap计算（rbtp）
在计算好的DOS中，键入`rbtp`或者`rbtp 温度1 温度2`即可自动运行

### rpotcar
`rpotcar Sm_3 Ni_pv O`会生成相应的POTCAR

### 计算方法

#### defect
参考`defect/README.md`

#### slab
参考`slab/README.md`
