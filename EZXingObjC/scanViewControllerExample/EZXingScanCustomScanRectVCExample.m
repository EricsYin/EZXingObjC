//
//  EZXingScanCustomScanRectVCExample.m
//  EZXingObjC
//
//  Created by erics on 2018/8/3.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EZXingScanCustomScanRectVCExample.h"
#import "EZXingScanBasicView.h"
#import "EZXingObjC.h"

@interface EZXingScanCustomScanRectVCExample ()

@property (nonatomic, strong) EZXingScanBasicView * scanBasicView;

@end

@implementation EZXingScanCustomScanRectVCExample

#pragma mark -  Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_scanBasicView) {
        self.scanBasicView = [[EZXingScanBasicView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight)];
        [self.view addSubview:self.scanBasicView];
        [self.scanBasicView initiateZxingScanesultBlock:^(ZXBarcodeFormat barcodeFormat, UIImage *image, NSString *scanResult) {
            
        }];
    }
    
}

#pragma mark -  System Delegate

#pragma mark -  CustomDelegate

#pragma mark -  Event Response

#pragma mark -  Private Methods

#pragma mark -  Public Methods

#pragma mark -  Getters and Setters

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
