//
//  FSJPopBottomContainerView.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/12.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 关闭有动画
extern NSString * _Nonnull const kFSJPopBottomCloseDonePressed;
// 关闭没有动画
extern NSString * _Nonnull const kFSJPopBottomCloseDoneNoAnimationPressed;

typedef void (^ FSJPopCloseBlock) (void);
typedef void (^ FSJVoidBlock)(void);
typedef void (^ FSJPopAnimationBlock) (FSJVoidBlock block);

@interface FSJPopBottomContainerView : UIView

// 是否点击back界面返回
@property (nonatomic, assign) BOOL isTapBack;

// 背景点击view的颜色
@property (nonatomic, strong) UIColor *backViewColor;

// sub view
@property (nonatomic, strong, readonly) UIView *subView;

// 显示动画
@property (nonatomic, copy) FSJPopAnimationBlock showAnimationBlock;
// 消失动画
@property (nonatomic, copy) FSJPopAnimationBlock hiddenAnimationBlock;

// 显示时，subView显示的y位置
@property (nonatomic, strong) NSNumber *showNumY;
// 隐藏时，subView显示的y位置
@property (nonatomic, strong) NSNumber *hiddenNumY;

/*!
 * 初始化底部弹框容器
 *
 * @param superView 弹框容器的载体
 * @param subView 需要显示在弹框容器的view
 **/
- (instancetype)initWithSuperView:(UIView *)superView withView:(UIView *)subView;

/*!
 * 显示
 *
 * @param animated 是否动画
 **/
- (void)show:(BOOL)animated;

/*!
 * 显示并返回close的回调
 *
 * @param animated 是否动画
 * @param block close的回调block
 **/
- (void)show:(BOOL)animated block:(FSJPopCloseBlock)block;

/*!
 * 关闭容器 / 也可以通过通知来关闭 kPopBottomCloseDonePressed
 *
 * @param animated 是否动画
 **/
- (void)dissmiss:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
