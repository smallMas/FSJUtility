//
//  TestTabContainViewController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/20.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "TestTabContainViewController.h"
#import "FSJTabMenuView.h"
#import "FSJTabContainView.h"

@interface TestTabContainViewController ()
@property (nonatomic, strong) FSJTabMenuView *menuView;
@property (nonatomic, strong) FSJTabContainView *containView;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation TestTabContainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.menuView.textFont = [UIFont systemFontOfSize:18];
    self.menuView.textColor = [UIColor redColor];
    [self.menuView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.containView];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        UIViewController *vc = [UIViewController new];
        [vc.view setBackgroundColor:[UIColor fsj_randomColor]];
        [array addObject:vc];
    }
    [self.containView configControllers:array parentController:self];
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.menuView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    
    FSJ_WEAK_SELF
    [self.menuView setSelectedBlock:^(NSInteger index) {
        FSJ_STRONG_SELF
        [self.containView setTabIndex:index];
    }];
    
    [self.containView setSwitchBlock:^(NSInteger index) {
       FSJ_STRONG_SELF
        [self.menuView setSelectedIndex:index animated:YES];
    }];
}

- (FSJTabMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[FSJTabMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.fsj_width, 60) array:self.titleArray];
    }
    return _menuView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"男人",@"女人"];
    }
    return _titleArray;
}

- (FSJTabContainView *)containView {
    if (!_containView) {
        _containView = [FSJTabContainView new];
    }
    return _containView;
}

@end
