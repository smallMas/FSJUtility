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
@property (nonatomic, strong) UIView *redView;
@end

@implementation FSJControlTapController
//
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"status height %f",FSJAppStatusHeight);
    NSLog(@"safe top h : %f",FSJAppSafeTopH);
    [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    self.tapBtn.fsj_eventInterval = 2;
    [self.tapBtn setTitle:@"防重复点击" forState:UIControlStateNormal];
    [self.tapBtn setBackgroundColor:[UIColor fsj_randomColor]];
    [self.view addSubview:self.tapBtn];
    [self.tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (@available(iOS 11.0, *)) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
//        } else {
//            // Fallback on earlier versions
//            make.top.mas_equalTo(self.view);
//        }
        
        make.top.mas_equalTo(self.view).inset(FSJAppSafeTopH);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"redview frame : %@",NSStringFromCGRect(self.redView.frame));
}

- (UIButton *)tapBtn {
    if (!_tapBtn) {
        _tapBtn = [UIButton fsj_createWithType:UIButtonTypeCustom target:self action:@selector(testClick:)];
    }
    return _tapBtn;
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] init];
        [_redView setBackgroundColor:[UIColor redColor]];
    }
    return _redView;
}

- (void)testClick:(id)sender {
    NSLog(@"-------1");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"-------2");
    });
}

@end
