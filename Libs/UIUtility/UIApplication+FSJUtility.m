//
//  UIApplication+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIApplication+FSJUtility.h"
#import "FSJFrameMacro.h"

@implementation UIApplication (FSJUtility)

- (UIViewController *)fsj_activityViewController {
    
    __block UIWindow *normalWindow = FSJ_Window;
    if (normalWindow.windowLevel != UIWindowLevelNormal) {
        [self.windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.windowLevel == UIWindowLevelNormal) {
                normalWindow = obj;
                *stop        = YES;
            }
        }];
    }
    
    return [self fsj_nextTopForViewController:normalWindow.rootViewController];
}

- (UIViewController *)fsj_nextTopForViewController:(UIViewController *)inViewController {
    while (inViewController.presentedViewController) {
        inViewController = inViewController.presentedViewController;
    }
    
    if ([inViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = [self fsj_nextTopForViewController:((UITabBarController *)inViewController).selectedViewController];
        return selectedVC;
    } else if ([inViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *selectedVC = [self fsj_nextTopForViewController:((UINavigationController *)inViewController).visibleViewController];
        return selectedVC;
    } else {
        return inViewController;
    }
}

@end
