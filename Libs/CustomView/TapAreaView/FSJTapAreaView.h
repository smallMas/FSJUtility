//
//  FSJTapAreaView.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSJTapAreaView : UIView

// 扩大View热区的比例系数(曲线救国)
@property (nonatomic, copy) NSString *fsj_clickArea;
@end

NS_ASSUME_NONNULL_END
