//
//  EZXingScanBasicView.h
//  EZXingObjC
//
//  Created by erics on 2018/7/27.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZXingWrapper.h"

typedef void(^zxingResultBlock)(ZXBarcodeFormat barcodeFormat ,UIImage * image ,NSString * scanResult );

@interface EZXingScanBasicView : UIView


- (void)initiateZxingScanesultBlock:(zxingResultBlock)block;

/**
 ZXing扫码对象
 */
@property (nonatomic, strong) EZXingWrapper * zxingObj;

@end
