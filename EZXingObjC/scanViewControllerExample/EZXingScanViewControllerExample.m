//
//  EZXingScanViewControllerExample.m
//  EZXingObjC
//
//  Created by erics on 2018/8/3.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EZXingScanViewControllerExample.h"
#import "EZXingObjC.h"
#import "EZXingScanBasicView.h"

@interface EZXingScanViewControllerExample ()
@property (nonatomic, strong) EZXingScanBasicView * scanBasicView;
@end

@implementation EZXingScanViewControllerExample

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = @"viewController 使用ZXingObjC";
    if (!_scanBasicView) {
        self.scanBasicView = [[EZXingScanBasicView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight)];
        [self.scanBasicView initiateZxingScanesultBlock:^(ZXBarcodeFormat barcodeFormat, UIImage *image, NSString *scanResult) {
            
        }];
    }
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
