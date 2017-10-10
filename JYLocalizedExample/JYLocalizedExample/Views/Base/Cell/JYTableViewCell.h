//
//  JYTableViewCell.h
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/29.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYTableViewCell : UITableViewCell
/**
 通过数据Cell高度
 
 @param data 相关数据/模型
 @return cell高度
 */
+ (CGFloat)heightWithData:(id)data;

/**
 对Cell进行数据绑定
 
 @param data 相关数据/模型
 */
- (void)resetWithData:(id)data;

@end
