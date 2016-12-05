//
//  ZYEditorViewController.h
//  ZYMarkdownEditor <https://github.com/LZTuna/ZYMarkdownEditor>
//
//  Created by lztuna on 16/12/4.
//  Copyright (c) 2015 lztuna.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>
#import "ZYMarkdownParser.h"
@interface ZYEditorViewController : UIViewController

- (instancetype)initWithMarkdown:(NSString *)markdown parser:(ZYMarkdownParser *)parser;

@property (nonatomic, readonly)NSString *markdown;

@end
