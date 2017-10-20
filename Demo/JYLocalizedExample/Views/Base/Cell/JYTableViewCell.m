//
//  JYTableViewCell.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/29.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "JYTableViewCell.h"
#import "JYCellModel.h"

@interface JYTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end

@implementation JYTableViewCell

#pragma mark - life cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setViewText];
}

#pragma mark - JYTableViewCellProtocol
+ (CGFloat)heightWithData:(id)data {
    return 65;
}

- (void)resetWithData:(id)data {
    JYCellModel *model = (JYCellModel *)data;
    if (model && [model isKindOfClass:[JYCellModel class]]) {
        self.titleLabel.text = model.title;
        if (model.iconName && model.iconName.length > 0) {
            self.iconImageView.image = IMG(model.iconName);
        }
    }
}

#pragma mark - setup methods

#pragma mark - requests

#pragma mark - router

#pragma mark - event & response
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - private methods
- (void)setViewText {
    //set you multilingual string
}

#pragma mark - getter & setter

@end
