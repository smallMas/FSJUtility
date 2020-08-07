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

@end
