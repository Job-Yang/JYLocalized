//
//  AppDelegate.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/26.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "AppDelegate.h"
#import "JYTabBarManager.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置主窗口,并设置跟控制器
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    // 设置根视图
    [self.window setRootViewController:[JYTabBarManager manager].tabBarController];
    [[JYTabBarManager manager] registerTabBar];
    
    // 注册重新加载RootVC的通知
    [self addResetRootVCObserver];
    return YES;
}

- (void)addResetRootVCObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetRootViewController)
                                                 name:@"kNotifyRootViewControllerReset"
                                               object:nil];
}

/**
 重新设置RootController
 */
- (void)resetRootViewController {
    //加切换RootViewController时的动画
    @weakify(self);
    [[JYTabBarManager manager] resetTabBarController];
    [UIView transitionWithView:self.window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        @strongify(self);
                        [self.window setRootViewController:nil];
                        [self.window setRootViewController:[JYTabBarManager manager].tabBarController];
                        [[JYTabBarManager manager] tabBarController].selectedIndex = 0;
                        [self.window makeKeyAndVisible];
                    } completion:nil];
}


@end
