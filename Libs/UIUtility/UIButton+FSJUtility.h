//
//  UIButton+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (FSJUtility)

#pragma mark - 快捷方式
/// mas 创建
+ (UIButton *)fsj_createWithType:(UIButtonType)type target:(id)target action:(SEL)action;

/// frame 创建
+ (UIButton *)fsj_createWithFrame:(CGRect)frame type:(UIButtonType)type target:(id)target action:(SEL)action;

#pragma mark - 图片与文字的位置关系
/// 图片居左，文字在右，垂直居中显示，文字与图片没有间距为10
- (void)fsj_setIconInLeftWithSpacing:(CGFloat)Spacing;

/// 图片居右，文字在左，垂直居中显示，文字与图片没有间距为10
- (void)fsj_setIconInRightWithSpacing:(CGFloat)Spacing;

/// 图片居上，文字在下，垂直居中显示，文字与图片没有间距为10
- (void)fsj_setIconInTopWithSpacing:(CGFloat)Spacing;

/// 图片居下，文字在上，垂直居中显示，文字与图片没有间距为10
- (void)fsj_setIconInBottomWithSpacing:(CGFloat)Spacing;

@end

NS_ASSUME_NONNULL_END
