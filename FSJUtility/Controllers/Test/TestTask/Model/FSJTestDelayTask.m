//
//  FSJTestDelayTask.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTestDelayTask.h"

@implementation FSJTestDelayTask

- (NSString*)cellClassNameInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return @"FSJTestTaskCell";
}

- (CGFloat)cellHeighInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return 44;
}
@end
