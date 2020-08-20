//
//  FSJTabContainView.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/20.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
     FSJScrollTypeLeftAndRight= 0,
    FSJScrollTypeUpAndDown,
} FSJScrollType;

typedef void (^ FSJTabSwitchBlock) (NSInteger index);

@interface FSJTabContainView : UIView

// 使用pageController翻页
@property (nonatomic, strong) UIPageViewController *pageController;

// 内容页数组
@property (nonatomic, strong) NSArray<UIViewController*> *controllers;

// 当前页索引
@property (nonatomic, assign) NSInteger currentIndex;
// 类型 只能设置一次
@property (nonatomic, assign) FSJScrollType scrollType;
// 滑动回调
@property (nonatomic, copy) FSJTabSwitchBlock switchBlock;

// 禁止滑动
@property (nonatomic, assign) BOOL scrollEnabled;

- (void)setTabIndex:(NSInteger)index;
- (void)setTabIndex:(NSInteger)index animated:(BOOL)animated;

- (void)configControllers:(NSMutableArray<UIViewController*>*)controllers parentController:(UIViewController *)parentVC;
- (void)configControllers:(NSMutableArray<UIViewController*>*)controllers parentController:(UIViewController *)parentVC index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
