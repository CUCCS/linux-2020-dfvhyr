# 实验目标
动手实战Systemd

# 实验环境
Ubuntu-18.04.4-server

# 实验操作
*   [Systemd命令](https://asciinema.org/a/21Ku5YksmmDfplYPXbCINzAvi)
*   [Unit相关](https://asciinema.org/a/BKVMWkF5QCO5TZhRTJyk89Mfw)
*   [Unit的配置文件](https://asciinema.org/a/vzUB6n0SrP9D0FvSGX7MqIIVc)
*   [Target](https://asciinema.org/a/UP3m6esYYVDB1dYwnSO39fwvt)
*   [日志管理](https://asciinema.org/a/AJhM1chVEgheX923TMHhnaWs3)
*   [关于服务的实战](https://asciinema.org/a/UOjNc4DYXrTE1PR21pEqXy1ML)

# 自查清单
*   如何添加一个用户并使其具备sudo执行程序的权限？
    ##### 1.  添加新用户并设置密码: adduser newuser、passwd 123456
    ##### 2.  添加权限：切换到root下，vim /etc/sudoers，在root ALL=(ALL) ALL下添加一行newusr ALL=(ALL) ALL

*   如何将一个用户添加到一个用户组？
    ##### 1.  usermod -a -G < group > < user >
    ##### 2.  addusr < user > < group >

*   如何查看当前系统的分区表和文件系统详细信息？
    ##### 1. 查看当前系统的分区表：lsblk、sudo fdisk -l、sudo sfdisk -l/dev/devicename、sudo parted /dev/devicename
    ##### 2. 查看文件系统：dumpe2fs [-h] < filename >、stat -f < filename >

*   如何实现开机自动挂载Virtualbox的共享目录分区？
    ##### 1.  先设置好共享文件夹，选择自动挂载
    ##### 2.  执行命令sudo usermod -aG vboxsf < username >

*   基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？
    #### 动态扩容（在一个物理卷、逻辑卷组、逻辑卷已创建完成，并可挂载文件系统的前提下）：
    1.  将盘符sdc初始化：pvcreate /dev/sdc
    2.  将/dev/sdc添加到VGroupzhu卷组中：vgextend   VGroupzhu /dev/sdc
    3.  扩充/dev/VGroupzhu/VGroupzhu逻辑卷1G：lvextend -L +1000M  /dev/VGroupzhu/VGroupzhu100
    4.  重定义文件系统大小：resize2fs /dev/VGroupzhu/VGroupzhu100

    #### 减容：
    1.  将容量缩减到2G：resize2fs /dev/vg1/lv1 2G
    2.  lvreduce -L 8G /dev/vg1/lv1
    3.  删除逻辑卷，卷组：lvremove /dev/vg1/lv1、vgremove /dev/vg1

*   如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络 断开时运行另一个脚本？
    *   在a.server中的Unit区块里设置：After=network.target，在b.server中设置Before=network.target，使有网时运行a，没网时运行b

*   如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？
    *   在Service区块里设置：Restart=always、RestartSec=1
