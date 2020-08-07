//
//  NSDictionary+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (FSJUtility)

#pragma mark - json转换
/*! 字典转json字符串 */
- (NSString *)fsj_toJsonString;

@end

NS_ASSUME_NONNULL_END
