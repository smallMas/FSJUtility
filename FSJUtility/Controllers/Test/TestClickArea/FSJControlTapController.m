//
//  FSJControlTapController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/10/15.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJControlTapController.h"

@interface FSJControlTapController ()
@property (nonatomic, strong) UIButton *tapBtn;
@end

@implementation FSJControlTapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tapBtn.fsj_eventInterval = 2;
    [self.tapBtn setTitle:@"防重复点击" forState:UIControlStateNormal];
    [self.tapBtn setBackgroundColor:[UIColor fsj_randomColor]];
    [self.view addSubview:self.tapBtn];
    [self.tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.mas_equalTo(self.view);
    }];
    
//    [self.tapBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)]];
}

- (UIButton *)tapBtn {
    if (!_tapBtn) {
        _tapBtn = [UIButton fsj_createWithType:UIButtonTypeCustom target:self action:@selector(testClick:)];
    }
    return _tapBtn;
}

- (void)testClick:(id)sender {
    NSLog(@"-------1");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-------2");
    });
}

- (void)tapGes:(id)sender {
    NSLog(@"-------3");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-------4");
    });
}

@end
