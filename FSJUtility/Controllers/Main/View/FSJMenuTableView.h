//
//  FSJMenuTableView.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSJMenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSJMenuTableView : CHGBaseView
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) NSArray <FSJMenuModel *>*dataArray;
@end

NS_ASSUME_NONNULL_END
