//
//  FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/11.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSJUtility : NSObject

#pragma mark - 快速生成
/// 生成一个UUID
+ (NSString*)fsj_uuid;
/// 获取当前的时间sss
+ (NSString *)fsj_currentDateAndTime;
/// 获取当前时间戳(毫秒)
+ (NSString *)fsj_getCurrentTimeStamp;

#pragma mark - 时间转换
/// 获取当前日期yyyy-MM-dd
+ (NSString *)fsj_getCurrentDateString;
/// NSDate 转 字符串
+ (NSString *)fsj_stringForDate:(NSDate *)date dateFormattor:(NSString *)dateFormatter;
/// 时间字符串 转 时间字符串
+ (NSString *)fsj_stringForString:(NSString *)dateStr dateFormattor:(NSString *)dateFormatter;
/// 时间戳 转 时间字符串
+ (NSString *)fsj_stringForStamp:(NSString *)timeStamp dateFormattor:(NSString *)dateFormatter;

#pragma mark - emoji
/// 根据国家代码获取国旗emoji （注意:台湾的表情可能没有）
- (NSString *)fsj_emojiFlagForISOCountryCode:(NSString *)countryCode;

#pragma mark - 计算
+ (CGRect)fsj_calculateRectWithAtt:(NSAttributedString *)att size:(CGSize)size;
+ (CGFloat)fsj_calculateHeightWithAtt:(NSAttributedString *)att size:(CGSize)size;
+ (CGFloat)fsj_calculateWidthWithAtt:(NSAttributedString *)att size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
