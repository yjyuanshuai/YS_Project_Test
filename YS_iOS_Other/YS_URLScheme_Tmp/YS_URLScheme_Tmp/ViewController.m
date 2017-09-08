//
//  ViewController.m
//  YS_URLScheme_Tmp
//
//  Created by YJ on 2017/9/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)openYS_TestAppBtn:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openYS_TestAppBtn:(UIButton *)sender {
    NSString * openYSTest = @"YSDevScheme://nancey.win/";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:openYSTest]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openYSTest]];
    }
    else {
        NSLog(@"没有安装 YS_Test，拉不起来哦~");
    }
}

@end
