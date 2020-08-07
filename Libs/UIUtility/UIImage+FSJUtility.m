//
//  UIImage+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "UIImage+FSJUtility.h"

@implementation UIImage (FSJUtility)

#pragma mark - 图片处理
/// 矫正图片方向 （一般自定义相机拍照时方向有问题）http://www.cocoachina.com/articles/12021
- (UIImage *)fsj_fixOrientation {
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


#pragma mark - 生成图片
+ (UIImage *)fsj_resizeImageWithoutInterpolation:(UIImage *)sourceImage size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationNone);
    [sourceImage drawInRect:(CGRect){.size = size}];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)fsj_imageWithCIImage:(CIImage *)aCIImage orientation: (UIImageOrientation)anOrientation {
    if (!aCIImage) return nil;
    CGImageRef imageRef = [[CIContext contextWithOptions:nil] createCGImage:aCIImage fromRect:aCIImage.extent];
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:anOrientation];
    CFRelease(imageRef);
    return image;
}

/// 二维码生成(Erica Sadun 原生代码生成)
/// @param string 内容字符串
/// @param size 二维码大小
/// @param color 二维码颜色
/// @param backGroundColor 背景颜色
+ (UIImage *)fsj_qrImageWithString:(NSString *)string size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor {
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    if (!qrFilter)
    {
        NSLog(@"Error: Could not load filter");
        return nil;
    }

    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    CIFilter * colorQRFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorQRFilter setValue:qrFilter.outputImage forKey:@"inputImage"];
    //二维码颜色
    if (color == nil) {
        color = [UIColor blackColor];
    }
    if (backGroundColor == nil) {
        backGroundColor = [UIColor whiteColor];
    }
    [colorQRFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    //背景颜色
    [colorQRFilter setValue:[CIColor colorWithCGColor:backGroundColor.CGColor] forKey:@"inputColor1"];

    CIImage *outputImage = [colorQRFilter valueForKey:@"outputImage"];
    
    UIImage *smallImage = [self fsj_imageWithCIImage:outputImage orientation: UIImageOrientationUp];
    
    return [self fsj_resizeImageWithoutInterpolation:smallImage size:size];
}

/// 条形码生成(Third party)
/// @param code 内容字符串
/// @param size 条形码大小
/// @param color 条形码颜色
/// @param backGroundColor 背景颜色
+ (UIImage *)fsj_generateBarCode:(NSString *)code size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor {
    // 生成条形码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    //设置条形码颜色和背景颜色
    CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setValue:filter.outputImage forKey:@"inputImage"];
    //条形码颜色
    if (color == nil) {
        color = [UIColor blackColor];
    }
    if (backGroundColor == nil) {
        backGroundColor = [UIColor whiteColor];
    }
    [colorFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    //背景颜色
    [colorFilter setValue:[CIColor colorWithCGColor:backGroundColor.CGColor] forKey:@"inputColor1"];
    
    barcodeImage = [colorFilter outputImage];
    
    // 消除模糊
    CGFloat scaleX = size.width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = size.height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

@end
