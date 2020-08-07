//
//  UIView+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, FSJBorderSideType) {
    FSJBorderSideTypeAll  = 0,
    FSJBorderSideTypeTop = 1 << 0,
    FSJBorderSideTypeBottom = 1 << 1,
    FSJBorderSideTypeLeft = 1 << 2,
    FSJBorderSideTypeRight = 1 << 3,
};

@interface UIView (FSJUtility)

@property (nonatomic) CGFloat fsj_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat fsj_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat fsj_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat fsj_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat fsj_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat fsj_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat fsj_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat fsj_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint fsj_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  fsj_size;        ///< Shortcut for frame.size.

#pragma mark - View的属性设置
/// layer设置圆角
- (void)fsj_setRoundRadius:(float)radius borderColor:(UIColor *)bColor;
- (void)fsj_setRoundRadius:(float)radius borderColor:(UIColor *)bColor board:(CGFloat)board;

/// 设置圆角 左右四个角都可以单独或组合设置
- (void)fsj_setCorner:(UIRectCorner)corners radius:(float)radius;

/// 部分边框线
- (UIView *)fsj_borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(FSJBorderSideType)borderType;

#pragma mark - 功能
/// view截屏
- (UIImage*)fsj_snapshot;

#pragma mark - 动画
/// 缩放抖动动画
- (void)fsj_startScaleAnimationFinishBlock:(void (^)(void))block;
- (void)fsj_startScaleAnimation;
/// 缩放动画
- (void)fsj_scaleAnimationDuration:(CGFloat)duration scale:(CGFloat)scale block:(void (^)(void))block;
/// 旋转动画
- (void)fsj_rotationDuration:(CGFloat)duration from:(CGFloat)fromf to:(CGFloat)tof;
/// 动画旋转次数
- (void)fsj_rotationDuration:(CGFloat)duration from:(CGFloat)fromf to:(CGFloat)tof repeatCount:(float)repeatCount;

@end

NS_ASSUME_NONNULL_END
