//
//  JYTabBarPlusButton.m
//  JYLocalizedExample
//
//  Created by 杨权 on 16/9/8.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYTabBarPlusButton.h"
#import "JYPopView.h"

@interface JYTabBarPlusButton()<CYLPlusButtonSubclassing>
@property (strong, nonatomic) JYPopView *popView;
@end

@implementation JYTabBarPlusButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

#pragma mark - CYLPlusButtonSubclassing Methods
+ (id)plusButton {
    JYTabBarPlusButton *button = [[JYTabBarPlusButton alloc] init];
    UIImage *buttonImage = IMG(@"tabbar_plus_normal");
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, 70, 70);
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return 0.5;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return IS_IPHONE_X ? -13 : 0;
}

#pragma mark - Event Response
- (void)clickPublish {
    self.popView = [[JYPopView alloc] init];
    [self.popView show];
}

@end
