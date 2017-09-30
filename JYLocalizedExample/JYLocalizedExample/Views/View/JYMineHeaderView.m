//
//  JYMineHeaderView.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/29.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "JYMineHeaderView.h"
#import "pop.h"

@interface JYMineHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end

@implementation JYMineHeaderView

#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        self = [[[UINib nibWithNibName:@"JYMineHeaderView" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
        [self setup];
        [self setViewText];
    }
    return self;
}

#pragma mark - setup methods
- (void)setup {
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width/2;
    self.iconImageView.layer.masksToBounds = YES;
}

#pragma mark - event & response

#pragma mark - private methods
- (void)setViewText {
    self.titleLabel.text = JYLocalizedString(@"Job-Yang", nil);
    self.subTitleLabel.text = JYLocalizedString(@"Job-Yang", nil);
}

#pragma mark - getter & setter



@end
