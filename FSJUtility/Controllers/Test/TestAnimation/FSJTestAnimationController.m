//
//  FSJTestAnimationController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/4.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTestAnimationController.h"
#import "FSJMenuModel.h"
#import "FSJAnimationViewController.h"

@interface FSJTestAnimationController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FSJTestAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试动画";
    [self setupData];
    [self.view addSubview:self.tableView];
    self.tableView.tableViewAdapter.headerHeight = 0.0001;
    self.tableView.tableViewAdapter.footerHeight = 0.0001;
    
    FSJ_WEAK_SELF
    self.tableView.tableViewDidSelectRowBlock = ^(UITableView *tableView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        FSJMenuModel *model = itemData;
        if (model.vcString) {
            Class cls = NSClassFromString(model.vcString);
            UIViewController *vc = [cls new];
            [vc setValue:@(model.type) forKey:@"animationType"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
}

- (void)setupData {
    [self.dataArray addObject:[self createMenuType:FSJAnimationTypeScale1 title:@"抖动1" clsString:@"FSJAnimationViewController"]];
    [self.dataArray addObject:[self createMenuType:FSJAnimationTypeScale2 title:@"抖动2" clsString:@"FSJAnimationViewController"]];
    [self.dataArray addObject:[self createMenuType:FSJAnimationTypeRotation1 title:@"旋转1" clsString:@"FSJAnimationViewController"]];
    [self.dataArray addObject:[self createMenuType:FSJAnimationTypeRotation2 title:@"旋转2" clsString:@"FSJAnimationViewController"]];
    [self.dataArray addObject:[self createMenuType:FSJAnimationTypeOpacity title:@"呼吸动画" clsString:@"FSJAnimationViewController"]];
    [self.dataArray addObject:[self createMenuType:FSJAnimationTypeTransitions title:@"转场动画" clsString:@"FSJAnimationViewController"]];
    
    
    [self.dataArray addObject:[self createMenuType:FSJAnimationTypeOther title:@"其他动画" clsString:@"FSJAnimationViewController"]];
    
    [self reloadData];
}

- (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title clsString:(NSString *)clsString {
    NSString *text = title;
    FSJMenuModel *model = [FSJMenuModel new];
    model.type = type;
    model.text = text;
    model.vcString = clsString;
    return model;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)reloadData {
    self.tableView.cellDatas = @[self.dataArray];
    [self.tableView reloadData];
}

@end
