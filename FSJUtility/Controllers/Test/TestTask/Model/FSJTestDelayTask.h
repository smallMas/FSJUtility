//
//  FSJTestDelayTask.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJDelayTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSJTestDelayTask : FSJDelayTask <CHGTableViewCellModelProtocol>
@property (nonatomic, strong) NSString *title;
@end

NS_ASSUME_NONNULL_END
