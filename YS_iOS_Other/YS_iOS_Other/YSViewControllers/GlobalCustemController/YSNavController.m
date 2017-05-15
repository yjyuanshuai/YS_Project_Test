//
//  YSNavController.m
//  YS_iOS_Other
//
//  Created by YJ on 17/4/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSNavController.h"
#import "YSLoginViewController.h"

@interface YSNavController ()

@property (nonatomic, strong) YSLoginViewController * loginVC;

@end

@implementation YSNavController

+ (instancetype)sharedYSTabBarController
{
    static YSNavController * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        YSLoginViewController * instanceLoginVC = [[YSLoginViewController alloc] init];
        instance = [[YSNavController alloc] initWithRootViewController:instanceLoginVC];
        
    });
    return instance;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        if ([rootViewController isKindOfClass:[YSLoginViewController class]]) {
            _loginVC = (YSLoginViewController *)rootViewController;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveAccountOrPassWord
{
    if (_loginVC) {
        [_loginVC saveAccountOrPassWord];
    }
}

#pragma mark - 
- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

@end
