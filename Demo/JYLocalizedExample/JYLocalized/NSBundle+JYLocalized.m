//
//  NSBundle+JYLocalized.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/10/18.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "NSBundle+JYLocalized.h"

NSString *const kTableDefault     = @"Localizable";
NSString *const kTableCodeMapping = @"CodeLocalizable";
NSString *const kUserLanguage     = @"kUserLanguage";

@implementation NSBundle (JYLocalized)

static NSBundle *_localizedBundle = nil;

#pragma mark - life cycle
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(localizedStringForKey:value:table:);
        SEL swizzledSelector = @selector(jy_localizedStringForKey:value:table:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling
- (NSString *)jy_localizedStringForKey:(NSString *)key value:(nullable NSString *)value table:(nullable NSString *)tableName {
    NSString *string = [NSBundle.localizedBundle jy_localizedStringForKey:key value:nil table:tableName ?: kTableDefault];
    return string ?: key;
}

#pragma mark - setup methods
+ (NSBundle *)setupLocalizedBundle {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userLanguage = [defaults objectForKey:kUserLanguage];
    //用户未手动设置过语言
    if (userLanguage.length == 0) {
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        NSString *systemLanguage = languages.firstObject;
        userLanguage = systemLanguage;
    }
    //将香港和台湾的繁体统统转为繁体
    if ([userLanguage isEqualToString:@"zh-HK"] || [userLanguage isEqualToString:@"zh-TW"]) {
        userLanguage = @"zh-Hant";
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:userLanguage ofType:@"lproj"];
    return [NSBundle bundleWithPath:path];
}

#pragma mark - public methods
- (void)setUserLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    [NSBundle setLocalizedBundle:[NSBundle bundleWithPath:path]];
    [defaults setObject:language forKey:kUserLanguage];
    [defaults synchronize];
}

- (NSString *)currentLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userLanguage = [defaults objectForKey:kUserLanguage];
    
    if (userLanguage.length == 0) {
        NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
        NSString *systemLanguage = languages.firstObject;
        return systemLanguage;
    }
    return userLanguage;
}

- (NSString *)stringWithKey:(NSString *)key {
    return [self stringWithKey:key table:kTableDefault];
}

- (NSString *)stringWithKey:(NSString *)key table:(NSString *)tableName {
    return [self jy_localizedStringForKey:key value:nil table:tableName ?: kTableDefault];
}

#pragma mark - getter & setter
+ (NSBundle *)localizedBundle {
    if (!_localizedBundle) {
        _localizedBundle = [NSBundle setupLocalizedBundle];
    }
    return _localizedBundle;
}

+ (void)setLocalizedBundle:(NSBundle *)localizedBundle {
    _localizedBundle = localizedBundle;
}

@end
