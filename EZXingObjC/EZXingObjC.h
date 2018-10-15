//
//  EZXingObjC.h
//  EZXingObjC
//
//  Created by erics on 2018/8/1.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#ifndef EZXingObjC_h
#define EZXingObjC_h

#import "LxDBAnything.h"

//如果有Debug这个宏的话,就允许log输出...可变参数
#ifdef DEBUG
#define ESLog(...) LxPrintf(__VA_ARGS__)
#else
#define ESLog(...)
#endif

#define IPHONE_4_Height (480.0)
#define IPHONE_5_Height (568.0)
#define IPHONE_6_Height (667.0)
#define IPHONE_Plus_Height (736.0)
#define IPHONE_X_Height (812.0)

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height == IPHONE_4_Height)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height == IPHONE_5_Height)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height == IPHONE_6_Height)
#define IS_IPHONE_6PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height == IPHONE_Plus_Height)
#define IS_IPHONE_X (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)812)==0)
#define IPHONEX_TOP_SPACE ((IS_IPHONE_X)?24:0)
#define IPHONEX_BOTTOM_SPACE ((IS_IPHONE_X)?34:0)

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenBounds ([UIApplication sharedApplication].keyWindow.bounds)
#define kNavigationBarHeight (IS_IPHONE_X? 88 : 64)
#define bottomXHeight  (IS_IPHONE_X? 20 : 0)
#define kbottomXHeight  (IS_IPHONE_X? 20 : 0)

#ifdef __OBJC__

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

#endif
#endif /* EZXingObjC_h */
