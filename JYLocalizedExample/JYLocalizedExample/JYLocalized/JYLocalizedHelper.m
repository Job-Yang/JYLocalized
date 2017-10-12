//
//  JYLocalizedHelper.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2016/11/2.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYLocalizedHelper.h"

NSString *const kTableDefault = @"Localizable";
NSString *const kTableCodeMapping = @"CodeLocalizable";

NSString *const kUserLanguage = @"kUserLanguage";

@interface JYLocalizedHelper()
@property (strong, nonatomic) NSBundle *bundle;
@end

@implementation JYLocalizedHelper

#pragma mark - life cycle
+ (instancetype)helper {
    static JYLocalizedHelper *_helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _helper = [[JYLocalizedHelper alloc] init];
    });
    return _helper;
}

- (instancetype)init {
    if (self = [super init]) {
        [self bundle];
    }
    return self;
}

#pragma mark - setup methods
- (void)setUserLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
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
    NSString *string = [self.bundle localizedStringForKey:key value:nil table:tableName ?: kTableDefault];
    if (!string) {
        return key;
    }
    return string;
}

#pragma mark - getter & setter
- (NSBundle *)bundle {
    if (!_bundle) {
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
        _bundle = [NSBundle bundleWithPath:path];
    }
    return _bundle;
}

@end
