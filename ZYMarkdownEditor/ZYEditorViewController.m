//
//  ZYEditorViewController.m
//  ZYMarkdownEditor <https://github.com/LZTuna/ZYMarkdownEditor>
//
//  Created by lztuna on 16/12/4.
//  Copyright (c) 2015 lztuna.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "ZYEditorViewController.h"


#import "YYTextParser.h"
#import "YYTextView.h"

#import "NSAttributedString+YYText.h"
#import <CoreGraphics/CoreGraphics.h>
#import "ZYCodeMapView.h"
#import "ZYMarkdownParser.h"
#import "UIView+ZYExtension.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define rgb(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ZYEditorViewController ()<YYTextViewDelegate,ZYCodeMapViewDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>

@property (nonatomic, strong)YYTextView *textView;
@property (nonatomic, strong)ZYCodeMapView *codeMap;
@property (nonatomic, strong)ZYMarkdownParser *parser;
@property (nonatomic, copy, readwrite)NSString *markdown;

@end

@implementation ZYEditorViewController {
    
    
    BOOL _isCodeMapScrolling;
}


- (instancetype)initWithMarkdown:(NSString *)markdown parser:(ZYMarkdownParser *)parser {
    
    self = [self init];
    self.markdown = markdown;
    self.parser = parser;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.codeMap = [[ZYCodeMapView alloc]init];
    
    self.codeMap.delegate = self;
    self.view.backgroundColor = rgb(30, 36, 51);
    self.textView = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - self.codeMap.mapWidth, SCREEN_HEIGHT)];
    self.textView.text = self.markdown;
    [self.view addSubview:self.textView];
    self.textView.delegate = self;
    self.textView.backgroundColor = rgb(30, 36, 51);
    self.textView.textParser = self.parser;
    self.textView.font = [UIFont fontWithName:self.parser.textFontName size:self.parser.fontSize];
    [self.view addSubview:self.codeMap];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_isCodeMapScrolling) {
        return;
    }
    
    [self.codeMap scrollMaskViewTo:self.textView.contentOffset.y];
    
}

- (void)ZYCodeMapViewDidEndScorll {
    
    _isCodeMapScrolling = NO;
}

- (void)ZYCodeMapView:(ZYCodeMapView *)view didScorll:(CGFloat)offSet_Y
{
    CGFloat ratio = MAX((self.textView.contentSize.height - SCREEN_HEIGHT), 0)/MIN( (view.contentSize_height - (self.codeMap.width * SCREEN_HEIGHT/SCREEN_WIDTH)), SCREEN_HEIGHT - (view.mapWidth * SCREEN_HEIGHT/SCREEN_WIDTH));
    
    _isCodeMapScrolling = YES;
    self.textView.contentOffset = CGPointMake(0, offSet_Y * ratio);
    [view adjustMapContentOffset_Y:offSet_Y * ratio];
    
}


- (void)textViewDidChange:(YYTextView *)textView
{
    self.codeMap.attributedString = [self.textView.attributedText mutableCopy];
    self.codeMap.editorContentHeight = self.textView.contentSize.height;
    self.markdown = textView.text;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
