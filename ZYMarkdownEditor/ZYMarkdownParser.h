//
//  ZYMarkdownParser.h
//  ZYMarkdownEditor <https://github.com/LZTuna/ZYMarkdownEditor>
//
//  Created by lztuna on 16/12/4.
//  Copyright (c) 2015 lztuna.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>
#import "YYTextParser.h"

@interface ZYMarkdownParser : NSObject<YYTextParser>




//Set theme is like  Atom
- (void)setColorWithAtomTheme;

@property (nonatomic, copy)NSString *textFontName;  //  default is "PingFangSC-Regular"

@property (nonatomic) CGFloat fontSize;         //  default is 26

@property (nonatomic) CGFloat headerFontSize;   //  default is 37

/*
 *  普通文本颜色
 *
 *
 *  NoramTextColor
 *
 */
@property (nullable, nonatomic, strong) UIColor *textColor;
/*
 *  符合Markdown语法规则的符号颜色
 *
 *
 *
 *
 */
@property (nullable, nonatomic, strong) UIColor *controlTextColor;
/*
 *  标题颜色
 *  语法示例： #title
 *
 *  TitleColor
 *  GrammerSimple: #title
 */
@property (nullable, nonatomic, strong) UIColor *headerTextColor;
/*
 *  超链接颜色
 *  语法示例： []()
 *
 *  LinkColor
 *  GrammerSimple: []()
 */
@property (nullable, nonatomic, strong) UIColor *linkTextColor;
/*
 *  超链接[]内文字颜色颜色
 *  语法示例： [着色文字]()
 *
 *  LinkColorIn[]
 *  GrammerSimple: [colortext]()
 */
@property (nullable, nonatomic, strong) UIColor *linkNameTextColor;
/*
 *  图片超链接颜色
 *  语法示例： ![]()
 *
 *  ImageLinkColor
 *  GrammerSimple: ![]()
 */
@property (nullable, nonatomic, strong) UIColor *imageLinkTextColor;
/*
 *  强调文本颜色
 *  语法示例： _text_
 *
 *  emphasisTextColor
 *  GrammerSimple: _text_
 */
@property (nullable, nonatomic, strong) UIColor *emphasisTextColor;
/*
 *  H1标题颜色
 *  语法示例： header\n====
 *
 *  H1 TitleColor
 *  GrammerSimple: header\n====
 */
@property (nullable, nonatomic, strong) UIColor *H1color;
/*
 *  H2标题颜色
 *  语法示例： header\n----
 *
 *  H2 TitleColor
 *  GrammerSimple: header\n----
 */
@property (nullable, nonatomic, strong) UIColor *H2Color;
/*
 *  分割线颜色
 *  语法示例： *******
 *
 *  BreakLineColor
 *  GrammerSimple: *******
 */
@property (nullable, nonatomic, strong) UIColor *breakLineColor;
/*
 *  强调文本颜色
 *  语法示例： **text**
 *
 *  StrongColor
 *  GrammerSimple: **text**
 */
@property (nullable, nonatomic, strong) UIColor *strongColor;
/*
 *  强调文本
 *  语法示例： ***text***
 *
 *  StrongEmphasisColor
 *  GrammerSimple:  ***text***
 */
@property (nullable, nonatomic, strong) UIColor *strongEmphasisColor;
/*
 *  下划线颜色
 *  语法示例： __text__
 *
 *  UnderlineColor
 *  GrammerSimple: __text__
 */
@property (nullable, nonatomic, strong) UIColor *underlineColor;
/*
 *  删除线颜色
 *  语法示例： ~~text~~
 *
 *  DeleteLineColor
 *  GrammerSimple: ~~text~~
 */
@property (nullable, nonatomic, strong) UIColor *strikeThroughColor;
/*
 *  行内代码颜色
 *  语法示例： 'code'
 *
 *  InlineCodeColor
 *  GrammerSimple: 'code'
 */
@property (nullable, nonatomic, strong) UIColor *inlineCodeColor;
/*
 *  引用式链接颜色
 *  语法示例： [ref]:
 *
 *  LinkReferenceColor
 *  GrammerSimple: [ref]:
 */
@property (nullable, nonatomic, strong) UIColor *linkReferColor;
/*
 *  引用式链接名称颜色
 *  语法示例： [着色文字]:
 *
 *  LinkReferenceColorIn[]
 *  GrammerSimple: [colortext]:
 */
@property (nullable, nonatomic, strong) UIColor *linkReferNameColor;
/*
 *  代码块颜色
 *  语法示例： \tcode \tcode or ```\n```
 *
 *  CodeBlockColor
 *  GrammerSimple: header\n====
 */
@property (nullable, nonatomic, strong) UIColor *codeBlockColor;
/*
 *  列表颜色
 *  语法示例： - 第一
 *           - 第二
 *
 *  ListColor
 *  GrammerSimple: - first
 *                 - second
 */
@property (nullable, nonatomic, strong) UIColor *listColor;
/*
 *  引用颜色
 *  语法示例： > 双城记:这是最好的时代……
 *
 *  ReferenceColor
 *  GrammerSimple: > A Tale of Two Cities : It was the best of times……
 */
@property (nullable, nonatomic, strong) UIColor *referenceColor;


@end
