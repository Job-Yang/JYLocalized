//
//  JYTabBarManager.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/7/31.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "JYTabBarManager.h"
#import "JYNavigationController.h"
#import "JYHomeViewController.h"
#import "JYFeedsViewController.h"
#import "JYMessageViewController.h"
#import "JYMineViewController.h"

@interface JYTabBarManager()<UITabBarControllerDelegate, CYLTabBarControllerDelegate>

@end

@implementation JYTabBarManager

#pragma mark - life cycle
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    static JYTabBarManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}


#pragma mark - setup methods
- (void)registerTabBar {
    [JYTabBarPlusButton registerPlusButton];
    [self tabBarController];
}

- (void)resetTabBarController {
    self.tabBarController = nil;
    [self tabBarController];
}

#pragma mark - event & response

#pragma mark - CYLTabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    if ([control cyl_isTabButton]) {
        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
        }
        animationView = [control cyl_tabImageView];
    }
    
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    }
    [self addScaleAnimationOnView:animationView repeatCount:1];
}

#pragma mark - private methods
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : JYLocalizedString(@"首页", nil),
                            CYLTabBarItemImage : @"tabbar_home_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_home_selected",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : JYLocalizedString(@"动态", nil),
                            CYLTabBarItemImage : @"tabbar_feeds_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_feeds_selected",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : JYLocalizedString(@"消息", nil),
                            CYLTabBarItemImage : @"tabbar_message_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_message_selected",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : JYLocalizedString(@"我的", nil),
                            CYLTabBarItemImage : @"tabbar_mine_normal",
                            CYLTabBarItemSelectedImage : @"tabbar_mine_selected",
                            };
    NSArray *tabBarItemsAttributes = @[dict1, dict2, dict3, dict4];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAttrs[NSForegroundColorAttributeName] = NORMAL_COLOR;
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selectedAttrs[NSForegroundColorAttributeName] = SELECTED_COLOR;
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
}

- (void)resetBadgeWithTabBarController:(CYLTabBarController *)aTabBarController {
    UIView *tabBadgePointView = [UIView cyl_tabBadgePointViewWithClolor:[UIColor redColor] radius:4.5];
    [aTabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView];
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    if (badge > 0) {
        [aTabBarController.viewControllers[2] cyl_showTabBadgePoint];
    }
}

- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

#pragma mark - getter & setter
- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
        tabBarController.delegate = self;
        JYHomeViewController *homeVC = [[JYHomeViewController alloc] init];
        JYNavigationController *homeNav = [[JYNavigationController alloc] initWithRootViewController:homeVC];
        
        JYFeedsViewController *feedsVC = [[JYFeedsViewController alloc] init];
        JYNavigationController *feedsNav = [[JYNavigationController alloc] initWithRootViewController:feedsVC];
        
        JYMessageViewController *messageVC = [[JYMessageViewController alloc] init];
        JYNavigationController *messageNav = [[JYNavigationController alloc] initWithRootViewController:messageVC];
        
        JYMineViewController *mineVC = [[JYMineViewController alloc] init];
        JYNavigationController *mineNav = [[JYNavigationController alloc] initWithRootViewController:mineVC];
        
        [self customizeTabBarForController:tabBarController];
        [self customizeTabBarAppearance:tabBarController];
        [tabBarController setViewControllers:@[homeNav, feedsNav, messageNav, mineNav]];

        @weakify(self);
        [tabBarController setViewDidLayoutSubViewsBlock:^(CYLTabBarController *aTabBarController) {
            @strongify(self);
            [self resetBadgeWithTabBarController:aTabBarController];
            [self addScaleAnimationOnView:CYLExternPlusButton.imageView repeatCount:3];
        }];
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}


@end
