//
//  FSJSwizziedMethod.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/10/15.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJSwizziedMethod.h"
#import <objc/runtime.h>

void FSJ_SwizzleMethod(Class originalClass, SEL originalSelector, Class swizzledClass,SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(originalClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void FSJ_SwizzleMethod2(Class classStr, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(classStr, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(classStr, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(classStr, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(classStr, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

@implementation FSJSwizziedMethod

@end
