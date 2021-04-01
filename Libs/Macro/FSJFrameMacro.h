//
//  FSJFrameMacro.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//  https://www.apple.com.cn/iphone/compare/?device1=iphone11promax&device2=iphone11pro&device3=iphoneXS

#define FSJ_Window \
({UIWindow *window = nil;\
if (@available(iOS 13.0, *)) {\
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {\
        if (windowScene.activationState == UISceneActivationStateForegroundActive) {\
            window = windowScene.windows.firstObject;\
            break;\
        }\
    }\
}else {\
    window = [[UIApplication sharedApplication].delegate window];\
}\
(window);})

#define FSJSafeAreaEdgeInsets \
({UIEdgeInsets safeEdgeInsets = UIEdgeInsetsZero;\
if (@available(iOS 11.0, *)) {\
safeEdgeInsets = FSJ_Window.safeAreaInsets;\
}\
(safeEdgeInsets);})

/**屏幕尺寸*/
#define FSJSCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define FSJSCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define FSJAppStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define FSJAppNavBarHeight 44
#define FSJAppSafeTopH FSJAppStatusHeight
#define FSJAppSafeBottomH FSJSafeAreaEdgeInsets.bottom

#define fsj_weakify(object) autoreleasepool   {} __weak  typeof(object) weak##object = object;
#define fsj_strongify(object) autoreleasepool {} __strong  typeof(weak##object) object = weak##object;
#define FSJ_WEAK_SELF @fsj_weakify(self)
#define FSJ_STRONG_SELF @fsj_strongify(self)
