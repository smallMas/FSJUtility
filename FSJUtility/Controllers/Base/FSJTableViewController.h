//
//  FSJTableViewController.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/12.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSJTableViewController : FSJBaseController <UITableViewDelegate, UITableViewDataSource>

/*! tableview */
@property (nonatomic, strong, readonly) UITableView *tableView;
/*! tableview风格 */
@property (nonatomic, assign, readonly) UITableViewStyle style;

@end

NS_ASSUME_NONNULL_END
