//
//  NSTimer+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "NSTimer+FSJUtility.h"

@implementation NSTimer (FSJUtility)

+ (NSTimer *)fsj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(fsj_blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)fsj_blcokInvoke:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

@end
