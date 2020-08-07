//
//  UIViewController+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (FSJUtility)

#pragma mark - Controller 生成
/// 使用类字符串生成类对象
- (UIViewController *)fsj_createControllerWithClassString:(NSString *)classString;
/// 使用类字符串生成类对象 带参数[]
- (UIViewController *)fsj_createControllerWithClassString:(NSString *)classString params:(NSDictionary *)params;
/// 使用类字符串push Controller
- (void)fsj_pushControllerWithClassString:(NSString *)classString;
/// 使用类字符串push Controller 带参数[]
- (void)fsj_pushControllerWithClassString:(NSString *)classString params:(NSDictionary *)params;
/// 使用类字符串present Controller
- (void)fsj_presentControllerWithClassString:(NSString *)classString completion:(void (^)(void))completion;
/// 使用类字符串present Controller 带参数[]
- (void)fsj_presentControllerWithClassString:(NSString *)classString params:(NSDictionary *)params completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
