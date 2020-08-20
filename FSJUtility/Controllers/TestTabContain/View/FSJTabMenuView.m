//
//  FSJTabMenuView.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/20.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTabMenuView.h"
#import "FSJTabMenuCell.h"
#import "FSJCycleLayout.h"

@interface FSJTabMenuView ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FSJCycleLayout *layout;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger currentIndex;

// 中心红点
@property (nonatomic, strong) UIView *redDotView;

@end

@implementation FSJTabMenuView

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array {
    if (self = [super initWithFrame:frame]) {
        _textColor = [UIColor blackColor];
        _textFont = [UIFont systemFontOfSize:15];
        _dataArray = array;
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[FSJTabMenuCell class] forCellWithReuseIdentifier:NSStringFromClass([FSJTabMenuCell class])];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _redDotView = [[UIView alloc] init];
    [self.redDotView fsj_setRoundRadius:4 borderColor:[UIColor clearColor]];
    [self.redDotView setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.redDotView];
    [self.redDotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(8);
        make.bottom.mas_equalTo(self).inset(10);
        make.centerX.mas_equalTo(self);
    }];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    [self.collectionView reloadData];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self.collectionView reloadData];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.delegate = (id <UICollectionViewDelegate>)self;
        _collectionView.dataSource = (id <UICollectionViewDataSource>)self;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (FSJCycleLayout *)layout {
    if (!_layout) {
        _layout = [[FSJCycleLayout alloc] init];
        _layout.itemSize = CGSizeMake(50, self.fsj_height);
        _layout.minimumLineSpacing = 20;
        _layout.minimumInteritemSpacing = 20;
    }
    return _layout;
}

- (BOOL)judgeIsCenterIndexPath:(NSIndexPath *)indexPath {
    CGPoint currentPoint = [self convertPoint:self.collectionView.center toView:self.collectionView];
    NSIndexPath *currentPath = [self.collectionView indexPathForItemAtPoint:currentPoint];
    if (currentPath.row == indexPath.row) {
        return YES;
    }else {
        return NO;
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self.collectionView reloadData];
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated {
    [self setSelectedIndex:index animated:animated isBackDelegate:NO];
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated isBackDelegate:(BOOL)isBackDelegate {
    CGPoint point = CGPointMake(index*(self.layout.itemSize.width+self.layout.minimumLineSpacing)-self.collectionView.fsj_width*0.5+self.layout.itemSize.width*0.5, 0);
    [self.collectionView setContentOffset:point animated:animated];
    if (animated) {
        [self performSelector:@selector(setPageIndex:) withObject:@{@"index":@(index),@"isBack":@(isBackDelegate)} afterDelay:animated?0.3:NO];
    }else {
        [self setPageIndex:@{@"index":@(index),@"isBack":@(isBackDelegate)}];
    }
}

- (void)setPageIndex:(NSDictionary *)userInfo {
    if (userInfo) {
        NSNumber *number = userInfo[@"index"];
        NSNumber *isBack = userInfo[@"isBack"];
        if (number) {
            self.currentIndex = number.integerValue;
            if (isBack && isBack.boolValue) {
                [self backDelegateMethodIndex:number.integerValue];
            }
        }
    }
}

- (void)backDelegateMethodIndex:(NSInteger)index {
    if (self.selectedBlock) {
        self.selectedBlock(index);
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {return self.dataArray.count;}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FSJTabMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FSJTabMenuCell class]) forIndexPath:indexPath];
    [cell configText:self.dataArray[indexPath.row] isCenter:[self judgeIsCenterIndexPath:indexPath]];
    cell.txtLabel.textColor = self.textColor;
    cell.txtLabel.font = self.textFont;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self judgeIsCenterIndexPath:indexPath] == NO) {
        [self setSelectedIndex:indexPath.row animated:YES isBackDelegate:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {return CGSizeMake(50, self.fsj_height);}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {return UIEdgeInsetsZero;}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currentPoint = [self convertPoint:self.collectionView.center toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:currentPoint];
    self.currentIndex = indexPath.row;
    [self backDelegateMethodIndex:indexPath.row];
}

@end
