# 实验目标

掌握shell脚本编程基础

# 实验环境

Ubuntu-18.04.4-server


# 实验步骤

#### 任务一：用bash编写一个图片批处理脚本，实现以下功能：
- [x] 支持命令行参数方式使用不同功能

- [x] 支持对指定目录下所有支持格式的图片文件进行批处理指定目录进行批处理
- [x] 支持以下常见图片批处理功能的单独使用或组合使用
  - [x] 支持对jpeg格式图片进行图片质量压缩
    `bash img.sh -d picture -q 75`
  - [x] 支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
    `bash img.sh -d picture -r 60%x60%`
  - [x] 支持对图片批量添加自定义文本水印
    `bash img.sh -d picture -w "this is my watermark"`
    ![](img/watermark.jpg)
  - [x] 支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
    `bash img.sh -d picture --prefix "before"`
    ![](img/a.jpg)
    `bash img.sh -d picture --postfix "after"`
    ![](img/b.jpg)
  - [x] 支持将png/svg图片统一转换为jpg格式
    `bash img.sh -d picture -c`
    ![](img/c.jpg)
  
#### 具体代码请见：[任务一](Img.sh)

---

#### 任务二：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：

2014世界杯运动员数据

- [x] 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
- [x] 统计不同场上位置的球员数量、百分比
- [x] 名字最长的球员是谁？名字最短的球员是谁？
- [x] 年龄最大的球员是谁？年龄最小的球员是谁？

#### 统计数据请见：[任务二数据](StatisticalData1.md)
#### 具体代码请见：[任务二](statistics1.sh)

---

#### 任务三：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：

Web服务器访问日志

- [x] 统计访问来源主机TOP 100和分别对应出现的总次数
- [x] 统计访问来源主机TOP 100 IP和分别对应出现的总次数
- [x] 统计最频繁被访问的URL TOP 100
- [x] 统计不同响应状态码的出现次数和对应百分比
- [x] 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
- [x] 给定URL输出TOP 100访问来源主机

#### 统计数据请见：[任务三数据](StatisticalData2.md)
#### 具体代码请见：[任务三](statistics2.sh)

---

## 参考资料

- [【ubuntu】imagemagick用法](https://www.cnblogs.com/xweiwei/archive/2011/02/21/1959467.html)
- [师哥文档1](https://github.com/CUCCS/linux-2019-HuanWoWeiLan/blob/exp04/exp04)
- [师哥文档2](https://github.com/CUCCS/linux-2019-jackcily/blob/job4/job4)
