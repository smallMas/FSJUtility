//
//  FSJSwizziedMethod.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/10/15.
//  Copyright © 2020 燕来秋. All rights reserved.
//
/*
 例子
 1、替换类方法
 Class URLClass = objc_getMetaClass(NSStringFromClass(NSURL.class).UTF8String);
 FSJ_SwizzleMethod(URLClass, @selector(URLWithString:), URLClass, @selector(DN_URLWithString:));
 
 2、替换实力方法
 FSJ_SwizzleMethod([self class], NSSelectorFromString(@"dealloc"), [self class], @selector(swizzle_dealloc));
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void FSJ_SwizzleMethod(Class originalClass, SEL originalSelector, Class swizzledClass,SEL swizzledSelector);
void FSJ_SwizzleMethod2(Class classStr, SEL originalSelector, SEL swizzledSelector); // 同一个Class

@interface FSJSwizziedMethod : NSObject

@end

NS_ASSUME_NONNULL_END
