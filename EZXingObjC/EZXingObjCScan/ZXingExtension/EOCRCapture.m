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

//预览成像区域
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

//预览成像输出
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) dispatch_queue_t videoDataOutputQueue;
@property (nonatomic, assign) NSInteger frameInterval;//识别帧数间隔，默认为系统每秒最小帧数／6，即30帧下为5
@property (nonatomic, assign) NSInteger frameCount;

@property (nonatomic, assign) NSInteger imageFrameWidth;
@property (nonatomic, assign) NSInteger imageFrameHeight;

//预览成像后对取景区域坐标进行设置成像
@property (nonatomic, assign) CGRect borderRectInImage;
@property (nonatomic, assign) CGFloat angle;

@property (nonatomic, strong) UIView * preView;
@end

@implementation EOCRCapture

- (id)initWithPreView:(UIView *)preView
         barCodeBlock:(void (^)(NSString * _Nonnull, UIImage * _Nonnull))barCodeblock
            failBlock:(void (^)(NSString * _Nonnull))failBlock{
    if (self == [super init]) {
        self.barCodeBlock = barCodeblock;
        self.failBlock = failBlock;
        self.preView = preView;
        if (self.captureSession == nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
               
            });
        }else{
            [self.captureSession startRunning];
        }
        
        
    }
    return self;
}

@end
