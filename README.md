# PUA_CPU_CDE_AXI

### 简介

该项目用于加速 [PUA-MIPS](https://codeup.aliyun.com/6400651ec330c57286aab37f/PUA-MIPS) 的开发进程。

#### 使用方法

首先，在linux环境下克隆仓库

```bash
cd ~
git clone https://codeup.aliyun.com/6400651ec330c57286aab37f/PUA-MIPS-TEST.git
```

将你的Windows环境中的PUA-MIPS文件夹作为共享文件夹

如果你使用的是Vmware，此时你可以在 `/mnt/hgfs` 目录中找到 `PUA-MIPS` 文件夹

在命令窗口输入

```bash
cd ~/PUA-MIPS-TEST/PUA_CPU_CDE_AXI/verilator/axi
make
```

此时，当前路径下应该出现了 `obj_dir` 文件夹

输入以下指令即可运行func_test

```bash
./obj_dir/Vmycpu_top -func
```
