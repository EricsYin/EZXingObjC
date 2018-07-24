//
//  EZXingWrapper.m
//  EZXingObjC
//
//  Created by erics on 2018/7/9.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EZXingWrapper.h"
#import "ZXingObjC.h"
#import "EZXCaptureDelegate.h"
#import "EZXCapture.h"
typedef void(^blockScan)(ZXBarcodeFormat barcodeFormat,NSString *str,UIImage *scanImg);

@interface EZXingWrapper() <EZXCaptureDelegate>

@property (nonatomic, strong) EZXCapture *capture;

@property (nonatomic,copy)blockScan block;

@property (nonatomic, assign) BOOL bNeedScanResult;

@property (nonatomic , assign) BOOL isOCR;

@end



@implementation EZXingWrapper

- (void)dealloc{
    
}



- (id)initWithPreView:(UIView*)preView block:(void(^)(ZXBarcodeFormat barcodeFormat,NSString *str,UIImage *scanImg))block
{
    if (self = [super init]) {
        
        self.capture = [[EZXCapture alloc] init];
        self.capture.camera = self.capture.back;
        self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        self.capture.rotation = 90.0f;
        
        self.capture.delegate = self;
        
        self.block = block;
        
        CGRect rect = preView.frame;
        //        rect.origin = CGPointZero;
        
        self.capture.layer.frame = rect;
        // [preView.layer addSublayer:self.capture.layer];
        
        [preView.layer insertSublayer:self.capture.layer atIndex:0];
        
    }
    return self;
}

- (void)hardStopScan
{
    self.capture.delegate = nil;
    self.bNeedScanResult = NO;
    [self.capture stop];
}


/**
 开启扫描,并且开启代理
 */
- (void)hardStartScan
{
    self.capture.delegate = self;
    self.bNeedScanResult = YES;
    [self.capture start];
}


- (void)setScanRect:(CGRect)scanRect
{
    
    self.capture.scanRect = scanRect;
}

- (void)start
{
    
    self.bNeedScanResult = YES;
    [self.capture start];
    
}

- (void)stop
{
    self.bNeedScanResult = NO;
    [self.capture stop];
    
}

- (void)openTorch:(BOOL)on_off
{
    [self.capture setTorch:on_off];
    
}
- (void)openOrCloseTorch
{
    [self.capture changeTorch];
}


#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result scanImage:(UIImage *)img
{
    
    if (!result) return;
    
    if (self.bNeedScanResult == NO) {
        
        return;
    }
    
    if (self.isOCR) {
        //如果是OCR状态，即使检测到单号也不反悔
        return;
    }
//    OPLog(@"ZxingBarcodeFormat = %u,ZxingScanResult = %@",result.barcodeFormat,result.text);
    if ( _block )
    {
        [self stop];
        
        _block(result.barcodeFormat,result.text,img);
    }
}

- (void)zxingLuminanceSourceImage:(UIImage *)image{
    [self ocrPhoneWithImage:image];
}

#pragma mark - Private Method

- (void)ocrPhoneWithImage:(UIImage *)image{
    if (self.isOCR) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [[OP_OCRManger sharedInstance] detectTextAccurateFromImage:image andinterval:1.0 WithResultHandle:^(NSString *phonenumber) {
//
//                if (self.ocrBlock) {
//                    self.ocrBlock(phonenumber, image);
//                }
//
//            } FailHandle:^(NSError *error) {
//                OPLog(@"%@",[error localizedDescription]);
//            }];
//        });
    }
}

#pragma mark - Public Method
- (void)zxingExpressCodeOrOcrIphone:(BOOL)isOCR{
    // @param isOCR no>zxing识别单号    yes>ocr识别手机号
    self.isOCR = isOCR;
}


+ (UIImage*)createCodeWithString:(NSString*)str size:(CGSize)size CodeFomart:(ZXBarcodeFormat)format
{
    ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc] init];
    ZXBitMatrix *result = [writer encode:str
                                  format:format
                                   width:size.width
                                  height:size.width
                                   error:nil];
    
    if (result) {
        ZXImage *image = [ZXImage imageWithMatrix:result];
        return [UIImage imageWithCGImage:image.cgimage];
    } else {
        return nil;
    }
}


+ (void)recognizeImage:(UIImage*)image block:(void(^)(ZXBarcodeFormat barcodeFormat,NSString *str))block;
{
    ZXCGImageLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:image.CGImage];
    
    ZXHybridBinarizer *binarizer = [[ZXHybridBinarizer alloc] initWithSource: source];
    
    ZXBinaryBitmap *bitmap = [[ZXBinaryBitmap alloc] initWithBinarizer:binarizer];
    
    NSError *error;
    
    id<ZXReader> reader;
    
    if (NSClassFromString(@"ZXMultiFormatReader")) {
        reader = [NSClassFromString(@"ZXMultiFormatReader") performSelector:@selector(reader)];
    }
    
    ZXDecodeHints *_hints = [ZXDecodeHints hints];
    ZXResult *result = [reader decode:bitmap hints:_hints error:&error];
    
    if (result == nil) {
        
        block(kBarcodeFormatQRCode,nil);
        return;
    }
    
    block(result.barcodeFormat,result.text);
}


@end
