//
//  ZYCodeMapView.m
//  ZYMarkdownEditor <https://github.com/LZTuna/ZYMarkdownEditor>
//
//  Created by lztuna on 16/12/4.
//  Copyright (c) 2015 lztuna.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "ZYCodeMapView.h"
#import "NSAttributedString+YYText.h"
#import "YYTextLayout.h"
#import "UIView+ZYExtension.h"
#define MASK_WIDTH 60
#define MASK_HEIGHT  (MASK_WIDTH * SCREEN_HEIGHT/SCREEN_WIDTH)
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define rgb(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


@interface ZYCodeMapView ()

@property (nonatomic, strong)YYTextView *textView;

@property (nonatomic, strong)UIPanGestureRecognizer *maskPan;

@property (nonatomic, strong, readwrite)UIView *maskView;
@end

@implementation ZYCodeMapView {
    
    
    
    NSUInteger _statue;// 0隐藏，1可见;
 
}

- (instancetype)init
{
    self = [self initWithFrame:CGRectMake(SCREEN_WIDTH - MASK_WIDTH,0,MASK_WIDTH,SCREEN_HEIGHT)];
    
    self.textView = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, MASK_WIDTH, SCREEN_HEIGHT)];
    self.textView.backgroundColor = [rgb(30, 36, 51) colorWithAlphaComponent:1];
    self.textView.scrollEnabled = NO;
    self.textView.editable = NO;
    self.textView.font = [UIFont systemFontOfSize:2];
    self.textView.editable = NO;
    
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MASK_WIDTH, MASK_HEIGHT)];
    self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:self.textView];
    [self addSubview:self.maskView];
    
    self.maskPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
    [self.maskView addGestureRecognizer:self.maskPan];
  

    return self;
}




- (CGFloat)editorViewHeight {
    
  
    return  self.editorContentHeight;
}



- (CGFloat)heightWithText:(NSAttributedString *)attStr  maxSize:(CGSize)maxSize
{
    
    return [attStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
}



- (CGFloat)contentSize_height {
    
    return self.textView.contentSize.height;
    
}

- (void)scrollMaskViewTo:(CGFloat)locate
{
    
    if (self.editorContentHeight - SCREEN_HEIGHT <0 || self.textView.contentSize.height - MASK_HEIGHT<0) {
        
        return;
    }
    
    //路程之比
    CGFloat ratio_editor_mask = (self.editorContentHeight - SCREEN_HEIGHT)/
                    //分情况选择Mask滑动到底部的路程
                    MIN(SCREEN_HEIGHT - MASK_HEIGHT,self.textView.contentSize.height - MASK_HEIGHT);
    
    if (self.textView.contentSize.height - SCREEN_HEIGHT > 0) {
        
        [self adjustMapContentOffset_Y:locate];
        
    }
    
    

    
   
                            //规定下界
    self.maskView.centerY = MIN(
                                //规定上界
                                MAX(locate/ratio_editor_mask + MASK_HEIGHT/2,MASK_HEIGHT/2),
                                //分情况选择下界
                                MIN((self.textView.contentSize.height - MASK_HEIGHT/2), SCREEN_HEIGHT - MASK_HEIGHT/2)
                               );
    
    
}


- (void)adjustMapContentOffset_Y:(CGFloat)move {
    
    if (self.textView.contentSize.height - SCREEN_HEIGHT > 0) {
        
        CGFloat ratio_map_editor = (self.textView.contentSize.height - SCREEN_HEIGHT)/(self.editorContentHeight - SCREEN_HEIGHT);
        self.textView.contentOffset = CGPointMake(0, ratio_map_editor * move);
        
    }
    
}

- (void)setAttributedString:(NSMutableAttributedString *)attributedString
{
    _attributedString = [attributedString mutableCopy];
    [attributedString yy_setFont:[UIFont systemFontOfSize:5] range:attributedString.yy_rangeOfAll];
    self.textView.attributedText = [attributedString copy];
    
}

- (CGFloat)mapWidth {
    
    return MASK_WIDTH;
}



- (void)didPan:(UIPanGestureRecognizer *)pan {
    
    static CGFloat mask_begin_Y,map_begin_Y;
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        mask_begin_Y = self.maskView.centerY;
        map_begin_Y = self.textView.contentOffset.y;
        [self.delegate ZYCodeMapView:self didScorll:self.maskView.centerY - MASK_HEIGHT/2];
        
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        
        
        
        self.maskView.centerY = MIN( MAX(mask_begin_Y + [pan translationInView:self].y, MASK_HEIGHT/2), MIN(MAX(self.textView.contentSize.height - MASK_HEIGHT/2, MASK_HEIGHT/2), SCREEN_HEIGHT - MASK_HEIGHT/2));
        
         [self.delegate ZYCodeMapView:self didScorll:self.maskView.centerY - MASK_HEIGHT/2];
        
      
        
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        
        [self.delegate ZYCodeMapView:self didScorll:self.maskView.centerY - MASK_HEIGHT/2];
        [self.delegate ZYCodeMapViewDidEndScorll];
        
    }
    

}



@end
