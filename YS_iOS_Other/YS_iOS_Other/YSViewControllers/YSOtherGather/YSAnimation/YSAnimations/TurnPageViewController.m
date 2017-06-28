//
//  TurnPageViewController.m
//  各种动画Test
//
//  Created by YJ on 16/3/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "TurnPageViewController.h"
#import "UIView+UniformDistribution.h"
#import "NSString+YSStringDo.h"

static NSInteger const AnimationBtnTag = 20161222;

typedef NS_ENUM(NSInteger, TransitionType)
{
    Fade = 1,               //淡入淡出
    Push,                   //推挤
    Reveal,                 //揭开
    MoveIn,                 //覆盖
    
    
    Cube,                   //立方体
    SuckEffect,             //吸附
    OglFlip,                //翻转
    RippleEffect,           //波纹
    PageCurl,               //翻页
    PageUnCurl,             //反翻页
    CameraIrisHollowOpen,   //开镜头
    CameraIrisHollowClose,  //关镜头
    
    
    CurlDown,               //下翻转
    CurlUp,                 //上翻转
    FlipFromLeft,           //左翻转
    FlipFromRight           //右翻转
};

@interface TurnPageViewController()

@end

@implementation TurnPageViewController
{
    UIImageView * view;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    [self createView];
    [self createStartBtn];
}

- (void)initUI
{
    self.title = @"翻页动画";
}

- (void)createView
{
    view = [UIImageView new];
    view.backgroundColor = [UIColor redColor];
    view.image = [UIImage imageNamed:@"test03"];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 250));
        make.top.equalTo(self.view).offset(10);
        make.centerX.equalTo(self.view);
    }];
}

