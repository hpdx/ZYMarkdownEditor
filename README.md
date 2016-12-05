ZYMarkdownEditor
=======


Features
==============

- __Only Three Lines __
- __CodeMap__
- __CustomTheme__
- __Grammar highlight__

------
![](http://i1.piimg.com/567571/50cbaa1b515ebff1.gif)


`YYText` is a popular framework,you cloud fing it in here[YYText](https://github.com/ibireme/YYText),thanks the author of YYKit;



Usage
=======
### Basic

``` objc
//AppDelegate.h
#import "ZYMarkdownEditor.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    //Only need three lines code  
    //create a markdown parser
    ZYMarkdownParser *parser = [ZYMarkdownParser new];
    //use default theme color
    [parser setColorWithAtomTheme];
    //create editorViewController
    ZYEditorViewController *editor = [[ZYEditorViewController alloc]initWithMarkdown:nil parser:parser];
    self.window.rootViewController = editor;

    return YES;
}

```

### Customed

- Text color
- Font


__TextColor__

In `ZYMarkdownParser.h`,there are many customed text colors.__If you want to customed some color but not all, you should call method `setColorWithAtomTheme` ,then set your text  colors__.

like this :
``` objc

ZYMarkdownParser *parser = [ZYMarkdownParser new];
//set default theme color
[parser setColorWithAtomTheme];
//set your customed text color
parser.listColor = [UIColor greenColor];
parser.headerTextColor = [UIColor redColor];

```

__Font__
``` objc

ZYMarkdownParser *parser = [ZYMarkdownParser new];
//  default is "PingFangSC-Regular"
parser.textFontName = @"PingFangSC-Thin";
 //  default is 23
parser.fontSize = 20;
//  default is 30
parser.headFontSize = 40;

```

__BackgroundColor or size__

In `ZYMarkdownEditor.m` and `ZYCodeMapView.m` you could set background or size easily,yeah  it's really easy;


Installation
==============

<!-- ### CocoaPods

1. Add `pod 'ZYMarkdownEditor'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import 'ZYMarkdownEditor.h' -->

I will support CocoaPods after the collage exam.

### Manually
- Install`YYText`
  - Download all the files in the `YYText` subdirectory.
  - Add the source files to your Xcode project.
  - Link with required frameworks:
    * UIKit
    * CoreFoundation
    * CoreText
    * QuartzCore
    * Accelerate
    * MobileCoreServices
    - Import `YYText.h`.
- Install `ZYMarkdownEditor`
  - Download all the files in the `ZYMarkdownEditor` subdirectory;
  - Add the source files to your Xcode project.
  - Import `ZYMarkdownEditor.h`




Requirements
==============
This library requires `iOS 6.0+` and `Xcode 7.0+`.


License
==============
ZYMarkdownEditor is released under the MIT license. See LICENSE file for details.

#中文介绍
## 特性
- 只需三行代码就可集成
- 自带代码地图
- 自定义主题
- 语法高亮
------------
使用
=======

### 基础用法
``` objc
//AppDelegate.h
#import "ZYMarkdownEditor.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    //只需三行代码
    //初始化ZYMarkdownParser实例
    ZYMarkdownParser *parser = [ZYMarkdownParser new];
    //使用默认主题
    [parser setColorWithAtomTheme];
    //创建编辑器
    //可以选择使用markdown字符串来初始化
    ZYEditorViewController *editor = [[ZYEditorViewController alloc]initWithMarkdown:nil parser:parser];
    self.window.rootViewController = editor;

    return YES;
}

```

### 自定义

- 文字颜色
- 字体
- 更多


__文字颜色__

在 `ZYMarkdownParser.h`中,有很多颜色支持自定义.__如果你想自定义部分颜色, 你应该先调用 `setColorWithAtomTheme` 来设置默认颜色,然后设置你的自定义颜色__.

就像这样 :
``` objc

ZYMarkdownParser *parser = [ZYMarkdownParser new];
//设置默认颜色
[parser setColorWithAtomTheme];
//设置你自己的颜色
parser.listColor = [UIColor greenColor];
parser.headerTextColor = [UIColor redColor];

```

__字体__
``` objc

ZYMarkdownParser *parser = [ZYMarkdownParser new];
//  字体名默认为 "PingFangSC-Regular"
parser.textFontName = @"PingFangSC-Thin";
 //  普通文本字号默认 23
parser.fontSize = 20;
//  标题默认字号 30
parser.headFontSize = 40;

```

__背景颜色或者尺寸__

在 `ZYMarkdownEditor.m` 和 `ZYCodeMapView.m` 中，可以轻易找出自定义尺寸的地方，真的非常容易；


安装
==============

<!-- ### CocoaPods

1. Add `pod 'ZYMarkdownEditor'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import 'ZYMarkdownEditor.h' -->

考试结束后我将提供CocoaPods支持

### 手动安装
- 安装`YYText`
  - 下载 `YYText` 或者使用CocosPods导入[YYText](https://github.com/ibireme/YYText).
  - 将源文件添加到项目内.
  - 添加下列依赖库:
    * UIKit
    * CoreFoundation
    * CoreText
    * QuartzCore
    * Accelerate
    * MobileCoreServices
    - import `YYText.h`.
- 安装 `ZYMarkdownEditor`
  - 下载 `ZYMarkdownEditor` 目录下的所有文件;
  - 把源文件添加到项目内.
  - Import `ZYMarkdownEditor.h`


  License
  ==============
  ZYMarkdownEditor is released under the MIT license. See LICENSE file for details.
