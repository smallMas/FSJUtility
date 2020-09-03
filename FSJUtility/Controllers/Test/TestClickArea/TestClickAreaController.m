//
//  TestClickAreaController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "TestClickAreaController.h"

@interface TestClickAreaController ()
@property (nonatomic, strong) FSJTapAreaView *tapView;
@property (nonatomic, strong) UIButton *testBtn1;
@property (nonatomic, strong) UIImageView *testImageView;
@end

@implementation TestClickAreaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tapView];
    [self.tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.mas_equalTo(self.view);
    }];
    self.tapView.fsj_clickArea = @"2";
    
    
    [self.tapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)]];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognize:)];//初始化平移手势识别器(Pan)
    panGestureRecognizer.delegate = (id <UIGestureRecognizerDelegate>) self;
    [self.tapView addGestureRecognizer:panGestureRecognizer];
    
    
    [self.view addSubview:self.testBtn1];
    [self.testBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).inset(50);
    }];
    self.testBtn1.fsj_clickArea = @"2";
    
    [self.view addSubview:self.testImageView];
    [self.testImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).inset(50);
    }];
    self.testImageView.userInteractionEnabled = YES;
    [self.testImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap2:)]];
    self.testImageView.fsj_clickArea = @"2";
}

#pragma mark - 懒加载
- (FSJTapAreaView *)tapView {
    if (!_tapView) {
        _tapView = [[FSJTapAreaView alloc] init];
        [_tapView setBackgroundColor:[UIColor redColor]];
    }
    return _tapView;
}

- (UIButton *)testBtn1 {
    if (!_testBtn1) {
        _testBtn1 = [UIButton fsj_createWithType:UIButtonTypeCustom target:self action:@selector(tapButtonAction:)];
        [_testBtn1 setBackgroundColor:[UIColor greenColor]];
    }
    return _testBtn1;
}

- (UIImageView *)testImageView {
    if (!_testImageView) {
        _testImageView = [[UIImageView alloc] init];
        [_testImageView setBackgroundColor:[UIColor yellowColor]];
    }
    return _testImageView;
}

#pragma mark - EVENT
- (void)clickTap:(id)sender {
    NSLog(@"%s",__FUNCTION__);
}

- (void)clickTap2:(id)sender {
    NSLog(@"%s",__FUNCTION__);
}

- (void)panGestureRecognize:(UIPanGestureRecognizer *)sender {
    NSLog(@"%s : %ld",__FUNCTION__,(long)sender.state);
}

- (void)tapButtonAction:(id)sender {
    NSLog(@"%s",__FUNCTION__);
}

@end
