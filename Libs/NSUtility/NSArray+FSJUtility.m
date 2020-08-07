//
//  NSArray+FSJUtility.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "NSArray+FSJUtility.h"
#import "NSObject+FSJUtility.h"

NSString *const FsjFirstLetter = @"firstLetter";
NSString *const FsjContent = @"content";

#define HANZI_START 19968
#define HANZI_COUNT 20902

@implementation NSArray (FSJUtility)

#pragma mark - json转换
/*! array转json字符串 */
- (NSString *)fsj_toJsonString {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - 字母分类
/*!
 * @brief 按拼音首字母分类
 *
 * @param key model的属性名
 */
- (NSArray *)fsj_arrayWithPinYinFirstCharWithKey:(NSString *)key {
    if (![self count]) {
        return [NSMutableArray array];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSMutableArray array] forKey:@"#"];
    for (int i = 'A'; i <= 'Z'; i++) {
        [dict setObject:[NSMutableArray array]
                 forKey:[NSString stringWithUTF8String:(const char *)&i]];
    }
    
    for (NSObject *ob in self) {
        NSString *name;
        if ([ob isKindOfClass:[NSString class]]) {
            name = (NSString *)ob;
        }else {
            name = [self nameWithKey:key object:ob];
        }
        NSString *firstLetter = [self getFirstLetter:name];
        NSMutableArray *array = dict[firstLetter];
        [array addObject:ob];
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 'A'; i <= 'Z'; i++) {
        NSString *firstLetter = [NSString stringWithUTF8String:(const char *)&i];
        NSMutableArray *array = dict[firstLetter];
        if ([array count]) {
            [array sortUsingComparator:^NSComparisonResult(NSObject *obj1, NSObject* obj2) {
                NSString *word1 = [self nameWithKey:key object:obj1];
                NSString *word2 = [self nameWithKey:key object:obj2];
                return [word1 localizedCompare:word2];
            }];
            NSDictionary *resultDict = @{FsjFirstLetter: firstLetter,
                                         FsjContent: array};
            [resultArray addObject:resultDict];
        }
    }
    
    if ([dict[@"#"] count]) {
        NSMutableArray *array = dict[@"#"];
        [array sortUsingComparator:^NSComparisonResult(NSObject *obj1, NSObject* obj2) {
            NSString *word1 = [self nameWithKey:key object:obj1];
            NSString *word2 = [self nameWithKey:key object:obj2];
            return [word1 localizedCompare:word2];
        }];
        NSDictionary *resultDict = @{FsjFirstLetter: @"#",
                                     FsjContent: array};
        [resultArray addObject:resultDict];
    }
    return resultArray;
}

- (NSString *)nameWithKey:(NSString *)key object:(NSObject *)ob {
    if ([ob isKindOfClass:[NSString class]]) {
        return (NSString *)ob;
    }
    NSArray *keys = [key componentsSeparatedByString:@"."];
    if (keys.count == 1) {
        return (NSString *)[self nameKey:key object:ob];
    }else {
        NSObject *name = ob;
        for (NSString *k in keys) {
            name = [self nameKey:k object:name];
        }
        return (NSString *)name;
    }
}

- (NSObject *)nameKey:(NSString *)key object:(NSObject *)ob {
    return [ob valueForKey:key];
}

// 汉字转化拼音，获取首字母 参考：https://github.com/yangguanghei/OrderBypin-yin
- (NSString *)getFirstLetter:(NSString *)name {
    if (!FSJ_ObjectIsNullAndEmpty(name)) {
        /**
         * **************************************** START ***************************************
         * 参考博主-庞海礁先生的一文:iOS开发中如何更快的实现汉字转拼音 http://www.olinone.com/?p=131
         * 使PPGetAddressBook对联系人排序的性能提升 3~6倍, 非常感谢!
         */
        NSMutableString *mutableString = [NSMutableString stringWithString:name];
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
        NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        /**
         *  *************************************** END ******************************************
         */
        
        // 将拼音首字母装换成大写
        NSString *strPinYin = [[self polyphoneStringHandle:name pinyinString:pinyinString] uppercaseString];
        // 截取大写首字母
        NSString *firstString = [strPinYin substringToIndex:1];
        // 判断姓名首位是否为大写字母
        NSString * regexA = @"^[A-Z]$";
        NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
        // 获取并返回首字母
        return [predA evaluateWithObject:firstString] ? firstString : @"#";
    }else {
        return @"#";
    }
}

/**
 多音字处理
 */
- (NSString *)polyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString
{
    if ([aString hasPrefix:@"长"]) { return @"chang";}
    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
    if ([aString hasPrefix:@"地"]) { return @"di";   }
    if ([aString hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}


@end
