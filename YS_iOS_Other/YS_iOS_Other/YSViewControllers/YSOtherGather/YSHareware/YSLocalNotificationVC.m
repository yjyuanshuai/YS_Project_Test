//
//  YSLocalNotificationVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/9/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSLocalNotificationVC.h"

@interface YSLocalNotificationVC ()

@property (nonatomic, strong) UITextField * nameTextFeild;
@property (nonatomic, strong) UITextField * contentTextFeild;
@property (nonatomic, strong) UIButton * sendBtn;

@end

@implementation YSLocalNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initWithUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithUI
{
    self.title = @"本地通知";

    _nameTextFeild = [UITextField new];
    _nameTextFeild.layer.borderColor = [UIColor blackColor].CGColor;
    _nameTextFeild.layer.borderWidth = 0.5;
    _nameTextFeild.layer.cornerRadius = 5;
    _nameTextFeild.font = YSFont_Sys(15);
    _nameTextFeild.placeholder = @"name";
    [self.view addSubview:_nameTextFeild];

    _contentTextFeild = [UITextField new];
    _contentTextFeild.layer.borderColor = [UIColor blackColor].CGColor;
    _contentTextFeild.layer.borderWidth = 0.5;
    _contentTextFeild.layer.cornerRadius = 5;
    _contentTextFeild.font = YSFont_Sys(15);
    _contentTextFeild.placeholder = @"content";
    [self.view addSubview:_contentTextFeild];

    [_nameTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(15);
        make.width.mas_equalTo(kScreenWidth-30);
        make.height.mas_equalTo(30);
    }];

    [_contentTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(_nameTextFeild.mas_bottom).offset(15);
        make.width.mas_equalTo(kScreenWidth-30);
        make.height.mas_equalTo(30);
    }];

    _sendBtn = [UIButton new];
    _sendBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _sendBtn.layer.borderWidth = 0.5;
    [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendBtn setTitle:@"发送本地通知" forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(clickSendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendBtn];

    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_contentTextFeild.mas_bottom).offset(15);
    }];
}

- (void)clickSendBtn:(UIButton *)btn
{
    [self sendLocalNoticfication:_contentTextFeild.text name:_nameTextFeild.text ring:YES];
}

- (void)sendLocalNoticfication:(NSString *)content name:(NSString *)name ring:(BOOL)ring
{
    UILocalNotification * localNotification = [[UILocalNotification alloc] init];
    // 触发时间、重复间隔
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];

    // 内容
    localNotification.alertBody = [NSString stringWithFormat:@"%@ : %@", name, content];
    localNotification.applicationIconBadgeNumber = ++[UIApplication sharedApplication].applicationIconBadgeNumber;
    if (ring) {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    }

    // 通知参数
    localNotification.userInfo = @{@"kLocalNotificationKey":@"通知参数"};
    localNotification.category = @"kNotificationCategoryIdentifer";

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
