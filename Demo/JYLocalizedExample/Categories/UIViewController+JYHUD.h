//
//  UIViewController+JYHUD.h
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/29.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JYHUD)
/**
 *  在self.view中间显示小菊花
 *
 *  @param hint 提示信息
 */
- (void)showHUD:(NSString *)hint;
/**
 *  隐藏self.view的HUD
 */
- (void)hideHUD;

@end
