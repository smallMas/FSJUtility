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
// mas 创建
+ (UIButton *)fsj_createWithType:(UIButtonType)type target:(id)target action:(SEL)action;

// frame 创建
+ (UIButton *)fsj_createWithFrame:(CGRect)frame type:(UIButtonType)type target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
