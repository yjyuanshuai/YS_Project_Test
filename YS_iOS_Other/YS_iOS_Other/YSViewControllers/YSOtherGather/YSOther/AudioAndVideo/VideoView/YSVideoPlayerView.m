//
//  YSVedioPlayerView.m
//  YS_iOS_Other
//
//  Created by YJ on 17/4/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSVideoPlayerView.h"

static YSVideoPlayerView * instance = nil;

@implementation YSVideoPlayerView

+ (instancetype)shareVideoPlayerView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.75*kScreenWidth)];
    });
    return instance;
}

- (void)updateVideoPlayerViewWithFrame:(CGRect)frame
{
    instance.frame = frame;
}

- (void)updateVideoPlayerViewWithIsLandScape:(BOOL)isLandScape
{
    _isLandScape = isLandScape;
}





#pragma mark - 
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isLandScape = NO;
        _isShowToolBar = YES;
        [self createSubViews];
        [self createToolBar];
        [self createTapGesure];
    }
    return self;
}

- (void)createSubViews
{
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"5" ofType:@"jpg"]];
    [self addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.center.equalTo(self);
    }];
}

- (void)createToolBar
{
    _topToolBar = [[UIView alloc] initWithFrame:CGRectZero];
    _topToolBar.backgroundColor = [UIColor clearColor];
    [self addSubview:_topToolBar];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"tab_fiv_sel"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(selfClickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [_topToolBar addSubview:_backBtn];
    
    [_topToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(_topToolBar).offset(10);
        make.centerY.equalTo(_topToolBar);
    }];
    
    
    _bottemToolBar = [[UIView alloc] initWithFrame:CGRectZero];
    _bottemToolBar.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottemToolBar];
    
    _spaceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_spaceBtn setBackgroundImage:[UIImage imageNamed:@"tab_fiv_sel"] forState:UIControlStateNormal];
    [_spaceBtn addTarget:self action:@selector(selfClickSpaceBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bottemToolBar addSubview:_spaceBtn];

    [_bottemToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [_spaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(_bottemToolBar);
        make.centerY.equalTo(_bottemToolBar);
    }];
    
    [self bringSubviewToFront:_topToolBar];
    [self bringSubviewToFront:_bottemToolBar];
    
    _spaceBtn.backgroundColor = [UIColor whiteColor];
    _backBtn.backgroundColor = [UIColor whiteColor];
}

- (void)createTapGesure
{
    _tapGesure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfClickTapGesure)];
    [self addGestureRecognizer:_tapGesure];
}

- (void)selfClickSpaceBtn
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickSpaceBtn)]) {
        [_delegate clickSpaceBtn];
    }
}

- (void)selfClickTapGesure
{
    _isShowToolBar = !_isShowToolBar;
    
    NSTimeInterval durationTime = 3.0;
    
    if (_isShowToolBar) {
        [UIView animateWithDuration:durationTime animations:^{
            [_topToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(-44);
            }];
            
            [_bottemToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).offset(44);
            }];
        }];
    }
    else {
        [UIView animateWithDuration:durationTime animations:^{
            [_topToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
            }];
            
            [_bottemToolBar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
            }];
        }];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickTapGesure)]) {
        [_delegate clickTapGesure];
    }
}

- (void)selfClickBackBtn
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickBackBtn)]) {
        [_delegate clickBackBtn];
    }
}

@end
