//
//  JYCellModel.h
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/27.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYCellModel : NSObject
/**
 *  key
 */
@property (copy, nonatomic) NSString *key;
/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  子标题
 */
@property (copy, nonatomic) NSString *subTitle;
/**
 *  是否选中
 */
@property (assign, nonatomic) BOOL enabled;

@end
