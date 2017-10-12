//
//  JYMacro.h
//  JYLocalizedExample
//
//  Created by 杨权 on 2017/9/21.
//  Copyright © 2017年 Job-Yang. All rights reserved.
//

#ifndef JYMacro_h
#define JYMacro_h

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#define RGB(r, g, b) RGBA(r, g, b, 1)
#define RGBA(r, g, b, a) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]
#define NORMAL_COLOR RGB(102,102,102)
#define SELECTED_COLOR RGB(41, 44, 50)

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_HEIGHT == 812.0f)
#define STATUS_BAR_HEIGHT (IS_IPHONE_X ? 44.0 : 20.0)
#define NAVIGATION_BAR_HEIGHT 44.0
#define TOP_LAYOUT_GUIDE (STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
#define BOTTOM_LAYOUT_GUIDE (IS_IPHONE_X ? 34.0 : 0.0)
#define SAFE_HEIGHT (SCREEN_HEIGHT-TOP_LAYOUT_GUIDE-BOTTOM_LAYOUT_GUIDE)
#define DEVICE_VERSION [[[UIDevice currentDevice] systemVersion] integerValue]

#define IMG(name) [UIImage imageNamed:name]

#endif /* JYMacro_h */
