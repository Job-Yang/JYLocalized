//
//  JYTabBarPlusButton.m
//  360zebra
//
//  Created by 杨权 on 16/9/8.
//  Copyright © 2016年 360zebra. All rights reserved.
//

#import "JYTabBarPlusButton.h"
#import "JYPopView.h"

@interface JYTabBarPlusButton()<CYLPlusButtonSubclassing, JYPopViewDelegate>
@property (strong, nonatomic) JYPopView *sendTypeView;
@end

@implementation JYTabBarPlusButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        [self sendTypeView];
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWidth = self.bounds.size.width * 0.8;
    
    CGFloat const centerOfView = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin = (self.bounds.size.height - labelLineHeight - imageViewEdgeWidth) * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeWidth * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeWidth  + verticalMargin * 2 + labelLineHeight * 0.5 + 15;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeWidth);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
    
    //重新设置是为了切换语言及时变更对应的多语言字符串
    UIButton *button = CYLExternPlusButton;
    [button setTitle:JYLocalizedString(@"寄件", nil) forState:UIControlStateNormal];
}

#pragma mark - CYLPlusButtonSubclassing Methods
+ (id)plusButton {
    JYTabBarPlusButton *button = [[JYTabBarPlusButton alloc] init];
    UIImage *buttonImage = IMG(@"tabbar_sent_sendParcels");
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setTitle:JYLocalizedString(@"寄件", nil) forState:UIControlStateNormal];
    [button setTitleColor:RGB(33,38,39) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button sizeToFit];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  -5;
}

#pragma mark - JYPopViewDelegate
- (void)sendTypeDidChange:(JYSendType)type {
    switch (type) {
        case JYSendTypePickUpView: {
            [[JYRouter router] present:@"JYPickUpViewController"];
            break;
        }
        case JYSendTypeDropOffView: {
            [[JYRouter router] present:@"JYPickUpViewController"];
            break;
        }
        default:
            break;
    }
}


#pragma mark - Event Response
- (void)clickPublish {
    self.sendTypeView = [[JYPopView alloc] init];
    self.sendTypeView.delegate = self;
    [self.sendTypeView show];
}

@end
