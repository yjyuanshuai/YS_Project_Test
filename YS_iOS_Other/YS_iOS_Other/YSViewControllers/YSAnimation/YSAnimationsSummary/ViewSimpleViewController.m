//
//  ViewSimpleViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewSimpleViewController.h"
#import "UIView+UniformDistribution.h"

@interface ViewSimpleViewController ()

@end

@implementation ViewSimpleViewController
{
    UIImageView * _aimaImageView;
    CATransition * _myAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self createImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.title = @"简单动画";
}

- (void)createImageView
{
    _aimaImageView = [UIImageView new] ;
    _aimaImageView.image = [UIImage imageNamed:@"test02"];
    [self.view addSubview:_aimaImageView];
    
    [_aimaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(70, 10, 100, 10));
    }];
    
    UIButton * makeScaleBtn = [UIButton new];
    [makeScaleBtn setTitle:@"block" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(createBlockAnimationStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn = [UIButton new];
    [rotationBtn setTitle:@"方法" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(createMethodAnimationStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    [makeScaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        
        make.centerY.equalTo(@[rotationBtn]);
        make.size.equalTo(@[rotationBtn]);
    }];
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn, rotationBtn]];
    
    
}

- (void)createBlockAnimationStart
{
    [UIView animateWithDuration:3.0 animations:^{
        
        _aimaImageView.frame = CGRectMake(10, 70, 150, 200);
        
    } completion:^(BOOL finished) {
        
        _aimaImageView.image = [UIImage imageNamed:@"test01"];
        
    }];
}

- (void)createMethodAnimationStart
{
    [UIView beginAnimations:@"uikitAniamtion" context:nil];
    [UIView setAnimationDuration:3.0];
    
    _aimaImageView.frame = CGRectMake(10, 70, 200, 200);
//    _aimaImageView.image = [UIImage imageNamed:@"test01"];
    
    [UIView commitAnimations];
}

@end
