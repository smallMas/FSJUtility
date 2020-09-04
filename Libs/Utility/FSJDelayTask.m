//
//  FSJDelayTask.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJDelayTask.h"

@implementation FSJDelayTask

+ (instancetype)gcdDelay:(NSTimeInterval)time task:(FSJGCDBlock)block {
    dispatch_block_t blockt = dispatch_block_create(DISPATCH_BLOCK_BARRIER, block);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), blockt);
    FSJDelayTask *task = [[self class] new];
    task.block = blockt;
    return task;
}

- (void)gcdCancel {
    if (self.block) {
        dispatch_block_cancel(self.block);
    }
}

@end
