//
//  ZYCodeMapView.h
//  ZYMarkdownEditor <https://github.com/LZTuna/ZYMarkdownEditor>
//
//  Created by lztuna on 16/12/4.
//  Copyright (c) 2015 lztuna.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>
#import "YYTextView.h"

@class ZYCodeMapView;

@protocol ZYCodeMapViewDelegate <NSObject>

- (void)ZYCodeMapView:(ZYCodeMapView *)view didScorll:(CGFloat )offSet_Y;

- (void)ZYCodeMapViewDidEndScorll;

@end

@interface ZYCodeMapView : UIView



@property (nonatomic, strong,readonly)UIView *maskView;
@property (nonatomic, copy)NSMutableAttributedString *attributedString;
@property (nonatomic, weak)id<ZYCodeMapViewDelegate> delegate;
@property (nonatomic, readonly)CGFloat contentSize_height;
@property (nonatomic, assign)CGFloat editorContentHeight;
@property (nonatomic, readonly)CGFloat mapWidth;

- (void)adjustMapContentOffset_Y:(CGFloat)distance;

- (void)scrollMaskViewTo:(CGFloat )locate;

@end
