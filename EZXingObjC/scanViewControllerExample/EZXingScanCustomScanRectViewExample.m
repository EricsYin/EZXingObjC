//
//  EZXingScanCustomScanRectViewExample.m
//  EZXingObjC
//
//  Created by erics on 2018/8/3.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EZXingScanCustomScanRectViewExample.h"
#import "EZXingScanBasicView.h"
#import "EZXingObjC.h"
@interface EZXingScanCustomScanRectViewExample ()
@property (nonatomic, strong) EZXingScanBasicView * scanBasicView;
@end

@implementation EZXingScanCustomScanRectViewExample

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
//    if (!_scanBasicView) {
    
    self.scanBasicView = [[EZXingScanBasicView alloc]init];
    [self.view addSubview:self.scanBasicView];
    self.scanBasicView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight);
    [self.scanBasicView initiateZxingScanesultBlock:^(ZXBarcodeFormat barcodeFormat, UIImage *image, NSString *scanResult) {
        [self.view bringSubviewToFront:self.scanBasicView];
    }];
    
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
