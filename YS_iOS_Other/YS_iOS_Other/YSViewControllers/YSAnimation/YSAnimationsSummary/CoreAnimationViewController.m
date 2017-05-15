//
//  CoreAnimationViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CoreAnimationViewController.h"
#import "UIView+UniformDistribution.h"

typedef NS_ENUM(NSInteger, CoreAnimationType)
{
    CoreAnimationTypeBasic,
    CoreAnimationTypeGroup,
    CoreAnimationTypeKeyFrame,
    CoreAnimationTypeLuJing
};

static NSInteger const CoreAnimationBtnTag = 201612221533;

@interface CoreAnimationViewController ()

@end

@implementation CoreAnimationViewController
{
    UIImageView * _imageView;
    
    CABasicAnimation * _baseAnimation1;
    CABasicAnimation * _baseAnimation2;
    
    CAKeyframeAnimation * _keyFrameAnimation1;
    CAKeyframeAnimation * _keyFrameAnimation2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self createImageView];
    [self createStartBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.title = @"CoreAnimation";
}

- (void)createStartBtn
{
    UIButton * basicBtn = [UIButton new];
    basicBtn.tag = CoreAnimationBtnTag + CoreAnimationTypeBasic;
    [basicBtn setTitle:@"Basic" forState:UIControlStateNormal];
    [basicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [basicBtn addTarget:self action:@selector(clickStartAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:basicBtn];
    
    UIButton * groupBtn = [UIButton new];
    groupBtn.tag = CoreAnimationBtnTag + CoreAnimationTypeGroup;
    [groupBtn setTitle:@"Group" forState:UIControlStateNormal];
    [groupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [groupBtn addTarget:self action:@selector(clickStartAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:groupBtn];
    
    UIButton * keyFrameBtn = [UIButton new];
    keyFrameBtn.tag = CoreAnimationBtnTag + CoreAnimationTypeKeyFrame;
    [keyFrameBtn setTitle:@"KeyFrame" forState:UIControlStateNormal];
    [keyFrameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [keyFrameBtn addTarget:self action:@selector(clickStartAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keyFrameBtn];
    
    UIButton * lujingBtn = [UIButton new];
    lujingBtn.tag = CoreAnimationBtnTag + CoreAnimationTypeLuJing;
    [lujingBtn setTitle:@"路径" forState:UIControlStateNormal];
    [lujingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lujingBtn addTarget:self action:@selector(clickStartAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lujingBtn];
    
    [basicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        
        make.centerY.equalTo(@[groupBtn, keyFrameBtn, lujingBtn]);
        make.size.equalTo(@[groupBtn, keyFrameBtn, lujingBtn]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[basicBtn, groupBtn, keyFrameBtn, lujingBtn]];
}

- (void)createImageView
{
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"test04"];
    [self.view addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 250));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(40);
    }];
}

#pragma mark -
- (void)clickStartAnimation:(UIButton *)btn
{
    NSInteger tag = btn.tag - CoreAnimationBtnTag;
    
    switch (tag) {
        case CoreAnimationTypeBasic:
            [self createCABasicAnimation1];
            break;
        case CoreAnimationTypeGroup:
            [self createCABasicAnimation2];
            break;
        case CoreAnimationTypeKeyFrame:
            [self createCAKeyframeAnimation1];
            break;
        case CoreAnimationTypeLuJing:
            [self createCAKeyframeAnimation2];
            break;
        default:
            break;
    }
}

- (void)createCABasicAnimation1
{
    UIImage * toImage = nil;
    if ([_imageView.image isEqual:[UIImage imageNamed:@"test03"]]) {
        toImage = [UIImage imageNamed:@"test04"];
    }
    else {
        toImage = [UIImage imageNamed:@"test03"];
    }
    
    _baseAnimation1 = [CABasicAnimation animationWithKeyPath:@"contents"];
    //设置动画需改变的值
    _baseAnimation1.fromValue = (id)_imageView.image.CGImage;
    _baseAnimation1.toValue = (id)toImage.CGImage;
    _baseAnimation1.duration = 1.0;
    //
    //    _baseAnimation1.autoreverses = NO;
    _baseAnimation1.removedOnCompletion = NO;
    _baseAnimation1.fillMode = kCAFillModeForwards;
    [_imageView.layer addAnimation:_baseAnimation1 forKey:nil];
    
    _imageView.image = toImage;
}

- (void)createCABasicAnimation2
{
    UIImage * toImage = nil;
    if ([_imageView.image isEqual:[UIImage imageNamed:@"test03"]]) {
        toImage = [UIImage imageNamed:@"test04"];
    }
    else {
        toImage = [UIImage imageNamed:@"test03"];
    }
    
    _baseAnimation1 = [CABasicAnimation animationWithKeyPath:@"contents"];
    _baseAnimation1.toValue = (id)toImage.CGImage;
    
    _baseAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    _baseAnimation2.fromValue = [NSNumber numberWithFloat:1.0];
    _baseAnimation2.toValue = [NSNumber numberWithFloat:0.5];
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2.0;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.animations = @[_baseAnimation1, _baseAnimation2];
    
    [_imageView.layer addAnimation:animationGroup forKey:nil];
    
    _imageView.image = toImage;
}

- (void)createCAKeyframeAnimation1  // 关键帧
{
    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyAnimation.duration = 1.0;
    keyAnimation.beginTime = CACurrentMediaTime() + 1.0;
    
    CATransform3D tran1 = CATransform3DMakeScale(1.2, 1.2, 0);
    CATransform3D tran2 = CATransform3DMakeScale(0.8, 0.8, 0);
    CATransform3D tran3 = CATransform3DMakeScale(1, 1, 0);
    
    keyAnimation.values = @[[NSValue valueWithCATransform3D:tran1], [NSValue valueWithCATransform3D:tran2], [NSValue valueWithCATransform3D:tran3]];
    keyAnimation.keyTimes = @[@0, @0.5, @1];
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    [_imageView.layer addAnimation:keyAnimation forKey:nil];
}

- (void)createCAKeyframeAnimation2  // 路径
{
    //初始化路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddCurveToPoint(path, nil,
                          20, 70,
                          40, 80,
                          80, 100);
    
    _keyFrameAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    _keyFrameAnimation2.path = path;
    _keyFrameAnimation2.duration = 2.0;
    
    //渐出
    _keyFrameAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    _keyFrameAnimation2.rotationMode = @"auto";
    
    [_imageView.layer addAnimation:_keyFrameAnimation2 forKey:nil];
}

@end
