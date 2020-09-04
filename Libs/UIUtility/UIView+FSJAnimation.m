//
//  UIView+FSJAnimation.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/4.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIView+FSJAnimation.h"

@implementation UIView (FSJAnimation)

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

- (void)fsj_scaleAnimationDuration:(CGFloat)duration scale:(CGFloat)scale block:(void (^)(void))block {
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        if (block) {
            block();
        }
    }];
}

- (void)fsj_rotationDuration:(CGFloat)duration from:(CGFloat)fromf to:(CGFloat)tof {
    [self fsj_rotationDuration:duration from:fromf to:tof repeatCount:HUGE_VALF];
}

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

- (void)fsj_opacityAnimation {
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;    //回退动画（动画可逆，即循环）
    animation.duration = 1.0f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//removedOnCompletion,fillMode配合使用保持动画完成效果
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animation forKey:@"aAlpha"];
}

#pragma mark - 转场动画
- (void)transitionAnimationTypeString:(NSString *)typeString subTypeString:(NSString *)subTypeString {
    //- 创建一个转场动画:
    CATransition *transition = [CATransition animation];
    transition.repeatCount = 1;
    //    - 确定动画类型:
    transition.type = typeString;
    //    - 确定子类型(方向等)
    if (subTypeString) {
        transition.subtype = subTypeString;
    }
    //    - 确定动画时间
    transition.duration = 0.25;
    //    - 添加动画
    [self.layer addAnimation:transition forKey:nil];
}

- (void)transitionAnimationType:(FSJTransitionType)type subType:(FSJTransitionSubType)subType {
    NSString *typeStr = [self stringWithTransitionType:type];
    NSString *subStr = [self subStringWithType:subType];
    if (type == FSJTransitionTypeRippleEffect ||
        type == FSJTransitionTypeSuckEffect ||
        type == FSJTransitionTypeCameraIrisHollowOpen ||
        type == FSJTransitionTypeCameraIrisHollowClose) {
        subStr = nil;
    }
    [self transitionAnimationTypeString:typeStr subTypeString:subStr];
}

- (NSString *)stringWithTransitionType:(FSJTransitionType)type {
    NSString *typeStr = @"fade";
    switch (type) {
        case FSJTransitionTypeFade:
            typeStr = kCATransitionFade;//@"fade";
            break;
        case FSJTransitionTypePush:
            typeStr = kCATransitionPush;//@"push";
            break;
        case FSJTransitionTypeReveal:
            typeStr = kCATransitionReveal;//@"reveal";
            break;
        case FSJTransitionTypeMoveIn:
            typeStr = kCATransitionMoveIn;//@"moveIn";
            break;
        case FSJTransitionTypeCube:
            typeStr = @"cube";
            break;
        case FSJTransitionTypeSuckEffect:
            typeStr = @"suckEffect";
            break;
        case FSJTransitionTypeOglFlip:
            typeStr = @"oglFlip";
            break;
        case FSJTransitionTypeRippleEffect:
            typeStr = @"rippleEffect";
            break;
        case FSJTransitionTypePageCurl:
            typeStr = @"pageCurl";
            break;
        case FSJTransitionTypePageUnCurl:
            typeStr = @"pageUnCurl";
            break;
        case FSJTransitionTypeCameraIrisHollowOpen:
            typeStr = @"cameraIrisHollowOpen";
            break;
        case FSJTransitionTypeCameraIrisHollowClose:
            typeStr = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    return typeStr;
}

- (NSString *)subStringWithType:(FSJTransitionSubType)type {
    NSString *subStr = kCATransitionFromLeft;
    switch (type) {
        case FSJTransitionSubTypeLeft:
            subStr = kCATransitionFromLeft;
            break;
        case FSJTransitionSubTypeRight:
            subStr = kCATransitionFromRight;
            break;
        case FSJTransitionSubTypeTop:
            subStr = kCATransitionFromTop;
            break;
        case FSJTransitionSubTypeBottom:
            subStr = kCATransitionFromBottom;
            break;
        default:
            break;
    }
    return subStr;
}

@end
