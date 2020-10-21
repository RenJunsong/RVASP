# 使用说明
## 介绍
本系列脚本是VASP计算服务器处理及提交脚本，由于文件使用了绝对位置，所以需要将此目录文件移动到特殊位置：

`~/renjunsong/tools/`

其中`~`为$HOME

提交脚本只需要在所计算的任务文件夹即可。脚本会自动查找文件夹，然后进入文件夹中依次计算，但是若文件夹名字以`no`开头则会跳过不做计算

### 参数设置
在计算DOS时, 自动添加的`NEDOS=1000`; 在计算光学时，自动添加的`NEDOS=2000`, 在处理光学数据时，默认处理(001)面。如果需要修改，可以去相应的文件(dos, dosscript.py, optics, optscript.py)中修改

## 深圳超算(已修改为和MGI同样的使用方法)
深圳超算默认提交脚本为`sz_vasp_yw.lsf`, 使用方法同MGI

## MGI

### 初始化
将所有脚本移入`~/renjunsong/tools`并进入,运行`bash initial.sh`,此脚本目的是为了生成需要的别名alias,包括rpotcat, rcopy, rtotal, rbtp and rmgi。可以通过`alias`查看。
### 提交脚本
在需要计算的文件夹中输入`rmgi <-c> <-m> num1 num2`即可开始提交并计算，其中num1表示需要计算的步骤的代号乘积，对应为2:优化,3:静态,5:chg,7:band,11:dos,13:optics。num2表示功能的代号乘积，对应为2:静态是否保留WAVECAR,3:chg计算的时候计算`chg_ELF`,5:待定, 7：金属物质(vasp的band自动判断)的光学计算

-c: 表示选择choose，如`rmgi -c 6 2 pure1 pure2 pure3`表示计算pure1 pure2 pure3文件夹中的优化和静态并保留WAVECAR

-m: 表示单个文件夹的计算，此命令需要进入对应的文件夹，然后`rmgi -m 78 14`表示`(78=2*3*13, 14=2*7)`优化，静态并计算金属的光学

`rmgi 6 2`表示目录下所有(除了no开头)文件夹的优化和静态并保留WAVECAR 

### 复制
`rcopy num1`可以复制出需要的文件，其中num1对应的功能和cmgi中相同,生成no开头的一个文件夹，此文件夹中删除了CHAGER，WAVECAR等大文件和无用文件，方便复制到本地

### boltztrap计算
在计算好的DOS中，键入rbtp即可自动运行
