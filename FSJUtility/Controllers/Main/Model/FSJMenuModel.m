//
//  FSJMenuModel.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/12.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJMenuModel.h"

@implementation FSJMenuModel
+ (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title {
    return [self createMenuType:type title:title clsString:nil];
}

+ (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title size:(CGSize)size {
    return [self createMenuType:type title:title clsString:nil size:size];
}

+ (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title clsString:(NSString *)clsString {
    return [self createMenuType:type title:title clsString:clsString size:CGSizeZero];
}

+ (FSJMenuModel *)createMenuType:(NSInteger)type title:(NSString *)title clsString:(NSString *)clsString size:(CGSize)size {
    NSString *text = title;
    FSJMenuModel *model = [[self class] new];
    model.type = type;
    model.text = text;
    model.vcString = clsString;
    model.size = size;
    return model;
}

#pragma mark - CHGTableViewCellModelProtocol
- (NSString*)cellClassNameInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return @"FSJMenuTableCell";
}

- (CGFloat)cellHeighInTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    return 44;
}

#pragma mark - CHGCollectionViewCellModelProtocol
- (NSString*)cellClassNameInCollectionView:(UICollectionView*)collectionView atIndexPath:(NSIndexPath*)indexPath {
    return @"FSJMenuCollectionCell";
}

- (CGSize)chg_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.size;
}

@end
