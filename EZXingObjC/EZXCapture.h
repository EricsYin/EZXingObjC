//
//  EZXCapture.h
//  EZXingObjC
//
//  Created by erics on 2018/7/9.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "EZXCaptureDelegate.h"



@class ZXDecodeHints;

@interface EZXCapture : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate,CAAction>

@end