- (void)createStartBtn
{
    UIButton * kCAFadeBtn = [UIButton new];
    kCAFadeBtn.tag = AnimationBtnTag + Fade;
    [kCAFadeBtn setTitle:@"淡入出" forState:UIControlStateNormal];
    [kCAFadeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [kCAFadeBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kCAFadeBtn];
    
    UIButton * kCAPushBtn = [UIButton new];
    kCAPushBtn.tag = AnimationBtnTag + Push;
    [kCAPushBtn setTitle:@"推挤" forState:UIControlStateNormal];
    [kCAPushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [kCAPushBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kCAPushBtn];
    
    UIButton * kCARevealBtn = [UIButton new];
    kCARevealBtn.tag = AnimationBtnTag + Reveal;
    [kCARevealBtn setTitle:@"揭开" forState:UIControlStateNormal];
    [kCARevealBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [kCARevealBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kCARevealBtn];
    
    UIButton * kCAMoveInBtn = [UIButton new];
    kCAMoveInBtn.tag = AnimationBtnTag + MoveIn;
    [kCAMoveInBtn setTitle:@"覆盖" forState:UIControlStateNormal];
    [kCAMoveInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [kCAMoveInBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kCAMoveInBtn];
    
    [kCAFadeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-170);
        
        make.centerY.equalTo(@[kCAPushBtn, kCAMoveInBtn, kCARevealBtn]);
        make.size.equalTo(@[kCAPushBtn, kCAMoveInBtn, kCARevealBtn]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[kCAFadeBtn, kCAPushBtn, kCARevealBtn, kCAMoveInBtn]];
    
    
    
    UIButton * makeScaleBtn = [UIButton new];
    makeScaleBtn.tag = AnimationBtnTag + Cube;
    [makeScaleBtn setTitle:@"立体旋转" forState:UIControlStateNormal];
    [makeScaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn];
    
    UIButton * rotationBtn = [UIButton new];
    rotationBtn.tag = AnimationBtnTag + PageCurl;
    [rotationBtn setTitle:@"翻页翻过" forState:UIControlStateNormal];
    [rotationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn];
    
    UIButton * scaleBtn = [UIButton new];
    scaleBtn.tag = AnimationBtnTag + PageUnCurl;
    [scaleBtn setTitle:@"翻页翻回" forState:UIControlStateNormal];
    [scaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn];
    
    UIButton * makeScaleBtn2 = [UIButton new];
    makeScaleBtn2.tag = AnimationBtnTag + RippleEffect;
    [makeScaleBtn2 setTitle:@"水滴波纹" forState:UIControlStateNormal];
    [makeScaleBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [makeScaleBtn2 addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeScaleBtn2];
    
    UIButton * rotationBtn2 = [UIButton new];
    rotationBtn2.tag = AnimationBtnTag + SuckEffect;
    [rotationBtn2 setTitle:@"飘缩" forState:UIControlStateNormal];
    [rotationBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rotationBtn2 addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rotationBtn2];
    
    UIButton * scaleBtn2 = [UIButton new];
    scaleBtn2.tag = AnimationBtnTag + OglFlip;
    [scaleBtn2 setTitle:@"翻转" forState:UIControlStateNormal];
    [scaleBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scaleBtn2 addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scaleBtn2];
    
    [makeScaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-130);
        
        make.centerY.equalTo(@[rotationBtn, scaleBtn]);
        make.size.equalTo(@[rotationBtn, scaleBtn]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn, rotationBtn, scaleBtn]];
    
    [makeScaleBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-90);
        
        make.centerY.equalTo(@[rotationBtn2, scaleBtn2]);
        make.size.equalTo(@[rotationBtn2, scaleBtn2]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[makeScaleBtn2, rotationBtn2, scaleBtn2]];
    
    
    
    
    
    UIButton * cameraOpenBtn = [UIButton new];
    cameraOpenBtn.tag = AnimationBtnTag + CameraIrisHollowOpen;
    [cameraOpenBtn setTitle:@"镜头打开" forState:UIControlStateNormal];
    [cameraOpenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cameraOpenBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraOpenBtn];
    
    UIButton * cameraCloseBtn = [UIButton new];
    cameraCloseBtn.tag = AnimationBtnTag + CameraIrisHollowClose;
    [cameraCloseBtn setTitle:@"镜头关闭" forState:UIControlStateNormal];
    [cameraCloseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cameraCloseBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraCloseBtn];
    
    [cameraOpenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        
        make.centerY.equalTo(@[cameraCloseBtn]);
        make.size.equalTo(@[cameraCloseBtn]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[cameraOpenBtn, cameraCloseBtn]];
    
    
    
    
    UIButton * curlDownBtn = [UIButton new];
    curlDownBtn.tag = AnimationBtnTag + CurlDown;
    [curlDownBtn setTitle:@"下翻转" forState:UIControlStateNormal];
    [curlDownBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [curlDownBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:curlDownBtn];
    
    UIButton * curlUpBtn = [UIButton new];
    curlUpBtn.tag = AnimationBtnTag + CurlUp;
    [curlUpBtn setTitle:@"上翻转" forState:UIControlStateNormal];
    [curlUpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [curlUpBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:curlUpBtn];
    
    UIButton * flipLeftBtn = [UIButton new];
    flipLeftBtn.tag = AnimationBtnTag + FlipFromLeft;
    [flipLeftBtn setTitle:@"左翻转" forState:UIControlStateNormal];
    [flipLeftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [flipLeftBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flipLeftBtn];
    
    UIButton * flipRightBtn = [UIButton new];
    flipRightBtn.tag = AnimationBtnTag + FlipFromRight;
    [flipRightBtn setTitle:@"右翻转" forState:UIControlStateNormal];
    [flipRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [flipRightBtn addTarget:self action:@selector(clickTokCAAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flipRightBtn];
 
    [curlDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        
        make.centerY.equalTo(@[curlUpBtn, flipLeftBtn, flipRightBtn]);
        make.size.equalTo(@[curlUpBtn, flipLeftBtn, flipRightBtn]);
    }];
    
    [self.view distributeSpacingHorizontallyWith:@[curlDownBtn, curlUpBtn, flipLeftBtn, flipRightBtn]];
}

#pragma mark -
- (void)clickTokCAAnimation:(UIButton *)btn
{
    TransitionType type = btn.tag - AnimationBtnTag;
    
    if (type == Fade ||
        type == Push ||
        type == Reveal ||
        type == MoveIn) {
        
        [self addTransition:[self getTransitionType:type] subType:kCATransitionFromLeft];
        
    }
    else if (type == CameraIrisHollowOpen || type == CameraIrisHollowClose) {
        
        [self addTransition:[self getTransitionType:type] subType:nil];
    }
    else if (type == CurlDown ||
             type == CurlUp ||
             type == FlipFromLeft ||
             type == FlipFromRight) {
    
        NSNumber * num = [self getTransitionType:type];
        [self animationWithView:view WithAnimationTransition:[num integerValue]];
    }
    else {
        switch (type) {
                
            case Cube:
                [self addTransition:[self getTransitionType:Cube] subType:nil];
                break;
            case SuckEffect:
                [self addTransition:[self getTransitionType:SuckEffect] subType:nil];
                break;
            case OglFlip:
                [self addTransition:[self getTransitionType:OglFlip] subType:kCATransitionFromTop];
                break;
            case RippleEffect:
                [self addTransition:[self getTransitionType:RippleEffect] subType:nil];
                break;
            case PageCurl:
                [self addTransition:[self getTransitionType:PageCurl] subType:kCATransitionFromRight];
                break;
            case PageUnCurl:
                [self addTransition:[self getTransitionType:PageUnCurl] subType:kCATransitionFromLeft];
                break;
                
        }

    }
}

#pragma mark - 
- (void)addTransition:(NSString *)type subType:(NSString *)subType
{
    CATransition * tran = [CATransition animation];
    [tran setDuration:1.0];
    tran.type = type;
    if (![subType isBlank]) {
        tran.subtype = subType;
    }
    tran.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:tran forKey:nil];
}

- (id)getTransitionType:(TransitionType)type
{
    switch (type) {
        case Fade:
            return kCATransitionFade;
            break;
        case Push:
            return kCATransitionPush;
            break;
        case Reveal:
            return kCATransitionReveal;
            break;
        case MoveIn:
            return kCATransitionMoveIn;
            break;
            
        case Cube:
            return @"cube";             //立体旋转 cube
            break;
        case SuckEffect:
            return @"suckEffect";       //飘缩 suckEffect
            break;
        case OglFlip:
            return @"oglFlip";          //翻转 oglFlip
            break;
        case RippleEffect:
            return @"rippleEffect";     //水滴波纹 rippleEffect
            break;
        case PageCurl:
            return @"pageCurl";         //翻页翻过 pageCurl
            break;
        case PageUnCurl:
            return @"pageUnCurl";       //翻页返回 pageUnCurl
            break;
        case CameraIrisHollowOpen:
            return @"cameraIrisHollowOpen";     // 相机打开
            break;
        case CameraIrisHollowClose:
            return @"cameraIrisHollowClose";    // 相机关闭
            break;
            
        case CurlDown:
            return @(UIViewAnimationTransitionCurlDown);
            break;
        case CurlUp:
            return @(UIViewAnimationTransitionCurlUp);
            break;
        case FlipFromLeft:
            return @(UIViewAnimationTransitionFlipFromLeft);
            break;
        case FlipFromRight:
            return @(UIViewAnimationTransitionFlipFromRight);
            break;
            
        default:
            break;
    }
}

- (void)animationWithView:(UIView *)toView WithAnimationTransition:(UIViewAnimationTransition)transition{
    
    [UIView animateWithDuration:2.0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:toView cache:YES];
    }];
}

@end
