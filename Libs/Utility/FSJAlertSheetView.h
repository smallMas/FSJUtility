//
//  FSJAlertSheetView.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSJAlertSheetView : NSObject

@property (nonatomic, weak) UIViewController *vc;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)addTitle:(NSString *)title;

- (void)show:(void (^)(NSInteger index))block;

// 设置style，index，不包括取消按钮
- (void)setActionStyle:(UIAlertActionStyle)style index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
