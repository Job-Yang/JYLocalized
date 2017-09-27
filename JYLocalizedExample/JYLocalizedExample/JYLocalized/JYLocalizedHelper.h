//
//  JYLocalizedHelper.h
//  360zebra
//
//  Created by 杨权 on 2016/11/2.
//  Copyright © 2016年 360zebra. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JYLocalizedString(key, comment) \
        [[JYLocalizedHelper standardHelper] stringWithKey:key]

#define JYBundle [[JYLocalizedHelper standardHelper] bundle]

FOUNDATION_EXPORT NSString *const kTableDefault;
FOUNDATION_EXPORT NSString *const kTableCodeMapping;

@interface JYLocalizedHelper : NSObject

/**
 单例

 @return JYLocalizedHelper类对象
 */
+ (instancetype)standardHelper;

/**
 当前bundle

 @return bundle
 */
- (NSBundle *)bundle;

/**
 用户选择的语言，如果用户没有选择，则返回系统默认语言

 @return 当前语言
 */
- (NSString *)currentLanguage;

/**
 设置语言

 @param language 语言
 */
- (void)setUserLanguage:(NSString *)language;

/**
 多语言字符串
 如果该表中未查到该key多对应的多语言字符串，将会返回该key
 
 @param key 字符串的Key
 @return 多语言字符串
 */
- (NSString *)stringWithKey:(NSString *)key;

/**
 多语言字符串
 如果该表中未查到该key多对应的多语言字符串，将会返回该key
 
 @param key 字符串的Ke
 @param tableName 来自的多语言表
 @return 多语言字符串
 */
- (NSString *)stringWithKey:(NSString *)key
                      table:(NSString *)tableName;

@end
