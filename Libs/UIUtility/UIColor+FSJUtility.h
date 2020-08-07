//
//  UIColor+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FSJUtility)

/*! 16进制生成Color对象 */
+ (UIColor *)fsj_colorWithHexString:(NSString *)hexString;
/* !16进制、alpha 生成Color对象*/
+ (UIColor *)fsj_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/*! 随机颜色 */
+ (UIColor *)fsj_randomColor;

@end

NS_ASSUME_NONNULL_END
