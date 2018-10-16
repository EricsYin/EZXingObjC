//
//  EOCRCapture.h
//  EZXingObjC
//
//  Created by erics on 2018/10/7.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^barCodeResult)(NSString * barCodeResult,UIImage * scanImage);
typedef void(^failResult)(NSString * errorMessage);

@interface EOCRCapture : NSObject

@property (nonatomic, copy) failResult failBlock;

@property (nonatomic, copy) barCodeResult barCodeBlock;

- (id)initWithPreView:(UIView*)preView
         barCodeBlock:(void(^)(NSString * barCodeResult,UIImage * scanImage))barCodeblock
            failBlock:(void(^)(NSString * message))failBlock;

- (void)restartOcrScan;

- (void)suspendOcrScan;
@end

NS_ASSUME_NONNULL_END
