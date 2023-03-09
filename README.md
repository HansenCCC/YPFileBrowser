# YPFileBrowser

[![Build Status](https://img.shields.io/badge/Github-QMKKXProduct-brightgreen.svg)](https://github.com/HansenCCC/YPFileBrowser)
[![Build Status](https://img.shields.io/badge/platform-ios-orange.svg)](https://github.com/HansenCCC/YPFileBrowser)
[![Build Status](https://img.shields.io/badge/HansenCCC-Github-blue.svg)](https://github.com/HansenCCC)
[![Build Status](https://img.shields.io/badge/HansenCCC-知乎-lightgrey.svg)](https://www.zhihu.com/people/EngCCC)
[![Build Status](https://img.shields.io/badge/已上架AppStore-Apple-success.svg)](https://apps.apple.com/cn/app/ios%E5%AE%9E%E9%AA%8C%E5%AE%A4/id1568656582)

可以帮助开发人员快速导出和预览应用程序中的各种文件类型。该库支持多种常见的文件格式，包括音频、视频、Word文档、PPT、图像等。

<br/>

### 效果

![效果.png](https://picx.zhimg.com/80/v2-009acf5105b6cefa651a416b4c39d4fa_1440w.png)

<br/>

### 特性

- 文件导出：可以将应用程序中的文件导出到本地文件系统中，方便开发人员进行调试和分析。
- 文件预览：可以在应用程序内直接预览文件内容，而无需使用其他应用程序打开。
- 支持多种文件格式：YPFileBrowser 支持多种常见的文件格式，包括但不限于音频、视频、Word文档、PPT、图像等。
- 显示文件信息：YPFileBrowser 可以显示文件的详细信息，如文件大小、创建日期、最后修改日期等。
- 自定义界面：YPFileBrowser 可以根据开发人员的需求进行自定义界面配置。

<br/>

### 安装

可以通过CocoaPods来安装YPFileBrowser。在你的Podfile中加入：

```ruby
pod 'YPFileBrowser'
```

<br/>

### 快速使用

YPFileBrowser非常易于使用，只需要进行一些基本的配置即可。以下是一个简单的示例：

```objectivec
#import <YPFileBrowser/YPFileBrowser.h>

- (void)showFileBrowserAction:(UIButton *)sender {
    // 创建YPFileBrowser对象
    YPFileBrowser *fileBrowser = [[YPFileBrowser alloc] initWithPath:NSHomeDirectory()];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:fileBrowser];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:nav animated:YES completion:nil];
}

```

以上示例创建了一个 YPFileBrowser 对象，并将其添加到当前视图控制器中。其中 path 是需要预览的文件目录，代表着你要浏览的文件所在的路径。

<br/>

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

<br/>

### 更新日志

```
2023.03.09  2.0.0版本，删除了数据库预览功能，有点鸡肋，需要看数据可以直接导出来。修改后缀名从 KK => YP
2021.11.01  1.1.0版本，整理代码，移除不相关累赘代码
2021.10.20  1.0.8版本，update readme
2021.10.20  1.0.7版本，【不建议使用此版本】
2021.08.19  1.0.6版本，公开KKFileListViewController【不建议使用此版本】
2021.08.12  1.0.5版本，降低deployment_target版本【不建议使用此版本】
2021.08.12  1.0.4版本，tag增加，podspec编辑【不建议使用此版本】
2021.08.12  1.0.3版本，增加数据库预览功能【不建议使用此版本】
2021.08.07  1.0.2版本，podspec编写【不建议使用此版本】
2021.08.07  1.0.1版本，podspec编写【不建议使用此版本】
2021.08.07  1.0.0版本，新的版本从这里开始【不建议使用此版本】

```
