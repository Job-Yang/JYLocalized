//
//  JYPopView.m
//  360zebra
//
//  Created by 杨权 on 2017/6/27.
//  Copyright © 2017年 360zebra. All rights reserved.
//

#import "JYPopView.h"
#import "pop.h"

@interface JYPopView ()

@property (strong, nonatomic) UIImageView *bgImageView;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIView *dropOffView;
@property (strong, nonatomic) UIView *pickUpView;
@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UIVisualEffectView *effectView;
@end

@implementation JYPopView

#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self setup];
    }
    return self;
}

#pragma mark - setup methods
- (void)setup {
    [self addSubview:self.pickUpView];
    [self addSubview:self.dropOffView];
    [self addSubview:self.closeButton];
    [self insertSubview:self.bgImageView atIndex:0];
//    [self insertSubview:self.effectView atIndex:0];
}

#pragma mark - event & response
- (void)show {
    [[[JYRouter currentVC] view] addSubview:self];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                     }];
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.4, 0.4)];
    scaleAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaleAnimation.springBounciness = 10.f;
    scaleAnimation.springSpeed = 10;
    [self pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
}

- (void)hide {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    scaleAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(0.4, 0.4)];
    scaleAnimation.springBounciness = 14.f;
    scaleAnimation.springSpeed = 6;
    [self pop_addAnimation:scaleAnimation forKey:@"scaleAnim"];
}

- (void)chooseSendType:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sendTypeDidChange:)]) {
        [self.delegate sendTypeDidChange:[self sendTypeWithSender:sender]];
    }
    [self hide];
}

- (void)closeButtonAction {
    [self hide];
}

#pragma mark - private methods
- (UIView *)setViewWithSize:(CGSize)size
                  imageName:(NSString *)imageName
                       text:(NSString *)text
                     action:(SEL)action {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:IMG(imageName)];
    image.frame = CGRectMake(0, 0, size.width, size.width);
    image.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:image];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, size.width, size.width, 30)];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    [view addSubview:label];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    button.tag = text.hash;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

- (JYSendType)sendTypeWithSender:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *dropOffKey = JYLocalizedString(@"网点投递", nil);
    return (button.tag == [dropOffKey hash]) ? JYSendTypeDropOffView : JYSendTypePickUpView;
}

- (NSString *)getLocalizedImageName {
    //多语言适配
    if ([[[JYLocalizedHelper standardHelper] currentLanguage] isEqualToString:@"en"]) {
        return @"sendParcels_sendType_en";
    }
    else if ([[[JYLocalizedHelper standardHelper] currentLanguage] isEqualToString:@"zh-Hant"]) {
        return @"sendParcels_sendType_zh-Hant";
    }
    else {
        return @"sendParcels_sendType_advertising";
    }
}

#pragma mark - getter & setter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = IMG([self getLocalizedImageName]);
        imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView = imageView;
    }
    return _bgImageView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = IMG(@"要图专用图");
        imageView.frame = CGRectMake(0, 100, 100, 50);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImageView = imageView;
    }
    return _logoImageView;
}

- (UIView *)pickUpView {
    if (!_pickUpView) {
        CGFloat width = 65;
        UIView *view = [self setViewWithSize:CGSizeMake(width, width+30)
                                   imageName:@"sendParcels_reservation_normal"
                                        text:JYLocalizedString(@"预约取件", nil)
                                      action:@selector(chooseSendType:)];
        view.center = CGPointMake(self.frame.size.width/4*1, self.closeButton.frame.origin.y - width - 30);
        _pickUpView = view;
    }
    return _pickUpView;
}

- (UIView *)dropOffView {
    if (!_dropOffView) {
        CGFloat width = 65;
        UIView *view = [self setViewWithSize:CGSizeMake(width, width+30)
                                   imageName:@"sendParcels_dorpOf_normal"
                                        text:JYLocalizedString(@"网点投递", nil)
                                      action:@selector(chooseSendType:)];
        view.center = CGPointMake(self.frame.size.width/4*3, self.closeButton.frame.origin.y - width - 30);
        _dropOffView = view;
    }
    return _dropOffView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((self.frame.size.width-30)/2, self.frame.size.height - 70, 30, 30);
        [button setImage:[UIImage imageNamed:@"sendParcels_close_normal"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = button;
    }
    return _closeButton;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = self.bounds;
        effectView.alpha = 0.95;
        _effectView = effectView;
    }
    return _effectView;
}

@end
