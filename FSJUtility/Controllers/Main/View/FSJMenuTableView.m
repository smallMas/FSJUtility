//
//  FSJMenuTableView.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJMenuTableView.h"

@interface FSJMenuTableView ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FSJMenuTableView

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.tableView.tableViewAdapter.headerHeight = 0.0001;
    self.tableView.tableViewAdapter.footerHeight = 0.0001;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    FSJ_WEAK_SELF
    self.tableView.tableViewDidSelectRowBlock = ^(UITableView *tableView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        if (self.eventTransmissionBlock) {
            self.eventTransmissionBlock(self, itemData, indexPath.row, nil);
        }
    };
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)setDataArray:(NSArray<FSJMenuModel *> *)dataArray {
    _dataArray = dataArray;
    [self reloadData];
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    [self.tableView setBackgroundColor:bgColor];
}

- (void)reloadData {
    self.tableView.cellDatas = self.dataArray?@[self.dataArray]:nil;
    [self.tableView reloadData];
}


@end
