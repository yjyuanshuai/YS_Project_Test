//
//  YSLoginViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSLoginViewController.h"
#import "YSScrollView.h"
#import "YSEnDecryptionMethod.h"
#import "YSTabBarController.h"
#import "YSRegisterViewController.h"
#import "MyKeyChainHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface YSLoginViewController ()

@property (nonatomic, strong) YSScrollView * scrollView;
@property (nonatomic, strong) UITextField * nameTextFeild;
@property (nonatomic, strong) UITextField * passWordTextFeild;
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, strong) UIButton * registerBtn;

@end

@implementation YSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createScrollView];
    [self createNameAndPassWord];
    [self saveAccountOrPassWord];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES];
    [self setTouchID];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScrollView
{
    _scrollView = [[YSScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_scrollView];
}

- (void)createNameAndPassWord
{
    _nameTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_scrollView.frame) + 20, kScreenWidth - 20, 40)];
    _nameTextFeild.placeholder = @"姓名";
    _nameTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextFeild.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_nameTextFeild];
    
    
    _passWordTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameTextFeild.frame) + 20, kScreenWidth - 20, 40)];
    _passWordTextFeild.placeholder = @"密码";
    _passWordTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextFeild.keyboardType = UIKeyboardTypeNumberPad;
    _passWordTextFeild.secureTextEntry = YES;
    [self.view addSubview:_passWordTextFeild];
    
    CGFloat btnWdth = (kScreenWidth - 20 - 80)/2;
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(10, CGRectGetMaxY(_passWordTextFeild.frame) + 20, btnWdth, 40);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(kScreenWidth - 10 - btnWdth, CGRectGetMaxY(_passWordTextFeild.frame) + 20, btnWdth, 40);
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(clickToRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    
    _loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _loginBtn.layer.borderWidth = 1;
    
    _registerBtn.layer.borderColor = [UIColor redColor].CGColor;
    _registerBtn.layer.borderWidth = 1;
}

- (void)clickToLogin
{
    [self.view endEditing:YES];
    
    NSString * inputAccoutMD5 = [YSEnDecryptionMethod encryptMD5StrForString:_nameTextFeild.text];
    NSString * inputPassWordMD5 = [YSEnDecryptionMethod encryptMD5StrForString:_passWordTextFeild.text];
    
    if ([inputAccoutMD5 isEqualToString:[YSEnDecryptionMethod encryptMD5StrForString:CurrentAccout]] &&
        [inputPassWordMD5 isEqualToString:[YSEnDecryptionMethod encryptMD5StrForString:CurrentPassword]]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:HasLogin];
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:HasKickOut];
        
        [MyKeyChainHelper saveUserName:_nameTextFeild.text userNameService:UserNameKey psaaword:inputPassWordMD5 psaawordService:UserPassWordKey];
        
        YSTabBarController * tabBarCon = [YSTabBarController sharedYSTabBarController];
        tabBarCon.selectedIndex = 0;
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCon;
    }
}

- (void)clickToRegister
{
    YSRegisterViewController * registerVC = [[YSRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)saveAccountOrPassWord
{
    BOOL hasLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:HasLogin] boolValue];
    BOOL hasKickOut = [[[NSUserDefaults standardUserDefaults] objectForKey:HasKickOut] boolValue];
    
    if (hasKickOut && !hasLogin) {
        // 保存用户名，不保存密码
        
        NSString * name = [MyKeyChainHelper getUserNameWithService:UserNameKey];
        _nameTextFeild.text = name;
        
        _passWordTextFeild.text = @"";
    }
}

- (void)setTouchID
{
    // 获取上下文
    LAContext * lacontext = [[LAContext alloc] init];
    
    NSError * canEvaluateError = nil;
    NSString * reasonStr = @"Touch ID Test";
    BOOL canEvaluate = [lacontext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&canEvaluateError];
    if (canEvaluate) {
        [lacontext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reasonStr reply:^(BOOL success, NSError * _Nullable error) {

            if (success) {
                // 这步是异步的
                dispatch_async(dispatch_get_main_queue(), ^{
                    YSTabBarController * ysTabBarCon = [YSTabBarController sharedYSTabBarController];
                    ysTabBarCon.selectedIndex = 0;
                    [UIApplication sharedApplication].keyWindow.rootViewController = ysTabBarCon;
                });

            }
            else {
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"------- LAErrorSystemCancel");
                    }
                        break;
                    case LAErrorUserCancel:
                    {
                        NSLog(@"------- LAErrorUserCancel");
                    }
                        break;
                    case LAErrorUserFallback:
                    {
                        NSLog(@"------- LAErrorUserFallback");
                    }
                        break;
                    default:
                        NSLog(@"------- Authentication failed");
                        break;
                }
            }
        }];
    }
    else {
        switch (canEvaluateError.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"------- LAErrorTouchIDNotEnrolled");
            }
                break;
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"------- LAErrorPasscodeNotSet");
            }
                break;
                
            default:
                NSLog(@"------- TouchID not available");
                break;
        }
    }
}

@end
