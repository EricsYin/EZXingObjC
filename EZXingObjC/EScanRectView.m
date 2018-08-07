//
//  EScanRectView.m
//  EZXingObjC
//
//  Created by erics on 2018/7/30.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EScanRectView.h"
#import "EScanLineAnimation.h"
#import "UIColor+EColorCategory.h"
#import "EZXingObjC.h"


///>边距
CGFloat ErRetangleLeft = 10;

///>扫描区域宽高比
CGFloat ErWHRatio = 1;

/**
 @ErCenterUpOffset  矩形框(视频显示透明区)域向上移动偏移量，0表示扫码透明区域在当前视图中心位置，< 0 表示扫码区域下移, >0 表示扫码区域上移（新版移到顶部，计算时暂不用该值）
 */
CGFloat ErCenterUpOffset = 120;

///>相机显示范围的高度
CGFloat ERCameraRectHeight = 175;

///>扫描区域的高度
CGFloat ErScanRectHeight = 125;

///>扫码区域4个角的宽度和高度·
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

///>4个角的颜色
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

///>闪光灯flashLabel
@property (nonatomic, strong) UILabel * controlFlashLabel;


@end

@implementation EScanRectView

- (void)dealloc{
    [self stopScanAnimation];
}


#pragma mark -  Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        //配置公共属性
        self.backgroundColor = [UIColor clearColor];
        //    self.frame = frame;
        //        self.ErNotRecoginitonAreaColor = [UIColor colorWithRed:0. green:.0 blue:.0 alpha:.5];
        self.ErNotRecoginitonAreaColor = [UIColor clearColor];
        self.ErColorRetangleLineColor = [UIColor hexStringToColor:@"#DDDDDD"];
        self.ErAngleColor = [UIColor hexStringToColor:@"#5ADAD0"];
        
        [self addSubview:self.controlFlashLabel];
        [self addSubview:self.controlFlashButton];
        CGFloat controlFlashLabelWidth = 150;
        self.controlFlashLabel.frame = CGRectMake((kScreenWidth - controlFlashLabelWidth)/2, 175, controlFlashLabelWidth, 30);
        
        CGFloat controlFlashButtonWidth = 50;
        self.controlFlashButton.frame = CGRectMake((kScreenWidth - controlFlashButtonWidth)/2, self.controlFlashLabel.frame.origin.y - 10, controlFlashButtonWidth, controlFlashButtonWidth);
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self drawScanRectWithStyle:self.scanStyle];
}

#pragma mark -  system Delegate

#pragma mark -  CustomDelegate

#pragma mark -  Event Response

- (void)controlTropClick:(UIButton *)button{
    if (button.selected) {
        [self.controlFlashLabel setText:@"轻触点亮"];
        self.controlFlashLabel.textColor = [UIColor whiteColor];
        if (self.flashBlock) {
            self.flashBlock(NO);
        }
    }
    
    else
    {
        [self.controlFlashLabel setText:@"轻触关闭"];
        self.controlFlashLabel.textColor = [UIColor hexStringToColor:@"#5ADAD0"];
        if (self.flashBlock) {
            self.flashBlock(YES);
        }
        
    }
    button.selected = !button.selected;
}

#pragma mark -  Private Methods


/**
 扫描区域为中间
 */
- (void)drawScanRectWithStyle:(OPScanRectStyle )style{
    
    CGSize sizeRetangle = CGSizeMake(self.frame.size.width - ErRetangleLeft*2, ErScanRectHeight);
    CGFloat YMinRetangle;
    switch (style) {
        case OPScanCenterRectStyle:
            YMinRetangle  = self.frame.size.height / 2.0 - sizeRetangle.height/2.0 - ErCenterUpOffset;
            break;
        case OPScanTopRectStyle:
            YMinRetangle = photoframeLineW/2 + 25;
            break;
        default:
            YMinRetangle = photoframeLineW/2 + 25;
            break;
    }
    
    // CGFloat YMinRetangle = photoframeLineW/2;
    CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
    
    CGFloat XRetangleRight = self.frame.size.width - ErRetangleLeft;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //非扫码区域半透明
    {
        //设置非识别区域颜色
        
        const CGFloat *components = CGColorGetComponents(self.ErNotRecoginitonAreaColor.CGColor);
        CGFloat red_notRecoginitonArea = components[0];
        CGFloat green_notRecoginitonArea = components[1];
        CGFloat blue_notRecoginitonArea = components[2];
        CGFloat alpa_notRecoginitonArea = components[3];
        CGContextSetRGBFillColor(context, red_notRecoginitonArea, green_notRecoginitonArea,
                                 blue_notRecoginitonArea, alpa_notRecoginitonArea);
        //填充矩形
        //扫码区域上面填充
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, YMinRetangle);
        CGContextFillRect(context, rect);
        
        //扫码区域左边填充
        rect = CGRectMake(0, YMinRetangle, ErRetangleLeft,sizeRetangle.height);
        CGContextFillRect(context, rect);
        
        //扫码区域右边填充
        rect = CGRectMake(XRetangleRight, YMinRetangle, ErRetangleLeft,sizeRetangle.height);
        CGContextFillRect(context, rect);
        
        //扫码区域下面填充
        rect = CGRectMake(0, YMaxRetangle, self.frame.size.width,self.frame.size.height - YMaxRetangle);
        CGContextFillRect(context, rect);
        //执行绘画
        CGContextStrokePath(context);
    }
    
    //中间画矩形(正方形)
    CGContextSetStrokeColorWithColor(context, self.ErColorRetangleLineColor.CGColor);
    CGContextSetLineWidth(context, .5f);
    
    CGContextAddRect(context, CGRectMake(ErRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height));
    
    //    CGContextMoveToPoint(context, XRetangleLeft, YMinRetangle);
    //    CGContextAddLineToPoint(context, XRetangleLeft+sizeRetangle.width, YMinRetangle);
    
    CGContextStrokePath(context);
    
    _scanRetangleRect = CGRectMake(ErRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height);
    
    //画矩形框4格外围相框角
    
    //相框角的宽度和高度
    int wAngle = photoframeAngleW;
    int hAngle = photoframeAngleH;
    
    //4个角的 线的宽度
    CGFloat linewidthAngle = photoframeLineW;// 经验参数：6和4
    
    //画扫码矩形以及周边半透明黑色坐标参数
    CGFloat diffAngle = 0.0f;
    //diffAngle = linewidthAngle / 2; //框外面4个角，与框有缝隙
    //diffAngle = linewidthAngle/2;  //框4个角 在线上加4个角效果
    //diffAngle = 0;//与矩形框重合
    diffAngle = -linewidthAngle/2;
    
    CGContextSetStrokeColorWithColor(context,self.ErAngleColor.CGColor );
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, linewidthAngle);
    
    //
    CGFloat leftX = ErRetangleLeft - diffAngle;
    CGFloat topY = YMinRetangle - diffAngle;
    CGFloat rightX = XRetangleRight + diffAngle;
    CGFloat bottomY = YMaxRetangle + diffAngle;
    
    //左上角水平线
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, leftX + wAngle, topY);
    
    //左上角垂直线
    CGContextMoveToPoint(context, leftX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, topY+hAngle);
    
    
    //左下角水平线
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, leftX + wAngle, bottomY);
    
    //左下角垂直线
    CGContextMoveToPoint(context, leftX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, bottomY - hAngle);
    
    
    //右上角水平线
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, rightX - wAngle, topY);
    
    //右上角垂直线
    CGContextMoveToPoint(context, rightX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, topY + hAngle);
    
    
    //右下角水平线
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, rightX - wAngle, bottomY);
    
    //右下角垂直线
    CGContextMoveToPoint(context, rightX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, bottomY - hAngle);
    
    CGContextStrokePath(context);
    
    [self startScanAnimation];
}

