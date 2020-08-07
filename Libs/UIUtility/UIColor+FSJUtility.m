//
//  UIColor+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIColor+FSJUtility.h"

@implementation UIColor (FSJUtility)

/*! 16进制生成Color对象 */
+ (UIColor *)fsj_colorWithHexString:(NSString *)hexString {
    return [self fsj_colorWithHexString:hexString alpha:1.0];
}

/* !16进制、alpha 生成Color对象*/
+ (UIColor *)fsj_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    // Bypass '#' character
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

/*! 随机颜色 */
+ (UIColor *)fsj_randomColor {
    static BOOL seed = NO;
    if (!seed) {
        seed = YES;
        srandom((unsigned int)time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
