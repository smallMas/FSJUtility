//
//  FSJTestSafeController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTestSafeController.h"

@interface FSJTestSafeController ()
@property (nonatomic, strong) UIView *testView;
@end

@implementation FSJTestSafeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.testView];
    
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.view).inset([UIDevice currentDevice].safeTopH);
        make.bottom.mas_equalTo(self.view).inset(UIDevice.currentDevice.safeBottomH);
    }];
}

- (UIView *)testView {
    if (!_testView) {
        _testView = [UIView new];
        [_testView setBackgroundColor:[UIColor fsj_randomColor]];
    }
    return _testView;
}

@end
