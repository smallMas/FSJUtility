//
//  FSJFrameMacro.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//

// 判断是否是ipad
#define kfsj_ipad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kfsj_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kfsj_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kfsj_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kfsj_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define kfsj_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define kfsj_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define kfsj_iPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define kfsj_iPhoneXsMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

/**屏幕尺寸*/
#define FSJSCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define FSJSCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define FSJAppStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define FSJAppNavBarHeight 44
#define FSJAppSafeTopH ((kfsj_iPhoneX == YES || kfsj_iPhoneXr == YES || kfsj_iPhoneXs == YES || kfsj_iPhoneXsMax == YES) ? 44.0 : App_Status_H)
#define FSJAppSafeBottomH ((kfsj_iPhoneX == YES || kfsj_iPhoneXr == YES || kfsj_iPhoneXs == YES || kfsj_iPhoneXsMax == YES) ? 34.0 : 0.0)


#define fsj_weakify(object) autoreleasepool   {} __weak  typeof(object) weak##object = object;
#define fsj_strongify(object) autoreleasepool {} __strong  typeof(weak##object) object = weak##object;
#define FSJ_WEAK_SELF @fsj_weakify(self)
#define FSJ_STRONG_SELF @fsj_strongify(self)
