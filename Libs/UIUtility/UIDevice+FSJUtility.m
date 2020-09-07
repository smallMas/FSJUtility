//
//  UIDevice+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIDevice+FSJUtility.h"

@implementation UIDevice (FSJUtility)

- (CGFloat)safeTopH {
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (CGFloat)safeBottomH {
    CGFloat bottomH = 0;
    if (@available(iOS 11.0, *)) {
        bottomH = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    } else {
        // Fallback on earlier versions
    }
    return bottomH;
}

@end
