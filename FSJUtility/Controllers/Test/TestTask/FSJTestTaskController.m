//
//  FSJTestTaskController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTestTaskController.h"
#import "FSJTestDelayTask.h"

@interface FSJTestTaskController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FSJTestTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试Task";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0.0001;
    self.tableView.tableViewAdapter.footerHeight = 0.0001;
}

- (void)addAction:(id)sender {
    FSJTestDelayTask *task = [self createTask];
    NSLog(@"添加task : %@ - %@",task.title,task);
    [self.dataArray addObject:task];
    [self reloadData];
}

- (void)reloadData {
    self.tableView.cellDatas = @[self.dataArray];
    [self.tableView reloadData];
}

- (FSJTestDelayTask *)createTask {
    FSJ_WEAK_SELF
    __block FSJTestDelayTask *task = [FSJTestDelayTask gcdDelay:10 task:^{
        FSJ_STRONG_SELF
        NSLog(@"结束task : %@ - %@",task.title,task);
        [self req:^{
            [self.dataArray removeObject:task];
            [self reloadData];
        }];
    }];
    task.title = [FSJUtility fsj_uuid];
    return task;
}

- (void)req:(FSJGCDBlock )task {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"======1");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            task();
        });
    });
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
