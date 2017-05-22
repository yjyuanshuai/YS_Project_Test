//
//  YSRootVC.m
//  YS_LightBlue
//
//  Created by YJ on 17/5/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSRootVC.h"

@interface YSRootVC ()

@end

@implementation YSRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTabToolBar
{
    UIToolbar * tabToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
    [self.view addSubview:tabToolBar];

    
}

@end
