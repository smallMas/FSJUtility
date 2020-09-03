//
//  FSJTapAreaView.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTapAreaView.h"

@implementation FSJTapAreaView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    [super pointInside:point withEvent:event];
    //获取bounds 实际大小
    CGRect bounds = self.bounds;
    if (self.fsj_clickArea) {
        CGFloat area = [self.fsj_clickArea floatValue];
        CGFloat widthDelta = MAX(area * bounds.size.width - bounds.size.width, .0);
        CGFloat heightDelta = MAX(area * bounds.size.height - bounds.size.height, .0);
        //扩大bounds
        bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
      }
    //点击的点在新的bounds 中 就会返回YES
    return CGRectContainsPoint(bounds, point);
}

@end
