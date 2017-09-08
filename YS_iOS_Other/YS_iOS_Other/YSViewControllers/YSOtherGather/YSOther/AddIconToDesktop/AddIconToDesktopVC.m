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
    [btn addTarget:self action:@selector(clickToAdd:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 20161121;
    [self.view addSubview:btn];

    UIButton * ys_testAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ys_testAppBtn setTitle:@"点击拉起YS_Test应用" forState:UIControlStateNormal];
    [ys_testAppBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ys_testAppBtn.layer.borderColor = [UIColor blackColor].CGColor;
    ys_testAppBtn.layer.borderWidth = 1;
    [ys_testAppBtn addTarget:self action:@selector(clickToAdd:) forControlEvents:UIControlEventTouchUpInside];
    ys_testAppBtn.tag = 20170908;
    [self.view addSubview:ys_testAppBtn];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.top.equalTo(self.view).offset(40);
        make.centerX.equalTo(self.view);
    }];

    [ys_testAppBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).offset(20);
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

- (void)clickToAdd:(UIButton *)btn
{
    if (btn.tag == 20161121) {
        _server = [[HTTPServer alloc] init];
        [_server setType:@"_http._tcp."];
        [_server setPort:12345];

        NSString * webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
        [_server setDocumentRoot:webPath];
        [self startServer];
    }
    else if (btn.tag == 20170908) {
        NSString * openTmp = @"YSDevTmpScheme://";
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:openTmp]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openTmp]];
        }
        else {
            NSLog(@"没有安装 YS_Tmp，拉不起来咯~");
        }
    }
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
