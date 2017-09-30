//
//  JYBaseViewController.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/30.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "JYBaseViewController.h"

@interface JYBaseViewController ()

@end

@implementation JYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setCurrentTitle:(NSString *)currentTitle {
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    titleButton.backgroundColor = [UIColor clearColor];
    titleButton.frame = CGRectMake(0, 0, 100, 50);
    [titleButton setTitle:currentTitle forState:UIControlStateNormal];
    [titleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleButton.autoresizesSubviews = YES;
    self.navigationItem.titleView = (UIView *)titleButton;
    objc_setAssociatedObject(self, @selector(currentTitle), currentTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setLeftBarButton {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    UIImage *originalImage = [UIImage imageNamed:@"navigation_back_gray"];
    originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barButton.image = originalImage;
    [barButton setImageInsets:UIEdgeInsetsMake(0, -3.5, 0, 3.5)];
    self.navigationItem.leftBarButtonItem = (UIBarButtonItem *)barButton;
}

- (void)leftBarButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
