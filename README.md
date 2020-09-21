# 使用说明
## 介绍
本系列脚本是VASP计算服务器处理及提交脚本，其中`loop_mgi.pbs`为提交脚本。其他文件需要移动到特殊位置：

`~/renjunsong/tools/`

提交脚本只需要在所计算的任务文件夹即可。脚本会自动查找文件夹，然后进入文件夹中依次计算，但是若文件夹名字以`no`开头则会跳过不做计算

### 参数设置
在计算DOS时, 自动添加的`NEDOS=1000`; 在计算光学时，自动添加的`NEDOS=2000`, 在处理光学数据时，默认处理(001)面

## 深圳超算(已不可使用)
深圳超算提交脚本为`sz_vasp_yw.lsf`,循环提交和自动判断脚本为`loop_sz.sh`,将循环脚本至于任务文件夹，然后输入：
```shell
nohup bash loop_sz.sh & 
```
可将程序后台运行，自动判断是否计算完毕。在退出ssh后亦会运行，查看进程：
```shell
ps -ef
```
结束进程：
```shell
kill -9 进程ID，如
kill -9 34253
```
## MGI

### 初始化
将所以脚本移入`~/renjunsong/tools`并进入,运行`bash initial.sh`,此脚本目的是为了生成需要的别名alias,包括rpotcat, rcopy, rtotal, rbtp and rmgi。可以通过`alias`查看。
### 提交脚本
在需要计算的文件夹中输入rmgi num1 num2即可开始提交并计算，其中num1表示需要计算的步骤的代号乘积，对应为2:优化,3:静态,5:chg,7:band,11:dos,13:optics。num2表示功能的代号乘积，对应为2:静态是否保留WAVECAR,3:dos待定功能,5:光学计算时候为金属体。


如`rmgi 6 2`表示计算优化和静态并保留WAVECAR 
### 复制
`rcopy num1`可以复制出需要的文件，其中num1对应的功能和cmgi中相同
### boltztrap计算
在计算好的DOS中，键入rbtp即可自动运行
