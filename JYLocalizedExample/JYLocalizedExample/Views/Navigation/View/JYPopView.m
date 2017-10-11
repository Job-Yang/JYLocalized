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
@property (strong, nonatomic) UIView *starView;
@property (strong, nonatomic) UIView *diamondView;
@property (strong, nonatomic) UIButton *closeButton;
@end

@implementation JYPopView

#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    return self;
}

#pragma mark - setup methods
- (void)setup {
    [self addSubview:self.starView];
    [self addSubview:self.diamondView];
    [self addSubview:self.closeButton];
    [self insertSubview:self.bgImageView atIndex:0];
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

- (void)viewAction:(id)sender {
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
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    button.tag = text.hash;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

#pragma mark - getter & setter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *path = [JYBundle pathForResource:@"pop_background_normal" ofType:@"png"];
        imageView.image = [UIImage imageWithContentsOfFile:path];
        imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView = imageView;
    }
    return _bgImageView;
}

- (UIView *)starView {
    if (!_starView) {
        CGFloat width = 65;
        UIView *view = [self setViewWithSize:CGSizeMake(width, width+30)
                                   imageName:@"pop_star_normal"
                                        text:JYLocalizedString(@"功能A", nil)
                                      action:@selector(viewAction:)];
        view.center = CGPointMake(self.frame.size.width/4*1, self.closeButton.frame.origin.y - width - 30);
        _starView = view;
    }
    return _starView;
}

- (UIView *)diamondView {
    if (!_diamondView) {
        CGFloat width = 65;
        UIView *view = [self setViewWithSize:CGSizeMake(width, width+30)
                                   imageName:@"pop_diamond_normal"
                                        text:JYLocalizedString(@"功能B", nil)
                                      action:@selector(viewAction:)];
        view.center = CGPointMake(self.frame.size.width/4*3, self.closeButton.frame.origin.y - width - 30);
        _diamondView = view;
    }
    return _diamondView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((self.frame.size.width-30)/2, self.frame.size.height - 70, 30, 30);
        [button setImage:[UIImage imageNamed:@"pop_close_normal"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _closeButton = button;
    }
    return _closeButton;
}

@end
