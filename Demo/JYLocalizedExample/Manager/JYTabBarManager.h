//
//  JYTabBarManager.h
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/7/31.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"
#import "JYTabBarPlusButton.h"

@interface JYTabBarManager : NSObject

/**
 tabBarController
 */
@property (strong, nonatomic) CYLTabBarController *tabBarController;

/**
 单例
 
 @return 单例对象
 */
+ (instancetype)manager;

/**
 注册TabBar（在didFinishLaunchingWithOptions调用）
 */
- (void)registerTabBar;

/**
 重新设置TabBarController
 用于切换语言
 */
- (void)resetTabBarController;

@end
