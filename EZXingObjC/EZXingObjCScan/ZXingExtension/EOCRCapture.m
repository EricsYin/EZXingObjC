//
//  EOCRCapture.m
//  EZXingObjC
//
//  Created by erics on 2018/10/7.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EOCRCapture.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>

@interface EOCRCapture ()<AVCaptureVideoDataOutputSampleBufferDelegate>
//自定义相机
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@end

@implementation EOCRCapture

@end
