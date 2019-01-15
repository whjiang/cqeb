#如何生成iFC.dict.yaml和pyHS.dict.yaml

iFC.dict.yaml是i键+拼音（或者简拼）的码表文件。
pyHS.dict.yaml是拼音混输的码表文件。
这两个文件都是从pinyin_simp.dict.yaml(RIME自带的拼音码表)中生成的。

生成命令：
```
python pinyin.py -i pinyin_simp.dict.yaml
```

运行这个命令需要安装python (Linux和MAC上缺省安装的)