+ (CGRect)getZXingScanRectWithPreView:(UIView *)view
{
    CGSize sizeRetangle = CGSizeMake(view.frame.size.width - ErRetangleLeft*2, ErScanRectHeight);
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle =  photoframeLineW/2 + ERCameraRectHeight - ErScanRectHeight;
    CGFloat cropX = ErRetangleLeft/(view.frame.size.width ) * 1080;
    //    YMinRetangle = YMinRetangle / (view.frame.size.height )* 1920;
    //    CGFloat width  = sizeRetangle.width / (view.frame.size.width ) * 1080;
    //    CGFloat height = sizeRetangle.height / (view.frame.size.height )*  1920;
    CGFloat width  = sizeRetangle.width / kScreenWidth * 1080;
    CGFloat height = sizeRetangle.height/ (kScreenHeight )*1920;
    //扫码区域坐标
    CGRect cropRect =  CGRectMake(cropX, YMinRetangle, width  ,height );

    return cropRect;
}

- (void)startScanAnimation
{
    if (!self.scanLineAnimation) {
        self.scanLineAnimation = [[EScanLineAnimation alloc]init];
        
        [self.scanLineAnimation startAnimatingWithRect:self.scanRetangleRect InView:self Image:[UIImage imageNamed:@"scanLine"]];
    }
    
}

- (void)stopScanAnimation
{
    [self.scanLineAnimation stopAnimating];
}

#pragma mark -  Public Methods
- (NSInteger)centerScanRectBottom
{
    return self.scanRectBottom;
}

- (void)drawScanViewWithStyle:(OPScanRectStyle)style{
    switch (style) {
        case OPScanTopRectStyle:
            self.scanStyle = OPScanTopRectStyle;
            //1.配置基础属性
            ErRetangleLeft = 25;
            ErScanRectHeight = 125;
            self.scanRectBottom = photoframeLineW + ERCameraRectHeight;
            //2.开始绘制
            [self setNeedsDisplay];
            break;
        case OPScanCenterRectStyle:
            self.scanStyle = OPScanCenterRectStyle;
            //1.
            ErRetangleLeft  = 60*(self.frame.size.width)/375;
            ErScanRectHeight = self.frame.size.width - ErRetangleLeft*2;
            self.scanRectBottom = self.frame.size.height / 2.0  - ErCenterUpOffset + ErScanRectHeight/2;
            self.controlFlashButton.hidden = YES;
            self.controlFlashLabel.hidden = YES;
            //2.
            [self setNeedsDisplay];
            break;
        default:
            
            break;
    }
}

#pragma mark -  Getters and Setters
- (UIButton *)controlFlashButton
{
    if (!_controlFlashButton) {
        _controlFlashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_controlFlashButton setImage:[UIImage imageNamed:@"flashlightOn"] forState:UIControlStateSelected];
        [_controlFlashButton setImage:[UIImage imageNamed:@"flashlightOff"] forState:UIControlStateNormal];
        _controlFlashButton.backgroundColor = [UIColor clearColor];
        [_controlFlashButton addTarget:self action:@selector(controlTropClick:) forControlEvents:UIControlEventTouchUpInside];
        [_controlFlashButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _controlFlashButton;
}

- (UILabel *)controlFlashLabel{
    
    if (!_controlFlashLabel) {
        _controlFlashLabel = [[UILabel alloc]init];
        _controlFlashLabel.backgroundColor = [UIColor clearColor];
        [_controlFlashLabel setText:@"轻触点亮"];
        [_controlFlashLabel setTextColor:[UIColor whiteColor]];
        _controlFlashLabel.font = [UIFont systemFontOfSize:13];
    }
    return _controlFlashLabel;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
