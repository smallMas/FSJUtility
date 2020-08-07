//
//  UILabel+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UILabel+FSJUtility.h"

@implementation UILabel (FSJUtility)

#pragma mark - 快捷创建方法
+ (UILabel *)fsj_createFrame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = color;
    return label;
}

+ (UILabel *)fsj_createFrame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    UILabel *label = [self fsj_createFrame:frame font:font color:color];
    label.textAlignment = alignment;
    return label;
}

+ (UILabel *)fsj_createFont:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    return label;
}

+ (UILabel *)fsj_createFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    UILabel *label = [self fsj_createFont:font color:color];
    label.textAlignment = alignment;
    return label;
}

@end
