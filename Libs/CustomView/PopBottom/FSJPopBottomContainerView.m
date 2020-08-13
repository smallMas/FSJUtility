//
//  FSJPopBottomContainerView.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/12.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJPopBottomContainerView.h"

NSString * const kFSJPopBottomCloseDonePressed = @"kFSJPopBottomCloseDonePressed";
NSString * const kFSJPopBottomCloseDoneNoAnimationPressed = @"kFSJPopBottomCloseDoneNoAnimationPressed";

@interface FSJPopBottomContainerView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, weak) UIView *super_view;

@property (nonatomic, copy) FSJPopCloseBlock closeBlock;

@end

@implementation FSJPopBottomContainerView

- (instancetype)initWithSuperView:(UIView *)superView withView:(UIView *)subView {
    _super_view = superView;
    _subView = subView;
    CGRect rect = superView.bounds;
    if (self = [super initWithFrame:rect]) {
        [self __setup];
    }
    return self;
}

- (void)__setup {
    _isTapBack = YES;
    
    [self addSubview:self.bgView];
    CGRect subRect = self.subView.frame;
    CGSize subSize = subRect.size;
    subRect.origin.x = (self.frame.size.width - subSize.width)/2.0f;
    subRect.origin.y = self.frame.size.height;
    self.subView.frame = subRect;
    
    [self addSubview:self.subView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationDissmiss:) name:kFSJPopBottomCloseDonePressed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationNoAnimationDissmiss:) name:kFSJPopBottomCloseDoneNoAnimationPressed object:nil];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        [_bgView setBackgroundColor:[UIColor clearColor]];
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (void)setBackViewColor:(UIColor *)backViewColor {
    [self.bgView setBackgroundColor:backViewColor];
}

#pragma mark - 通知
- (void)notificationDissmiss:(NSNotification *)notification {
    [self dissmiss:YES];
}

- (void)notificationNoAnimationDissmiss:(NSNotification *)notification {
    [self dissmiss:NO];
}

#pragma mark - btn action
- (void)tapAction:(id)sender {
    if (self.isTapBack) {
        [self dissmiss:YES];
    }
}

#pragma mark - 外部调用
- (void)show:(BOOL)animated {
    if (![self removeLastPopoverView]) {
        
    }
    
    [self showAnimation:animated];
}

- (void)showAnimation:(BOOL)animated {
    [self.super_view addSubview:self];
    
    __weak typeof (self) wSelf = self;
    CGRect subRect = self.subView.frame;
    subRect.origin.y = self.frame.size.height-subRect.size.height;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [wSelf.subView setFrame:subRect];
        }];
    }else {
        [self.subView setFrame:subRect];
    }
}

- (void)show:(BOOL)animated block:(FSJPopCloseBlock)block {
    _closeBlock = block;
    [self show:animated];
}

- (BOOL)removeLastPopoverView {
    UIView *lastView = [self.super_view.subviews lastObject];
    if ([lastView isKindOfClass:[FSJPopBottomContainerView class]]) {
        [lastView removeFromSuperview];
        return NO;
    }
    return YES;
}

- (void)dissmiss:(BOOL)animated {
    __weak typeof (self) wSelf = self;
    CGRect subRect = self.subView.frame;
    subRect.origin.y = self.frame.size.height;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [wSelf.subView setFrame:subRect];
        } completion:^(BOOL finished) {
            if (![wSelf removeLastPopoverView]) {
                wSelf.super_view = nil;
            }
            if (self.closeBlock) {
                self.closeBlock();
            }
        }];
    }else {
        [self.subView setFrame:subRect];
        if (![self removeLastPopoverView]) {
            self.super_view = nil;
        }
        if (self.closeBlock) {
            self.closeBlock();
        }
    }
}

@end
