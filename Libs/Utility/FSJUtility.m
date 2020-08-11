//
//  FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/11.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJUtility.h"

@implementation FSJUtility

#pragma mark - 快速生成
/// 生成一个UUID
+ (NSString*)fsj_uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/// 获取当前的时间sss
+ (NSString *)fsj_currentDateAndTime {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    [dateFormatter setTimeZone:zone];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/// 获取当前时间戳(毫秒)
+ (NSString *)fsj_getCurrentTimeStamp {
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",time*1000];
}

#pragma mark - 时间转换
/// 获取当前日期yyyy-MM-dd
+ (NSString *)fsj_getCurrentDateString {
    NSDate *date = [NSDate date];
    NSString *string = [self fsj_stringForDate:date dateFormattor:@"yyyy-MM-dd"];
    return string;
}

/// NSDate 转 字符串
+ (NSString *)fsj_stringForDate:(NSDate *)date dateFormattor:(NSString *)dateFormatter {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormatter];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/// 时间字符串 转 时间字符串
+ (NSString *)fsj_stringForString:(NSString *)dateStr dateFormattor:(NSString *)dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateStr];
    NSString *str = [self fsj_stringForDate:date dateFormattor:dateFormatter];
    return str;
}

/// 时间戳 转 时间字符串
+ (NSString *)fsj_stringForStamp:(NSString *)timeStamp dateFormattor:(NSString *)dateFormatter {
    NSTimeInterval stamp = [timeStamp longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp];
    return [self fsj_stringForDate:date dateFormattor:dateFormatter];
}

@end
