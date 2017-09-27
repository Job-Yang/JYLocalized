//
//  JYPopView.h
//  360zebra
//
//  Created by 杨权 on 2017/6/27.
//  Copyright © 2017年 360zebra. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JYSendType) {
    //预约取件
    JYSendTypePickUpView  = 1,
    //网点投递
    JYSendTypeDropOffView = 2,
};

@protocol JYPopViewDelegate <NSObject>

- (void)sendTypeDidChange:(JYSendType)type;

@end

@interface JYPopView : UIView


@property (weak, nonatomic) id<JYPopViewDelegate> delegate;

- (void)show;
- (void)hide;

@end
