# JYLocalized

![JYLocalized](https://github.com/Job-Yang/JYLocalized/blob/master/ScreenShots/Demonstration.gif)

🌏  iOS localization/Internationalization and in-app switching language example.


# Localization/Internationalization




# In-app switching language

In this example, In-app switching language typically has the following steps:

![JYLocalized](https://github.com/Job-Yang/JYLocalized/blob/master/ScreenShots/FlowChart_EN.png)

### Key code 

#### JYLanguageViewController.m
```Objective-C
// Set new language
[[JYLocalizedHelper helper] setUserLanguage:key];
// send reload root viewController notification
[[NSNotificationCenter defaultCenter] postNotificationName:@"kNotifyRootViewControllerReset" object:nil];
```

#### JYLocalizedHelper.m
```Objective-C
- (void)setUserLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    // construct a new bundle
    self.bundle = [NSBundle bundleWithPath:path];
    // Store new language tags locally
    [defaults setObject:language forKey:kUserLanguage];
    [defaults synchronize];
}
```

#### AppDelegate.m
```Objective-C
- (void)resetRootViewController {
    // Add animations
    @weakify(self);
    [[JYTabBarManager manager] resetTabBarController];
    [UIView transitionWithView:self.window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        @strongify(self);
                        // Switch the RootViewController to reload all viewController
                        [self.window setRootViewController:nil];
                        [self.window setRootViewController:[JYTabBarManager manager].tabBarController];
                        [[JYTabBarManager manager] tabBarController].selectedIndex = 0;
                        [self.window makeKeyAndVisible];
                    } completion:nil];
}
```


# License

JYLocalized is released under the MIT license. See LICENSE file for details.



------

# 中文介绍

🌏  iOS本地化/国际化与应用内切换语言的一个范例。



# 本地化/国际化



# 应用内切换语言

在该示例中，应用中切换语言一般会经历以下几个步骤：

![JYLocalized](https://github.com/Job-Yang/JYLocalized/blob/master/ScreenShots/FlowChart_CN.png)


### 关键代码 

#### JYLanguageViewController.m
```Objective-C
// 设置新的语言标示
[[JYLocalizedHelper helper] setUserLanguage:key];
// 发送重新加载root viewController通知
[[NSNotificationCenter defaultCenter] postNotificationName:@"kNotifyRootViewControllerReset" object:nil];
```

#### JYLocalizedHelper.m
```Objective-C
- (void)setUserLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    // 构造新的bundle
    self.bundle = [NSBundle bundleWithPath:path];
    // 将新的语言标示存入本地
    [defaults setObject:language forKey:kUserLanguage];
    [defaults synchronize];
}
```

#### AppDelegate.m
```Objective-C
- (void)resetRootViewController {
    // 添加动画
    @weakify(self);
    [[JYTabBarManager manager] resetTabBarController];
    [UIView transitionWithView:self.window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        @strongify(self);
                         // 切换RootViewController使得构建在它上面的ViewController都重新加载
                        [self.window setRootViewController:nil];
                        [self.window setRootViewController:[JYTabBarManager manager].tabBarController];
                        [[JYTabBarManager manager] tabBarController].selectedIndex = 0;
                        [self.window makeKeyAndVisible];
                    } completion:nil];
}
```


# 许可证

JYLocalized 使用 MIT 许可证，详情见 LICENSE 文件。
