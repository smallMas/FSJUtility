//
//  FSJTabContainView.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/20.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTabContainView.h"

@interface FSJTabContainView () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation FSJTabContainView

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pageController.view.frame = self.bounds;
}


-(void)setScrollType:(FSJScrollType)scrollType {
    if (!_pageController) {
        if (scrollType == FSJScrollTypeUpAndDown) {
             _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
        }else if (scrollType == FSJScrollTypeLeftAndRight){
             _pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        }
    }
    _pageController.delegate = self;
    _pageController.dataSource = self;
    _pageController.view.frame=self.bounds;
    [self addSubview:_pageController.view];
}
- (void)setTabIndex:(NSInteger)index {
    [self setTabIndex:index animated:NO];
}

- (void)setTabIndex:(NSInteger)index animated:(BOOL)animated {
    if (self.currentIndex > index) {
        [self.pageController setViewControllers:[NSArray arrayWithObject:[self pageControllerAtIndex:index]] direction:UIPageViewControllerNavigationDirectionReverse animated:animated completion:nil];
    }else {
        [self.pageController setViewControllers:[NSArray arrayWithObject:[self pageControllerAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:nil];
    }
    _currentIndex = index;
}

- (void)configControllers:(NSMutableArray<UIViewController*>*)controllers index:(NSInteger)index {
    _controllers = controllers;
    [self setTabIndex:index];
}

- (void)configControllers:(NSMutableArray<UIViewController*>*)controllers parentController:(UIViewController *)parentVC {
    [self configControllers:controllers parentController:parentVC index:0];
}

- (void)configControllers:(NSMutableArray<UIViewController*>*)controllers parentController:(UIViewController *)parentVC index:(NSInteger)index {
    if (!_pageController) {
        [self setScrollType:FSJScrollTypeLeftAndRight];
    }
    [parentVC addChildViewController:self.pageController];
    [self configControllers:controllers index:index];
}

- (UIScrollView *)findScrollView {
    UIScrollView *scrollView = nil;
    for(UIView *eachSubview in self.pageController.view.subviews) {
        if([eachSubview isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)eachSubview;
            break;
        }
    }
    return scrollView;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    
    UIScrollView *scrollView = [self findScrollView];
    scrollView.scrollEnabled = scrollEnabled;
}

#pragma mark - UIPageViewControllerDelegate UIPageViewControllerDataSource
//返回下一个页面
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [_controllers indexOfObject:viewController];
    if(index == (_controllers.count-1)){
        return nil;
    }
    index++;
    return [self pageControllerAtIndex:index];
}

//返回前一个页面
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    //判断当前这个页面是第几个页面
    NSInteger index = [_controllers indexOfObject:viewController];
    //如果是第一个页面
    if(index==0){
        return nil;
    }
    index--;
    return [self pageControllerAtIndex:index];
}

//根据tag值创建内容页面
- (UIViewController*)pageControllerAtIndex:(NSInteger)index{
    return [self.controllers objectAtIndex:index];
}

//结束滑动的时候触发
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger index = [_controllers indexOfObject:pageViewController.viewControllers[0]];
    if (self.switchBlock) {
        self.switchBlock(index);
    }
    _currentIndex = index;
}

//开始滑动的时候触发
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
}

@end
