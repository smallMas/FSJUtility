//
//  FSJTabMenuView.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/20.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ FSJSelectedMenuBlock)(NSInteger index);

@interface FSJTabMenuView : UIView

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, copy) FSJSelectedMenuBlock selectedBlock;

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
