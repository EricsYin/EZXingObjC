//
//  EZXingScanBasicView.m
//  EZXingObjC
//
//  Created by erics on 2018/7/27.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EZXingScanBasicView.h"
#import "EScanRectView.h"
#import "EZXingObjC.h"
#import <AVFoundation/AVFoundation.h>

@interface EZXingScanBasicView ()

@property (nonatomic, copy) zxingResultBlock  resultBlock;

@property (nonatomic, strong) EScanRectView * scanRectView;

@end

@implementation EZXingScanBasicView

#pragma mark Life Cycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self loadPage];
    }
    return self;
}



#pragma mark Private Method

- (void)loadPage{
    __weak typeof(self)weakSelf = self;
    if (!_scanRectView) {
        self.scanRectView = [[EScanRectView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight,kScreenWidth, kScreenHeight - kNavigationBarHeight)];
        [self.scanRectView drawScanViewWithStyle:OPScanCenterRectStyle];
        [self insertSubview:self.scanRectView atIndex:0];
        
        self.scanRectView.flashBlock = ^(BOOL isSelected) {
            [weakSelf.zxingObj openTorch:isSelected];
        };
    }
}



#pragma mark Public Method

- (void)initiateZxingScanesultBlock:(zxingResultBlock)block{
    self.resultBlock =  block;
#if TARGET_IPHONE_SIMULATOR
    
#else
    [self.zxingObj hardStartScan];
    
    
    [self requestCameraPemissionWithResult:^(BOOL granted) {
        
        if (granted) {
   
            //            //不延时，动画出不来，需要延时，再处理
            //            [self performSelector:@selector(startScan) withObject:nil afterDelay:0.3];
            
            [self startScan];
            
            
        }else{
            // 做一些alert提示关于相机权限的提示
        
        }
    }];
    
#endif
}


#pragma mark Privare Method
/**
 获取相机权限
 */
- (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion
{
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                completion(YES);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                completion(NO);
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 if (granted) {
                                                     completion(true);
                                                 } else {
                                                     completion(false);
                                                 }
                                             });
                                             
                                         }];
            }
                break;
                
        }
    }
}

//启动设备
- (void)startScan
{
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    videoView.backgroundColor = [UIColor clearColor];
    [self insertSubview:videoView atIndex:0];
    
    __weak typeof(self)weakSelf = self;
    if (!_zxingObj) {
        
        _zxingObj = [[EZXingWrapper alloc]initWithPreView:videoView block:^(ZXBarcodeFormat barcodeFormat, NSString *str, UIImage *scanImg) {
            
            ///>位数限定
            //              [KLCPopup dismissAllPopups];
            //            KLCPopup * popUp ;
            //
            //            UIImageView * imageView = [[UIImageView alloc]initWithImage:scanImg];
            //            imageView.size = CGSizeMake(200, 200);
            //           popUp = [KLCPopup popupWithContentView:imageView];
            //            [popUp showWithLayout:KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutTop)];

            //扫描结果回调
            if (weakSelf.resultBlock) {
                weakSelf.resultBlock(barcodeFormat,scanImg ,str);
            }
            
        }];
        
    }
    
    //设置只识别框内区域
    CGRect cropRect = [EScanRectView getZXingScanRectWithPreView:self];
    
    [_zxingObj setScanRect:cropRect];
    
    
    [_zxingObj start];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


