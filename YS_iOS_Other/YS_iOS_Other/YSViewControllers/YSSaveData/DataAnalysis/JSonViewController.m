//
//  JSonViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 17/1/17.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "JSonViewController.h"

@interface JSonViewController ()

@end

@implementation JSonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (void)initUIAndData
{
    self.title = @"Json 解析";
    
    NSString * jsonStr = @"{\"name\": \"1\\u94bb\\u77f3\"}";
    NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error = nil;
    NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSString * value = dict[@"name"];
    DDLogInfo(@"--------------- %@", value);
}

@end
