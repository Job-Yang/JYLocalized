//
//  JYContentView.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/10/11.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "JYContentView.h"

@interface JYContentView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation JYContentView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initContentViewWithFrame:frame];
    }
    return self;
}

#pragma mark - setup methods
- (void)initContentViewWithFrame:(CGRect)frame {
    JYContentView *view = [[[UINib nibWithNibName:@"JYContentView" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    [view setFrame:frame];
    [self addSubview:view];
}

#pragma mark - setup methods
- (void)setViewContentWithBackground:(NSString *)background
                               title:(NSString *)title
                              detail:(NSString *)detail {
    self.bgImageView.image = IMG(background);
    self.titleLabel.text = title;
    self.detailLabel.text = detail;
}

#pragma mark - event & response

#pragma mark - private methods

#pragma mark - getter & setter

@end
