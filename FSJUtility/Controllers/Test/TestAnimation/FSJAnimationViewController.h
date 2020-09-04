//
//  FSJAnimationViewController.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/4.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJBaseController.h"

typedef NS_ENUM(NSInteger, FSJAnimationType) {
    FSJAnimationTypeScale1,
    FSJAnimationTypeScale2,
    FSJAnimationTypeRotation1,
    FSJAnimationTypeRotation2,
    FSJAnimationTypeOpacity,
    FSJAnimationTypeTransitions,// 转场动画
    
    FSJAnimationTypeOther,
};

NS_ASSUME_NONNULL_BEGIN

@interface FSJAnimationViewController : FSJBaseController
@property (nonatomic, assign) FSJAnimationType animationType;
@end

NS_ASSUME_NONNULL_END
