# 如何在[RIME](https://rime.im/)中使用超强音形输入法

RIME是一个通用的输入法引擎，它支持几乎所有的常见平台：
- 在Windows上是小狼毫
- 在MAC上是鼠须管
- 在Linux上是ibus-rime或者fcitx-rime
- 在手机安卓平台上是同文输入法
- 在IOS（苹果手机）上是iRIME

因为是一个通用输入法引擎，所以我们可以使用一份配置来支持所有这些引擎。

这个文档就是如何在RIME中支持超强音形输入法。

## 超强音形输入法
超强音形、超强二笔、超强快码都是付东升老师基于二笔输入法改进而来的输入法。它们的官方网站[在此](http://fds8866.ys168.com/)。

## 功能

【功能（重要）】：
1. i键：引导全拼或者简拼，并进行反查。超强系列遇到一个字不会读可以用先打i键代替读音，后加形打出来，或者超强两笔的用i键引导一个全拼打出这个字。
2. v键来引导部分符号的输入，所以不需要点开符号面板，比如，一个熟练的人的手里，问号键一定是按vv，两键上问号符。
3. 附带了混输方案，混输用的是拼音与两笔的最优混输方案，目的在于容错，在于使上手难度更低。并且更为优秀，词库巨大，四码成语库得到补全。更为灵活。

## 感谢
本配置主要是基于*挥泪审判者* 在同文输入法上的工作改进而成的。特此表示感谢，没有他的工作，就没有这个项目。

## 安装方法
安装步骤：
1. 安装 [東風破](https://github.com/rime/plum) 。
2. 使用 [東風破](https://github.com/rime/plum) 安装超强系列。
3. 修改Rime的配置增超强系列选项。
4. 重新部署RIME，以生效。

### 安装[東風破](https://github.com/rime/plum) 
具体安装方法见[東風破](https://github.com/rime/plum) 官方网站。

简单来说，Linux/Mac上使用下列命令安装：
```
curl -fsSL https://git.io/rime-install | bash
```

Windows上用家可以通過 小狼毫 0.11 以上「輸入法設定／獲取更多輸入方案」調用配置管理器或者[東風破](https://github.com/rime/plum) 官方网站列出的其他安装方法。

### 安装超强系列
在Linux、MAC上使用以下命令安装：
```
bash rime-install whjiang/cqeb_rime
```

其中, `bash rime-install`是[東風破](https://github.com/rime/plum) 的命令。在Windows上，请替换为相应的命令（例如：`rime-install.bat`）。`pinyin-simp`和`whjiang/zzdyx_rime`是我们要通过[東風破](https://github.com/rime/plum) 安装的两个输入法名字。

### 修改Rime的配置增加超强系列选项
然后在`~/Library/Rime`创建一个`default.custom.yaml`文件。文件内容如下：
```yaml
patch:
  schema_list:
    - {schema: cqlb} #超强二笔
    - {schema: cqlb_pinyin} #超强二笔、拼音混输
    - {schema: cqlb_express} #超强二笔、连打
    - {schema: cqlb_fluency} #超强二笔、语句流
    - {schema: cqkm} #超强快码
    - {schema: cqkm_pinyin} #超强快码、拼音混输
    - {schema: cqyx} #超强音形
    - {schema: cqyx_pinyin} #超强音形、拼音混输
```