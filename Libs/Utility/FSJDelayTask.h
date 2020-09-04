//
//  FSJDelayTask.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FSJGCDBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface FSJDelayTask : NSObject
@property (nonatomic, assign) dispatch_block_t block;

+ (instancetype)gcdDelay:(NSTimeInterval)time task:(FSJGCDBlock)block;
- (void)gcdCancel;

@end

NS_ASSUME_NONNULL_END
