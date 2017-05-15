//
//  TwoDemotionViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "TwoDemotionViewController.h"
#import "UIView+UniformDistribution.h"

@interface TwoDemotionViewController ()

@end

@implementation TwoDemotionViewController
{
    UIView * squareView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self createSquare];
    [self createStartBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.title = @"2D";
}

- (void)createSquare
{
    UIView * bgView = [UIView new];
    bgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bgView];

    squareView = [UIView new];
    squareView.backgroundColor = [UIColor redColor];
    [bgView addSubview:squareView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 100, 10));
    }];
    
    [squareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.top.equalTo(bgView.mas_top);
        make.left.equalTo(bgView.mas_left);
    }];
}

- (void)createStartBtn
{
    UIButton * makeScaleBtn = [UIButton new];
    [makeScaleBtn setTitle:@"单次平移" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(makeScale:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn = [UIButton new];
    [rotationBtn setTitle:@"单次旋转" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(rotation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    UIButton * scaleBtn = [UIButton new];
    [scaleBtn setTitle:@"单次缩放" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn addTarget:self action:@selector(scale:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn];
    
    UIButton * circleMoveBtn = [UIButton new];
    [circleMoveBtn setTitle:@"连续平移" forState:UIControlStateNormal];
    [circleMoveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [circleMoveBtn addTarget:self action:@selector(circleMove:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:circleMoveBtn];
    
    UIButton * circleRotationBtn = [UIButton new];
    [circleRotationBtn setTitle:@"连续平移" forState:UIControlStateNormal];
    [circleRotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [circleRotationBtn addTarget:self action:@selector(circleRotation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:circleRotationBtn];
    
    UIButton * circleScaleBtn = [UIButton new];
    [circleScaleBtn setTitle:@"连续平移" forState:UIControlStateNormal];
    [circleScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [circleScaleBtn addTarget:self action:@selector(circleScale:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:circleScaleBtn];
    
    [makeScaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10-30-10);
        
        make.centerY.equalTo(@[rotationBtn, scaleBtn]);
        make.size.equalTo(@[rotationBtn, scaleBtn]);
    }];
    
    [circleMoveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        
        make.centerY.equalTo(@[circleScaleBtn, circleRotationBtn]);
        make.size.equalTo(@[circleScaleBtn, circleRotationBtn]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn, rotationBtn, scaleBtn]];
    [self.view distributeSpacingHorizontallyWith:@[circleMoveBtn, circleRotationBtn, circleScaleBtn]];
}

#pragma mark - 
- (void)makeScale:(UIButton *)btn
{
    //
    squareView.transform = CGAffineTransformTranslate(squareView.transform, 10, 10);
}

- (void)rotation:(UIButton *)btn
{
    squareView.transform = CGAffineTransformRotate(squareView.transform, M_PI_4);
}

- (void)scale:(UIButton *)btn
{
    squareView.transform = CGAffineTransformScale(squareView.transform, -2, -2);
}

- (void)circleMove:(UIButton *)btn
{

}

- (void)circleRotation:(UIButton *)btn
{

}

- (void)circleScale:(UIButton *)btn
{

}

@end
