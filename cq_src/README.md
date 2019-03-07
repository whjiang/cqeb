# 生成超强系列输入法RIME配置的工具

##有以下文件：
1. schema.mustache  (主模板文件，各个超强输入法通用，使用[mustache模板语法](https://mustache.github.io/mustache.5.html))
2. xxx.json (不同的输入法配置文件)
3. gen.py  （主程序，需要安装python）


##使用方法
1. 先要安装python (我用的是python 2.7).

2. 再安装pystache包
```
pip install pystache
```

3. 运行命令：
```
python gen.py
```
