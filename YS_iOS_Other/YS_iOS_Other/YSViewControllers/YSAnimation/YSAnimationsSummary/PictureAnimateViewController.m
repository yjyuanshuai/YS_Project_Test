//
//  PictureAnimateViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "PictureAnimateViewController.h"

@interface PictureAnimateViewController ()

@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UIButton * startBtn;
@property (strong, nonatomic) UIButton * stopBtn;

@end

@implementation PictureAnimateViewController
{
    NSMutableArray * _imageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self createUI];
    [self getImageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.title = @"帧动画";
}

- (void)createUI
{
    _pictureImageView = [UIImageView new];
    _pictureImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_pictureImageView];
    
    UIButton * startBtn = [UIButton new];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton * stopBtn = [UIButton new];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];

    [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(200);
        
        make.top.equalTo(self.view).with.offset(80);
    }];
    
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        
        make.top.equalTo(_pictureImageView.mas_bottom).with.offset(10);
    }];
    
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        
        make.top.equalTo(startBtn.mas_bottom).with.offset(10);
    }];
     
    
}

- (void)getImageData
{
    _imageArr = [NSMutableArray array];
    for (int i = 1; i <= 4; i++) {
        NSString * imageName = [NSString stringWithFormat:@"test%.2d", i];
        NSString * path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        [_imageArr addObject:image];
    }
    
    _pictureImageView.image = [_imageArr firstObject];
    _pictureImageView.animationImages = [NSArray arrayWithArray:_imageArr];
    _pictureImageView.animationDuration = [_imageArr count] * 1;
    _pictureImageView.animationRepeatCount = 0;
}

#pragma mark -
- (void)startAnimation
{
    if (!_pictureImageView.isAnimating) {
        [_pictureImageView startAnimating];
    }
}

- (void)stopAnimation
{
    if (_pictureImageView.isAnimating) {
        [_pictureImageView stopAnimating];
    }
}

@end
