//
//  UIControl+FSJEffectiveArea.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIControl+FSJEffectiveArea.h"
#import <objc/runtime.h>
#import "FSJSwizziedMethod.h"

@interface UIControl ()

@property (nonatomic, assign) BOOL fsj_eventUnavailable;

@end

@implementation UIControl (FSJEffectiveArea)

+ (void)load {
    FSJ_SwizzleMethod([self class], @selector(sendAction:to:forEvent:), [self class], @selector(fsj_sendAction:to:forEvent:));
}

- (void)fsj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if([self isMemberOfClass:[UIButton class]]) {
        if (self.fsj_eventUnavailable == NO) {
              self.fsj_eventUnavailable = YES;
              [self fsj_sendAction:action to:target forEvent:event];
              [self performSelector:@selector(setFsj_eventUnavailable:) withObject:0           afterDelay:self.fsj_eventInterval];
        }
   } else {
        [self fsj_sendAction:action to:target forEvent:event];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
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

- (void)setFsj_clickArea:(NSString *)fsj_clickArea {
    objc_setAssociatedObject(self, @selector(fsj_clickArea), fsj_clickArea, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)fsj_clickArea {
    return objc_getAssociatedObject(self, @selector(fsj_clickArea));
}

- (void)setFsj_eventInterval:(NSTimeInterval)fsj_eventInterval {
    objc_setAssociatedObject(self, @selector(fsj_eventInterval), @(fsj_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)fsj_eventInterval {
    return [objc_getAssociatedObject(self, @selector(fsj_eventInterval)) doubleValue];
}

- (void)setFsj_eventUnavailable:(BOOL)fsj_eventUnavailable {
    objc_setAssociatedObject(self, @selector(fsj_eventUnavailable), @(fsj_eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fsj_eventUnavailable {
    return [objc_getAssociatedObject(self, @selector(fsj_eventUnavailable)) boolValue];
}

@end
