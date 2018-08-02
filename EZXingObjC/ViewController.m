//
//  ViewController.m
//  EZXingObjC
//
//  Created by erics on 2018/7/7.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "ViewController.h"
#import "EZXingScanExample.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -  Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EZXingScanExample *vc = [EZXingScanExample new];
    [self pushViewController:vc animated:NO];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
