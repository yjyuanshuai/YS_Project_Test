//
//  ThreeDemotionViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ThreeDemotionViewController.h"
#import "UIView+UniformDistribution.h"

@interface ThreeDemotionViewController()

@end

@implementation ThreeDemotionViewController
{
    UIImageView * imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    [self createImageView];
    [self createStartBtn];
}

- (void)initUI
{
    self.title = @"3D";
}

- (void)createImageView
{
    imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"test01"];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 200));
        make.top.equalTo(self.view.mas_top).with.offset(70);
    }];
}

- (void)createStartBtn
{
    UIButton * makeScaleBtn = [UIButton new];
    [makeScaleBtn setTitle:@"平移" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(makeScale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn = [UIButton new];
    [rotationBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(rotation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    UIButton * scaleBtn = [UIButton new];
    [scaleBtn setTitle:@"缩放" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn addTarget:self action:@selector(scale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn];
    
    [makeScaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        
        make.centerY.equalTo(@[rotationBtn, scaleBtn]);
        make.size.equalTo(@[rotationBtn, scaleBtn]);
    }];
    
    //    [rotationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //    }];
    //
    //    [scaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //    }];
    
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn, rotationBtn, scaleBtn]];
}

#pragma mark -
- (void)makeScale
{
    //
    
    
}

- (void)rotation
{
    imageView.layer.transform = CATransform3DRotate(imageView.layer.transform, M_PI_4, 1, 0, 0);
}

- (void)scale
{
    imageView.layer.transform = CATransform3DScale(imageView.layer.transform, 0, 0, 1);
}

@end
