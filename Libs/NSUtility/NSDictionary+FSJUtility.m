//
//  NSDictionary+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "NSDictionary+FSJUtility.h"

@implementation NSDictionary (FSJUtility)

#pragma mark - json转换
/*! 字典转json字符串 */
- (NSString *)fsj_toJsonString {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
