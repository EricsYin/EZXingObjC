//
//  EScanRectView.m
//  EZXingObjC
//
//  Created by erics on 2018/7/30.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EScanRectView.h"
#import "EScanLineAnimation.h"

///>边距
CGFloat ErRetangleLeft = 10;

///>扫描区域宽高比
CGFloat ErWHRatio = 1;

/**
 @ErCenterUpOffset  矩形框(视频显示透明区)域向上移动偏移量，0表示扫码透明区域在当前视图中心位置，< 0 表示扫码区域下移, >0 表示扫码区域上移（新版移到顶部，计算时暂不用该值）
 */
CGFloat ErCenterUpOffset = 120;

//相机显示范围的高度
CGFloat ERCameraRectHeight = 175;

//扫描区域的高度
CGFloat ErScanRectHeight = 125;

//扫码区域4个角的宽度和高度
CGFloat photoframeAngleW  = 15;
CGFloat photoframeAngleH  = 15;
/**
 @brief  扫码区域4个角的线条宽度,默认6，建议8到4之间
 */
CGFloat photoframeLineW = 2;

@interface EScanRectView ()

/**
 非矩形框区域颜色
 */
@property (nonatomic,strong) UIColor  * ErNotRecoginitonAreaColor;

/**
 @brief  矩形框线条颜色
 */
@property (nonatomic, strong) UIColor *ErColorRetangleLineColor;


/**
 扫码区域
 */
@property (nonatomic,assign)CGRect scanRetangleRect;

//4个角的颜色
@property (nonatomic, strong) UIColor* ErAngleColor;

/**
 扫描动画
 */
@property (nonatomic,strong) EScanLineAnimation  * scanLineAnimation;



/**
 扫描范围的顶部
 */
@property (nonatomic,assign) CGFloat scanRectTop;

/**
 扫描区域最下方
 */
@property (nonatomic,assign) NSInteger scanRectBottom;


@property (nonatomic,assign) OPScanRectStyle scanStyle;

/**
 闪光灯
 */
@property (nonatomic, strong) UIButton * controlFlashButton;

@property (nonatomic, strong) UILabel * controlFlashLabel;


@end

@implementation EScanRectView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
