//
//  EScanRectView.h
//  EZXingObjC
//
//  Created by erics on 2018/7/30.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^flashBlock)(BOOL isSelected);

typedef enum : NSUInteger {
    OPScanTopRectStyle,//顶部扫描
    OPScanCenterRectStyle,//中间区域扫描
} OPScanRectStyle; //扫描区域的样式


@interface EScanRectView : UIView
@property (nonatomic, copy) flashBlock flashBlock;


#pragma mark - 视图相关property  Api
/**
 *  开始扫描动画
 */
- (void)startScanAnimation;

/**
 *  结束扫描动画
 */
- (void)stopScanAnimation;


/**
 扫描区域底部
 
 @return cgfloat botton
 */
- (NSInteger )centerScanRectBottom;


/**
 根据矩形区域，获取ZXing库扫码识别兴趣区域
 
 @param view 视频流显示视图
 
 @return 识别区域
 */
+ (CGRect)getZXingScanRectWithPreView:(UIView*)view ;


/**
 定义扫描区域的样式
 
 @param style 扫描样式
 */
- (void)drawScanViewWithStyle:(OPScanRectStyle)style;

/**
 扫描区域绘制为中间区域扫描框
 */
- (void)drawScanViewCenterRect;


/**
 扫描区域绘制为顶部区域扫描
 */
- (void)drawScanViewTopRect;

@end
