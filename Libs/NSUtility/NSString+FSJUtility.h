//
//  NSString+FSJUtility.h
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FSJUtility)

#pragma mark - json转换
/// 字符串转json对象 dictionary/array
- (id)fsj_toJsonObject;

#pragma mark - 加密
/// md5 32位
- (NSString *)fsj_MD5_32;
/// md5 16位
- (NSString *)fsj_MD5_16;
/// AES128位加密
- (NSString *)fsj_AES128EncryptKey:(NSString *)key;
/// AES128位解密
- (NSString *)fsj_AES128DecryptKey:(NSString *)key;
/// AES256位加密
- (NSString *)fsj_AES256EncryptKey:(NSString *)key;
/// AES256位解密
- (NSString *)fsj_AES256DecryptKey:(NSString *)key;
/// BASE64加密
- (NSString *)fsj_base64Encode;
/// BASE64解密
- (NSString *)fsj_base64Decode;

#pragma mark - 转换
/// 汉字转拼音
- (NSString *)fsj_pinyinString;

/// 根据拼音获取对应的汉字
/// @param pinyin 拼音
- (NSString *)fsj_matchWithPinyin:(NSString *)pinyin;

#pragma mark - 计算文本长度
/// 计算文本宽度
- (CGFloat)fsj_calculateWidthWithFont:(UIFont *)font size:(CGSize)size;
/// 计算高度
- (CGFloat)fsj_calculateHeightWithFont:(UIFont *)font size:(CGSize)size;
/// 计算文本rect
- (CGRect)fsj_calculateRectWithFont:(UIFont *)font size:(CGSize)size;

#pragma mark - 使用正则表达式判断
/// 使用正则表达式校验字符串
- (BOOL)fsj_checkWithPredicate:(NSString *)preStr;
/// 判断邮箱
- (BOOL)fsj_isEmail;
/// 判断大陆手机号
- (BOOL)fsj_isMobilePhone;
/// 判断香港手机号
- (BOOL)fsj_isHongKongMobilePhone;
/// 判断澳门手机号
- (BOOL)fsj_isMacaoMobilePhone;
/// 判断台湾手机号
- (BOOL)fsj_isTarwanMobilePhone;

#pragma mark - 过滤
/// 过滤html标签
- (NSString *)fsj_filterHTML;
/// 去掉字符串两端的空格及回车
- (NSString *)fsj_removeSpaceAndNewAtBothEndsLine;
/// 匹配链接字符串
- (NSArray *)fsj_matchUrl;

#pragma mark - 字符串处理
/// 获取字符串的字节数
- (NSInteger)fsj_numberOfBytes;
//按字节数截取字符串
- (NSString *)fsj_stringAtIndexWithByteCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
