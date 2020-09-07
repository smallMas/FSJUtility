//
//  UIView+FSJAnimation.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/4.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FSJTransitionType) {
    // 淡入淡出
    FSJTransitionTypeFade,
    // 推挤
    FSJTransitionTypePush,
    // 揭开
    FSJTransitionTypeReveal,
    // 覆盖
    FSJTransitionTypeMoveIn,
    // 立方体
    FSJTransitionTypeCube,
    // 吮吸
    FSJTransitionTypeSuckEffect,
    // 翻转
    FSJTransitionTypeOglFlip,
    // 波纹
    FSJTransitionTypeRippleEffect,
    // 翻页
    FSJTransitionTypePageCurl,
    // 反翻页
    FSJTransitionTypePageUnCurl,
    // 开镜头
    FSJTransitionTypeCameraIrisHollowOpen,
    // 关镜头
    FSJTransitionTypeCameraIrisHollowClose,
};

typedef NS_ENUM(NSInteger, FSJTransitionSubType) {
    FSJTransitionSubTypeLeft,
    FSJTransitionSubTypeRight,
    FSJTransitionSubTypeTop,
    FSJTransitionSubTypeBottom,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FSJAnimation)

// 缩放抖动动画
- (void)fsj_startScaleAnimationFinishBlock:(void (^)(void))block;
- (void)fsj_startScaleAnimation;
// 缩放动画
- (void)fsj_scaleAnimationDuration:(CGFloat)duration scale:(CGFloat)scale block:(void (^)(void))block;


// 旋转动画
- (void)fsj_rotationDuration:(CGFloat)duration from:(CGFloat)fromf to:(CGFloat)tof;
// 动画旋转次数
- (void)fsj_rotationDuration:(CGFloat)duration from:(CGFloat)fromf to:(CGFloat)tof repeatCount:(float)repeatCount;

// 呼吸动画
- (void)fsj_opacityAnimation;

#pragma mark - 转场动画
/// 转场动画
/// @param typeString 转场类型字符串
/// @param subTypeString 子类型字符串(方向等)
- (void)fsj_transitionAnimationTypeString:(NSString *)typeString subTypeString:(NSString * __nullable)subTypeString;

/// 转场动画
/// @param type 转场类型
/// @param subType 子类型(方向等)
- (void)fsj_transitionAnimationType:(FSJTransitionType)type subType:(FSJTransitionSubType)subType;

@end

NS_ASSUME_NONNULL_END
