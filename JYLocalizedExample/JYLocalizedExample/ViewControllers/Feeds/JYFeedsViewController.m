//
//  JYFeedsViewController.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/27.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "JYFeedsViewController.h"
#import "JYContentView.h"

@interface JYFeedsViewController ()
@property (strong, nonatomic) JYContentView *contentView;
@end

@implementation JYFeedsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self contentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setup methods

#pragma mark - requests

#pragma mark - event & response

#pragma mark - private methods

#pragma mark - getter & setter
- (JYContentView *)contentView {
    if (!_contentView) {
        _contentView = [[JYContentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SAFE_HEIGHT+NAVIGATION_BAR_HEIGHT)];
        [_contentView setViewContentWithBackground:@"feeds_background_normal" title:JYLocalizedString(@"动态", nil) detail:JYLocalizedString(@"这里是动态页", nil)];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

@end
