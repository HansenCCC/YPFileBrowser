# KKFileBrowser

[![Build Status](https://img.shields.io/badge/Github-QMKKXProduct-brightgreen.svg)](https://github.com/HansenCCC/KKFileBrowser)
[![Build Status](https://img.shields.io/badge/platform-ios-orange.svg)](https://github.com/HansenCCC/KKFileBrowser)
[![Build Status](https://img.shields.io/badge/HansenCCC-Github-blue.svg)](https://github.com/HansenCCC)
[![Build Status](https://img.shields.io/badge/HansenCCC-知乎-lightgrey.svg)](https://www.zhihu.com/people/EngCCC)
[![Build Status](https://img.shields.io/badge/已上架AppStore-Apple-success.svg)](https://apps.apple.com/cn/app/ios%E5%AE%9E%E9%AA%8C%E5%AE%A4/id1568656582)

### 这是一个非常实用的文件浏览工具。
KKFileBrowser工具常用于开发调试，可以帮我们开发者快速导出APP项目文件。也可以快速预览文件内容，支持的格式有音视频、word文档、PPT、图像等。基于FMDB，我在里面加了快速预览数据库的功能，可以直接把表单呈现出来，对数据进行修改删除操作。

### 效果
<img src="https://pic4.zhimg.com/80/v2-580b80d35ca2cd21586c18eb448e811b.jpg">

------------

### 依赖
KKFileBrowser依赖FMDB、MJExtension。

### 如何使用
1、首先Podfile导入
```
#建议在使用的时候指定版本号
pod 'KKFileBrowser', '~> 1.0.5'
```
2、工程使用
```objective-c
//首先导入头文件 #import <KKFileBrowser/KKFileBrowser.h>
//paths可以自定义文件夹路径，可以快捷跳转。
KKFileDirectoryViewController *vc = [[KKFileDirectoryViewController alloc] initWithPaths:@[]];
[self.navigationController pushViewController:vc animated:YES];
```


***

### 可支持一下格式

|支持QuickLook格式|后缀名字|
|--|--|
|文件 文档|txt、doc、xls、ppt、docx、xlsx、pptx|
|图像|jpg、png、pdf、tiff、swf|
|视频+音频|flv、rmvb、mp4、mvb、mp3、wma|
|work文档|work|
|微软office|work|
|RTF格式|rtf|
|PDF格式|pdf|
|文本文件|txt|
|数据库预览|db、sqlite|


----------

# 我
#### Created by 程恒盛 on 2019/10/24.
#### Copyright © 2019 力王. All rights reserved.
#### QQ:2534550460@qq.com  GitHub:https://github.com/HansenCCC  tel:13767141841
#### copy请标明出处，感谢，谢谢阅读

----------

#### 你还对这些感兴趣吗

1、[iOS实现HTML H5秒开、拦截请求替换资源、优化HTML加载速度][1]

2、[超级签名中最重要的一步：跳过双重认证，自动化脚本添加udid并下载描述文件（证书和bundleid不存在时，会自动创建）][2]

3、[脚本自动化批量修改ipa的icon、启动图、APP名称等(demo只修改icon，其他原理一样)、重签ipa][3]

4、[QMKKXProduct iOS技术分享][4]

5、[KKFileBrowser 快速预览本地文件（可以查看数据库）][5]


  [1]: https://github.com/HansenCCC/KKQuickDraw
  [2]: https://github.com/HansenCCC/HSAddUdids
  [3]: https://github.com/HansenCCC/HSIPAReplaceIcon
  [4]: https://github.com/HansenCCC/QMKKXProduct
  [5]: https://github.com/HansenCCC/KKFileBrowser
