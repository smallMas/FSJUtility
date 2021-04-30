//
//  UIButton+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIButton+FSJUtility.h"

@implementation UIButton (FSJUtility)

#pragma mark - 快捷方式
// mas 创建
+ (UIButton *)fsj_createWithType:(UIButtonType)type target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:type];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

// frame 创建
+ (UIButton *)fsj_createWithFrame:(CGRect)frame type:(UIButtonType)type target:(id)target action:(SEL)action {
    UIButton *btn = [self fsj_createWithType:type target:target action:action];
    btn.frame = frame;
    return btn;
}

#pragma mark - 图片与文字的位置关系
/// 图片居左，文字在右，垂直居中显示，文字与图片没有间距为10
- (void)fsj_setIconInLeftWithSpacing:(CGFloat)Spacing {
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = Spacing*0.5,
        .bottom = 0,
        .right  = -Spacing*0.5,
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = -Spacing*0.5,
        .bottom = 0,
        .right  = Spacing*0.5,
    };
}

/// 图片居右，文字在左，垂直居中显示，文字与图片没有间距为10
- (void)fsj_setIconInRightWithSpacing:(CGFloat)Spacing {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = - (img_W + Spacing*0.5),
        .bottom = 0,
        .right  =   (img_W + Spacing*0.5),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   =   (tit_W + Spacing*0.5),
        .bottom = 0,
        .right  = - (tit_W + Spacing*0.5),
    };
}

/// 图片居上，文字在下，垂直居中显示，文字与图片没有间距为10
- (void)fsj_setIconInTopWithSpacing:(CGFloat)Spacing {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    =   (tit_H*0.5 + Spacing*0.5),
        .left   = - (img_W*0.5),
        .bottom = - (tit_H*0.5 + Spacing*0.5),
        .right  =   (img_W*0.5),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = - (img_H*0.5 + Spacing*0.5),
        .left   =   (tit_W*0.5),
        .bottom =   (img_H*0.5 + Spacing*0.5),
        .right  = - (tit_W*0.5),
    };
}

/// 图片居下，文字在上，垂直居中显示，文字与图片没有间距为10
- (void)fsj_setIconInBottomWithSpacing:(CGFloat)Spacing {
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = - (tit_H*0.5 + Spacing*0.5),
        .left   = - (img_W*0.5),
        .bottom =   (tit_H*0.5 + Spacing*0.5),
        .right  =   (img_W*0.5),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    =   (img_H*0.5 + Spacing*0.5),
        .left   =   (tit_W*0.5),
        .bottom = - (img_H*0.5 + Spacing*0.5),
        .right  = - (tit_W*0.5),
    };
}

@end
