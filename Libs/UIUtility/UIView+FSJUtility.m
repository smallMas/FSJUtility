//
//  UIView+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIView+FSJUtility.h"

@implementation UIView (FSJUtility)

#pragma mark - Set GET
- (CGFloat)fsj_left {
    return self.frame.origin.x;
}

- (void)setFsj_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)fsj_top {
    return self.frame.origin.y;
}

- (void)setFsj_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)fsj_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFsj_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)fsj_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFsj_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)fsj_width {
    return self.frame.size.width;
}

- (void)setFsj_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)fsj_height {
    return self.frame.size.height;
}

- (void)setFsj_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)fsj_centerX {
    return self.center.x;
}

- (void)setFsj_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)fsj_centerY {
    return self.center.y;
}

- (void)setFsj_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)fsj_origin {
    return self.frame.origin;
}

- (void)setFsj_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)fsj_size {
    return self.frame.size;
}

- (void)setFsj_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - view的属性设置
/// layer设置圆角
- (void)fsj_setRoundRadius:(float)radius borderColor:(UIColor *)bColor {
    [self fsj_setRoundRadius:radius borderColor:bColor board:1.0];
}

- (void)fsj_setRoundRadius:(float)radius borderColor:(UIColor *)bColor board:(CGFloat)board {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = board;
    self.layer.borderColor = [bColor CGColor];
}

/// 设置圆角 左右四个角都可以单独或组合设置
- (void)fsj_setCorner:(UIRectCorner)corners radius:(float)radius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:corners
                                           cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/// 部分边框线
- (UIView *)fsj_borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(FSJBorderSideType)borderType {
    if (borderType == FSJBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return self;
    }
    
    /// left
    if (borderType & FSJBorderSideTypeLeft) {
        /// 左侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// right
    if (borderType & FSJBorderSideTypeRight) {
        /// 右侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// top
    if (borderType & FSJBorderSideTypeTop) {
        /// top线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    /// bottom
    if (borderType & FSJBorderSideTypeBottom) {
        /// bottom线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    return self;
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}

#pragma mark - 功能
/// view截屏
- (UIImage*)fsj_snapshot {
    self.backgroundColor = [UIColor whiteColor];
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size,YES, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

#pragma mark - 动画
// 缩放抖动动画
- (void)fsj_startScaleAnimationFinishBlock:(void (^)(void))block {
    [UIView animateWithDuration:0.08 animations:^{
        self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08 animations:^{
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.08 animations:^{
                self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                if (block) {
                    block();
                }
            }];
        }];
    }];
}

- (void)fsj_startScaleAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.25;
    animation.repeatCount = 1;
    animation.fromValue = [NSNumber numberWithFloat:0.8];
    animation.toValue = [NSNumber numberWithFloat:1.2];
    [self.layer addAnimation:animation forKey:nil];
}

// 缩放动画
- (void)fsj_scaleAnimationDuration:(CGFloat)duration scale:(CGFloat)scale block:(void (^)(void))block {
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        if (block) {
            block();
        }
    }];
}

// 旋转动画
- (void)fsj_rotationDuration:(CGFloat)duration from:(CGFloat)fromf to:(CGFloat)tof {
    NSNumber *from = @(fromf);
    NSNumber *to = @(tof);
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.duration = duration;
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:nil];
}

// 动画旋转次数
- (void)fsj_rotationDuration:(CGFloat)duration from:(CGFloat)fromf to:(CGFloat)tof repeatCount:(float)repeatCount {
    NSNumber *from = @(fromf);
    NSNumber *to = @(tof);
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.duration = duration;
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = repeatCount;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:nil];
}

#pragma mark - 获取
// 获取当前controller
- (UIViewController *)fsj_viewController {
    //获取当前view的superView对应的控制器
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
