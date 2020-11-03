# boltztrap instal and usage

## Instal

如果有sudo权限，安装很容易，如果没有，这里以mgi举例,参考`AutoInstallBTP.sh`

安装好后，需要修改`autoBTP.sh`中的安装目录位置



## Usage

确保文件中有DOSCAR，POSCAR，EL。。

在dos文件夹中，输入`rbtp`或者`rbtp 温度1 温度2`来运行。如果有自旋，则生成boltztrap.up和boltztrap.down两个文件，否则只有boltztrap.up一个文件
