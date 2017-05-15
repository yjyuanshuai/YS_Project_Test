//
//  AddIconToDesktopVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AddIconToDesktopVC.h"
#import "HTTPServer.h"
#import "YSEnDecryptionMethod.h"

@interface AddIconToDesktopVC ()

@end

@implementation AddIconToDesktopVC
{
    HTTPServer * _server;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"在桌面创建快捷方式";
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击创建快捷方式" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(clickToAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.top.equalTo(self.view).offset(40);
        make.centerX.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_server stop];
}

- (void)clickToAdd
{
    _server = [[HTTPServer alloc] init];
    [_server setType:@"_http._tcp."];
    [_server setPort:12345];
    
    NSString * webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    
    [_server setDocumentRoot:webPath];
    
    [self startServer];
}

- (void)startServer
{
    NSError * error = nil;
    if ([_server start:&error]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://127.0.0.1:12345"]];
        NSLog(@"Started HTTP Server on port %hu", [_server listeningPort]);
    }
    else {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
}

- (void)createIndexHtmlContent
{
    NSData * imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"]];
    NSString * imageBase64Str = [YSEnDecryptionMethod encryptbase64StrforData:imageData];
}

@end
