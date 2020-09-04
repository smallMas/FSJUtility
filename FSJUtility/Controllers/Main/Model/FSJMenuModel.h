//
//  FSJMenuModel.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/12.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FSJMenuModel : FSJBaseModel
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *vcString;
@property (nonatomic, assign) CGSize size; // collection

+ (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title;
+ (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title size:(CGSize)size;
+ (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title clsString:(NSString * __nullable )clsString;
+ (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title clsString:(NSString * __nullable )clsString size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
