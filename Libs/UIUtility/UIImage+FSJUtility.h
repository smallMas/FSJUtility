//
//  UIImage+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FSJUtility)

#pragma mark - 图片处理
/// 矫正图片方向 （一般自定义相机拍照时方向有问题）
- (UIImage *)fsj_fixOrientation;

#pragma mark - 生成图片
/// 二维码生成(Erica Sadun 原生代码生成)
/// @param string 内容字符串
/// @param size 二维码大小
/// @param color 二维码颜色
/// @param backGroundColor 背景颜色
+ (UIImage *)fsj_qrImageWithString:(NSString *)string size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;

/// 条形码生成(Third party)
/// @param code 内容字符串
/// @param size 条形码大小
/// @param color 条形码颜色
/// @param backGroundColor 背景颜色
+ (UIImage *)fsj_generateBarCode:(NSString *)code size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;

#pragma mark - 裁剪
/// 获取圆形图片
- (UIImage *)fsj_clipCircularImage;

/// 获得裁剪后的图片
+ (UIImage *)fsj_cropImageView:(UIImageView *)imageView
                        toRect:(CGRect)rect
                     zoomScale:(double)zoomScale
                 containerView:(UIView *)containerView;

@end

NS_ASSUME_NONNULL_END
