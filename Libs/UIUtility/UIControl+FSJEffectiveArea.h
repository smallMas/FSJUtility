//
//  UIControl+FSJEffectiveArea.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (FSJEffectiveArea)

// 扩大按钮热区的比例系数(曲线救国)
@property (nonatomic, copy) NSString *fsj_clickArea;

// 按钮响应间隔时间(防重复点击)
@property (nonatomic, assign) NSTimeInterval fsj_eventInterval;

@end

NS_ASSUME_NONNULL_END
