//
//  UIApplication+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (FSJUtility)

// 获取当前活动controller
- (UIViewController *)fsj_activityViewController;

@end

NS_ASSUME_NONNULL_END
