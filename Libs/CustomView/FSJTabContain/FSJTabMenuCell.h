//
//  FSJTabMenuCell.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/20.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSJTabMenuCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *txtLabel;
- (void)configText:(NSString *)text isCenter:(BOOL)isCenter;
@end

NS_ASSUME_NONNULL_END
