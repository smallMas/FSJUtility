//
//  NSObject+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 判断空对象，空字符串
BOOL FSJ_ObjectIsNullAndEmpty(NSObject *object);

@interface NSObject (FSJUtility)

#pragma mark - 归档
/*! 序列化,解档 */
- (void)fsj_decode:(NSCoder *)aDecoder;
/*! 序列化,归档 */
- (void)fsj_encode:(NSCoder *)aCoder;

@end

NS_ASSUME_NONNULL_END
