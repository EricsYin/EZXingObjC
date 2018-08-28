//
//  EZXingScanExample.m
//  EZXingObjC
//
//  Created by erics on 2018/8/1.
//  Copyright © 2018年 EricsYinGroup. All rights reserved.
//

#import "EZXingScanExample.h"
#import "EZXingScanCustomScanRectViewExample.h"

@interface EZXingScanExample ()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation EZXingScanExample

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"EZXingObjCExample";
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    
    [self addCell:@"EZXingObjC UIViewController similar WeChat " class:@"EZXingScanWeChatExampleViewController"];
    [self addCell:@"EZXingObjC UIViewController similar AliPay " class:@"EZXingScanAliPayExampleViewController"];
    [self addCell:@"EZXingObjC used in custom UIView" class:@"EZXingScanCustomScanRectViewExample"];
    [self addCell:@"EZXingObjC used in custom UIViewController" class:@"EZXingScanViewControllerExample"];
    [self addCell:@"EZXingObjC UIViewController custom scan rect " class:@"EZXingScanCustomScanRectVCExample"];
    [self addCell:@"EZXingObjC UIView custom scan rect " class:@"EZXingScanCustomScanRectViewExample"];
    
    
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    
    [self.titles addObject:title];
    [self.classNames addObject:className];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EZXingObjC"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EZXingObjC"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);        
    EZXingScanCustomScanRectViewExample * vc = [[EZXingScanCustomScanRectViewExample alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    if (class) {
//        UIViewController * example = class.new;
//        example.title = _titles[indexPath.row];
//        [self.navigationController pushViewController:example animated:YES];
//    }
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
