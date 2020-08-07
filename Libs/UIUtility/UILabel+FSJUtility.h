//
//  UILabel+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FSJUtility)

#pragma mark - 快捷创建方法
+ (UILabel *)fsj_createFrame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color;
+ (UILabel *)fsj_createFrame:(CGRect)frame font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;
+ (UILabel *)fsj_createFont:(UIFont *)font color:(UIColor *)color;
+ (UILabel *)fsj_createFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

@end

NS_ASSUME_NONNULL_END
