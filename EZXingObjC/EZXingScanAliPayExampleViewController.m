//
//  EZXingScanAliPayExampleViewController.m
//  EZXingObjC
//
//  Created by erics on 2018/8/3.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EZXingScanAliPayExampleViewController.h"
#import "EScanRectView.h"
#import "EZXingObjC.h"
@interface EZXingScanAliPayExampleViewController ()

@property (nonatomic, strong) EScanRectView * scanRectView;

@end

@implementation EZXingScanAliPayExampleViewController


#pragma mark -  Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -  System Delegate

#pragma mark -  CustomDelegate

#pragma mark -  Event Response

#pragma mark -  Private Methods
- (void)loadPage{
    __weak typeof(self)weakSelf = self;
    if (!self.scanRectView) {
        self.scanRectView = [[EScanRectView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight - kNavigationBarHeight)];
        [self.scanRectView drawScanViewWithStyle:OPScanTopRectStyle];
        [self.view addSubview:self.scanRectView];
        self.scanRectView.flashBlock = ^(BOOL isSelected) {

        };
        
    }
    
}

#pragma mark -  Public Methods

#pragma mark -  Getters and Setters

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
