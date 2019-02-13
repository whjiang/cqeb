# 如何在[RIME](https://rime.im/)中使用哲哲豆音形输入法

RIME是一个通用的输入法引擎，它支持几乎所有的常见平台：
- 在Windows上是小狼毫
- 在MAC上是鼠须管
- 在Linux上是ibus-rime或者fcitx-rime
- 在手机安卓平台上是同文输入法
- 在IOS（苹果手机）上是iRIME

因为是一个通用输入法引擎，所以我们可以使用一份配置来支持所有这些引擎。

这个文档就是如何在RIME中支持哲哲豆音形输入法。

### 自定义方法
自造词可以放在`zzdyx_userdict.txt`中。

如果想关闭拼音混输，那么在对应的schema.yaml文件里（哲哲豆圆满版是`zzdyx_perfect.schema.yaml`，哲哲豆快版是`zzdyx_mofast.schema.yaml`），把下面一段代码前加`#`注释掉就好。
```
abc_segmentor:
  extra_tags:
    - reverse_lookup
```

## 安装方法
本输入法的编码反查和拼音混输功能依赖于

 - [袖珍简化字拼音](https://github.com/rime/rime-pinyin-simp) **`pinyin-simp`**

所以需要先用[東風破](https://github.com/rime/plum) 安装 [袖珍简化字拼音](https://github.com/rime/rime-pinyin-simp) 。安裝命令： 
```
bash rime-install pinyin-simp
```

其实也就是把`pinyin_simp.schema.yaml`和`pinyin_simp.dict.yaml`两个文件从[GitHub](https://github.com/rime/rime-pinyin-simp)拷贝到了Rime的安装目录下。用户也可以自己把这两个文件下载后使用下面的安装方法copy到对应的目录即可。


### 
把本目录下的所有文件拷贝到Rime的用户目录。在MAC下是`~/Library/Rime`。

然后在`~/Library/Rime`创建一个`default.custom.yaml`文件。文件内容如下：
```yaml
patch:
  schema_list:
    - {schema: zzdyx_perfect} #哲哲豆音形圆满版
    - {schema: zzdyx_mofast}  #哲哲豆音形快版
```

然后，在RIME菜单中选择“同步用户数据”和“重新部署”。就可以使用了。


### 如何在手机（安卓/苹果）上使用
安卓上请使用同文输入法，IOS上请使用iRIME输入法。因作者只有IOS手机，所以只测试了iRIME。

因为iRIME没有编译bin文件的功能，所以必须先用上面的安装方法在电脑上安装一遍，生成出
- zzdyx*.bin
- pinyin_simp*.bin

把这些文件连同`zzdyx_perfect.schema.yaml`、`zzdyx_mofast.schema.yaml`和`pinyin_simp.schema.yaml`一起传到手机上（通过iRIME的“电脑快传”功能）。再像上面一样修改iRIME的`default.custom.yaml`就可以了。
