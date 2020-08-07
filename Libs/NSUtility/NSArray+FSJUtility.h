//
//  NSArray+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 拼音的字段
extern NSString *const FsjFirstLetter;
extern NSString *const FsjContent;

@interface NSArray (FSJUtility)

#pragma mark - json转换
/*! array转json字符串 */
- (NSString *)fsj_toJsonString;

#pragma mark - 字母分类
/*!
 * @brief 按拼音首字母分类
 *
 * @param key model的属性名
 */
- (NSArray *)fsj_arrayWithPinYinFirstCharWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
