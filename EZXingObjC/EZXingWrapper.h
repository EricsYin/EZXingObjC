//
//  EZXingWrapper.h
//  EZXingObjC
//
//  Created by erics on 2018/7/9.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZXBarcodeFormat.h"

typedef void(^ocrResultBlock)(NSString * phoneNumber,UIImage * scanImg);

@interface EZXingWrapper : NSObject


#define LBXScan_Define_ZXing



@property (nonatomic, copy) ocrResultBlock ocrBlock;

/**
 初始化ZXing
 
 @param preView 视频预览视图
 @param block 返回识别结果
 @return 返回封装对象
 */
- (instancetype)initWithPreView:(UIView*)preView block:(void(^)(ZXBarcodeFormat barcodeFormat,NSString *str,UIImage *scanImg))block;



/**
 设置识别区域，不设置默认全屏识别
 
 @param scanRect 识别区域
 */
- (void)setScanRect:(CGRect)scanRect;

//
/**
 销毁zxing对象,释放内存
 */
- (void)hardStopScan;



/**
 开启扫描,并且开启代理
 */
- (void)hardStartScan;

/*!
 *  开始扫码
 */
- (void)start;

/*!
 *  停止扫码
 */
- (void)stop;

/*!
 *  打开关闭闪光灯
 *
 *  @param on_off YES:打开闪光灯,NO:关闭闪光灯
 */
- (void)openTorch:(BOOL)on_off;


/*!
 *  根据闪光灯状态，自动切换
 */
- (void)openOrCloseTorch;


/*!
 *  生成二维码
 *
 *  @param str  二维码字符串
 *  @param size 二维码图片大小
 *  @param format 码的类型
 *  @return 返回生成的图像
 */
+ (UIImage*)createCodeWithString:(NSString*)str size:(CGSize)size CodeFomart:(ZXBarcodeFormat)format;




/*!
 *  识别各种码图片
 *
 *  @param image 图像
 *  @param block 返回识别结果
 */
+ (void)recognizeImage:(UIImage*)image block:(void(^)(ZXBarcodeFormat barcodeFormat,NSString *str))block;


/**
 切换Zxing 和OCR
 
 @param isOCR no>zxing识别单号    yes>ocr识别手机号
 */
- (void)zxingExpressCodeOrOcrIphone:(BOOL)isOCR;

@end
