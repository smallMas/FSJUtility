//
//  FSJMenuModel.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/12.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJMenuModel.h"

@implementation FSJMenuModel

#pragma mark - CHGTableViewCellModelProtocol
- (NSString*)cellClassNameInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return @"FSJMenuTableCell";
}

- (CGFloat)cellHeighInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return 44;
}

@end
