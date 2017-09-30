//
//  UIViewController+JYHUD.m
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/29.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#import "UIViewController+JYHUD.h"
#import "MBProgressHUD.h"

@implementation UIViewController (JYHUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, @selector(HUD), HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHUD:(NSString *)hint {
    if ([self HUD] != nil) {
        [[self HUD] removeFromSuperview];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    hud.label.text = hint;
    [self.view addSubview:hud];
    [self setHUD:hud];
    [hud showAnimated:YES];
}

- (void)hideHUD {
    [[self HUD] hideAnimated:YES];
    [[self HUD] removeFromSuperview];
}

@end
