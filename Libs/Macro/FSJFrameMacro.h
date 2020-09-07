//
//  FSJFrameMacro.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//  https://www.apple.com.cn/iphone/compare/?device1=iphone11promax&device2=iphone11pro&device3=iphoneXS

// 判断是否是ipad
#define kfsj_ipad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhoneX,Xs
#define kfsj_iPhoneX (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] nativeBounds].size) && !kfsj_ipad)
// 判断iPHoneXr
#define kfsj_iPhoneXr (CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] nativeBounds].size) && !kfsj_ipad)
// 判断iPhoneXs Max
#define kfsj_iPhoneXsMax (CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] nativeBounds].size) && !kfsj_ipad)

/**屏幕尺寸*/
#define FSJSCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define FSJSCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define FSJAppStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define FSJAppNavBarHeight 44
#define FSJAppSafeTopH ((kfsj_iPhoneX == YES || kfsj_iPhoneXr == YES || kfsj_iPhoneXsMax == YES) ? 44.0 : App_Status_H)
#define FSJAppSafeBottomH ((kfsj_iPhoneX == YES || kfsj_iPhoneXr == YES || kfsj_iPhoneXsMax == YES) ? 34.0 : 0.0)

#define fsj_weakify(object) autoreleasepool   {} __weak  typeof(object) weak##object = object;
#define fsj_strongify(object) autoreleasepool {} __strong  typeof(weak##object) object = weak##object;
#define FSJ_WEAK_SELF @fsj_weakify(self)
#define FSJ_STRONG_SELF @fsj_strongify(self)
