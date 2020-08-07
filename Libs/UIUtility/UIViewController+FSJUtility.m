//
//  UIViewController+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIViewController+FSJUtility.h"

@implementation UIViewController (FSJUtility)

#pragma mark - Controller 生成
/// 使用类字符串生成类对象
- (UIViewController *)fsj_createControllerWithClassString:(NSString *)classString {
    Class cls = NSClassFromString(classString);
    UIViewController *obj = [cls new];
    return obj;
}

/// 使用类字符串生成类对象 带参数[]
- (UIViewController *)fsj_createControllerWithClassString:(NSString *)classString params:(NSDictionary *)params {
    UIViewController *obj = [self fsj_createControllerWithClassString:classString];
    for (NSString *key in params) {
        [obj setValue:params[key] forKey:key];
    }
    return obj;
}

- (void)fsj_pushController:(UIViewController *)controller {
    if (controller && [controller isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)fsj_presentController:(UIViewController *)controller completion:(void (^)(void))completion {
    if (controller && [controller isKindOfClass:[UIViewController class]]) {
        [self presentViewController:controller animated:YES completion:completion];
    }
}

/// 使用类字符串push Controller
- (void)fsj_pushControllerWithClassString:(NSString *)classString {
    UIViewController *obj = [self fsj_createControllerWithClassString:classString];
    [self fsj_pushController:obj];
}

/// 使用类字符串push Controller 带参数[]
- (void)fsj_pushControllerWithClassString:(NSString *)classString params:(NSDictionary *)params {
    UIViewController *obj = [self fsj_createControllerWithClassString:classString params:params];
    [self fsj_pushController:obj];
}

/// 使用类字符串present Controller
- (void)fsj_presentControllerWithClassString:(NSString *)classString completion:(void (^)(void))completion {
    UIViewController *obj = [self fsj_createControllerWithClassString:classString];
    [self fsj_presentController:obj completion:completion];
}

/// 使用类字符串present Controller 带参数[]
- (void)fsj_presentControllerWithClassString:(NSString *)classString params:(NSDictionary *)params completion:(void (^)(void))completion {
    UIViewController *obj = [self fsj_createControllerWithClassString:classString params:params];
    [self fsj_presentController:obj completion:completion];
}

@end
