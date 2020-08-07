//
//  NSObject+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "NSObject+FSJUtility.h"
#import <objc/runtime.h>

BOOL FSJ_ObjectIsNullAndEmpty(NSObject *object) {
    if ([object isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)object;
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string isEqual:@""]) {
            return YES;
        }
    }else if ([object isEqual:[NSNull null]] ||
              object == nil) {
        return YES;
    }
    return NO;
}

@implementation NSObject (FSJUtility)

#pragma mark - 归档
/*! 序列化,解档 */
- (void)fsj_decode:(NSCoder *)aDecoder {
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [aDecoder decodeObjectForKey:key];
        if (value) [self setValue:value forKey:key];
    }
    free(ivars);
}

/*! 序列化,归档 */
- (void)fsj_encode:(NSCoder *)aCoder {
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self.class, &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

@end
