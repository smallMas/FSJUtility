//
//  NSString+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "NSString+FSJUtility.h"
#import "CommonCrypto/CommonDigest.h"
#import <CommonCrypto/CommonCryptor.h>  //DES 加密

@implementation NSString (FSJUtility)

#pragma mark - json转换
/// 字符串转json对象 dictionary/array
- (id)fsj_toJsonObject {
    NSError *error;
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
}

#pragma mark - 加密
/// md5
- (NSString *)fsj_MD5_32 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

/// md5 16位
- (NSString *)fsj_MD5_16 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X",
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11]
             ] lowercaseString];
}

/// AES128位加密
- (NSString *)fsj_AES128EncryptKey:(NSString *)key {
    return [self fsj_AESEncryptKey:key kCCKeySize:kCCKeySizeAES128];
}

/// AES128位解密
- (NSString *)fsj_AES128DecryptKey:(NSString *)key {
    return [self fsj_AESDecryptKey:key kCCKeySize:kCCKeySizeAES128];
}

/// AES256位加密
- (NSString *)fsj_AES256EncryptKey:(NSString *)key {
    return [self fsj_AESEncryptKey:key kCCKeySize:kCCKeySizeAES256];
}

/// AES256位解密
- (NSString *)fsj_AES256DecryptKey:(NSString *)key {
    return [self fsj_AESDecryptKey:key kCCKeySize:kCCKeySizeAES256];
}

//AES128位加密 base64编码 注：kCCKeySizeAES128点进去可以更换256位加密
- (NSString *)fsj_AESEncryptKey:(NSString *)key kCCKeySize:(NSInteger)kCCKeySize {
    char keyPtr[kCCKeySize+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSString *stringBase64 = [resultData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; // base64格式的字符串
        return stringBase64;
        
    }
    free(buffer);
    return nil;
}

// AES解密
- (NSString *)fsj_AESDecryptKey:(NSString *)key kCCKeySize:(NSInteger)kCCKeySize {
    char keyPtr[kCCKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];//base64解码
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}

- (NSString *)fsj_base64Encode {
    //1、先转换成二进制数据
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //2、对二进制数据进行base64编码，完成后返回字符串
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)fsj_base64Decode {
    //注意：该字符串是base64编码后的字符串
    //1、转换为二进制数据（完成了解码的过程）
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    //2、把二进制数据转换成字符串
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - 转换
/// 汉字转拼音
- (NSString *)fsj_pinyinString {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    if (pinyinString) {
        // 去掉空格
        pinyinString = [pinyinString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return pinyinString;
}

/// 根据拼音获取对应的汉字
/// @param pinyin 拼音
- (NSString *)fsj_matchWithPinyin:(NSString *)pinyin {
    if (pinyin) {
        if ([self containsString:pinyin]) {
            return pinyin;
        }else {
            NSString *string = [pinyin lowercaseString];
            // 拼音
            NSString *marchString = @"";
            NSString *result = nil;
            NSString *temp = nil;
            for(int i =0; i < [self length]; i++)
            {
                temp = [self substringWithRange:NSMakeRange(i, 1)];
                marchString = [marchString stringByAppendingString:temp];
                NSString *singlePinyin = [marchString fsj_pinyinString];
                if ([singlePinyin containsString:string]) {
                    result = marchString;
                    break;
                }
                if (![string containsString:singlePinyin]) {
                    marchString = @"";
                }
            }
            return result;
        }
    }
    return nil;
}

#pragma mark - 计算文本长度
/// 计算文本宽度
- (CGFloat)fsj_calculateWidthWithFont:(UIFont *)font size:(CGSize)size {
    CGRect rect = [self fsj_calculateRectWithFont:font size:size];
    return ceil(rect.size.width);
}

/// 计算高度
- (CGFloat)fsj_calculateHeightWithFont:(UIFont *)font size:(CGSize)size {
    CGRect rect = [self fsj_calculateRectWithFont:font size:size];
    return ceil(rect.size.height);
}

/// 计算文本rect
- (CGRect)fsj_calculateRectWithFont:(UIFont *)font size:(CGSize)size {
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return rect;
}

#pragma mark - 使用正则表达式判断
/// 使用正则表达式校验字符串
- (BOOL)fsj_checkWithPredicate:(NSString *)preStr {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", preStr];
    return [predicate evaluateWithObject:self];
}

/// 判断邮箱
- (BOOL)fsj_isEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self fsj_checkWithPredicate:regex];
}

/// 判断大陆手机号
- (BOOL)fsj_isMobilePhone {
    NSString *regex = @"^1[0-9][0-9]\\d{8}";
    return [self fsj_checkWithPredicate:regex];
}

/// 判断香港手机号
- (BOOL)fsj_isHongKongMobilePhone {
    NSString *regex = @"^([5|6|9])\\d{7}$";
    return [self fsj_checkWithPredicate:regex];
}

/// 判断澳门手机号
- (BOOL)fsj_isMacaoMobilePhone {
    NSString *regex = @"^[6][6|8]\\d{5}$";
    return [self fsj_checkWithPredicate:regex];
}

/// 判断台湾手机号
- (BOOL)fsj_isTarwanMobilePhone {
    NSString *regex = @"^[0][9]\\d{8}$";
    return [self fsj_checkWithPredicate:regex];
}

#pragma mark - 过滤
/// 过滤html标签
- (NSString *)fsj_filterHTML {
    NSString *string = self;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSString *text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        string = [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return string;
}

/// 去掉字符串两端的空格及回车
- (NSString *)fsj_removeSpaceAndNewAtBothEndsLine {
    NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return text;
}

#pragma mark - 字符串处理
/// 获取字符串的字节数
- (NSInteger)fsj_numberOfBytes {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength;
    return unicodeLength;
}

//按字节数截取字符串
- (NSString *)fsj_stringAtIndexWithByteCount:(NSInteger)count {
    int i;
    int sum=0;
    for(i=0;i<[self length];i++)
    {
        unichar str = [self characterAtIndex:i];
        if(str < 256){
            sum+=1;
        }
        else {
            sum+=2;
        }
        if(sum>count){
//当字符大于count时，剪取三个位置，显示省略号。否则正常显示
            NSString * str=[self substringWithRange:NSMakeRange(0,[self fsj_charAtIndexWithByteCount:count])];
                                                                 
            return str;
        }
    }
    return self;
}

- (NSInteger)fsj_charAtIndexWithByteCount:(NSInteger)count {
    int i;
    int sum=0;
    int count2=0;
    for(i=0;i<[self length];i++)
    {
        unichar str = [self characterAtIndex:i];
        if(str < 256){
            sum+=1;
        }
        else {
            sum+=2;
        }
        count2++;
        if (sum>=count){
            break;
        }
    }
    if(sum>count){
        return count2-1;
    }
    else
    return count2;
}

@end
