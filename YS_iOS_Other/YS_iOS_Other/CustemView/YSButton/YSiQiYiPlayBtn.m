//
//  YSiQiYiPlayBtn.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/9/20.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSiQiYiPlayBtn.h"

@interface YSiQiYiPlayBtn()<CAAnimationDelegate>
@end

@implementation YSiQiYiPlayBtn
{
    BOOL _isAnimationing;

    CAShapeLayer * _leftLineLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIAndInitData];
    }
    return self;
}

- (void)setIQiYiState:(YSiQiYiPlayBtnStatus)iQiYiState
{
    if (_isAnimationing) {
        return;
    }

    _iQiYiState = iQiYiState;
    if (_iQiYiState == YSiQiYiPlayBtnStatusPlay) {
        // 暂停 -> 播放，正向动画

    }
    else if (_iQiYiState == YSiQiYiPlayBtnStatusPause) {
        // 播放 -> 暂停，反向动画

    }
}

#pragma mark -
- (void)createUIAndInitData
{
    _isAnimationing = NO;
    _iQiYiState = YSiQiYiPlayBtnStatusPause;

    [self startPostionLineLayer];
}


- (void)startPostionLineLayer
{
    CGFloat w = self.frame.size.width;

    UIBezierPath * startPostionPath = [UIBezierPath bezierPath];
    [startPostionPath moveToPoint:CGPointMake(0.2*w, 0.2*w)];
    [startPostionPath addLineToPoint:CGPointMake(0.2*w, 0.8*w)];

    _leftLineLayer = [CAShapeLayer layer];
    _leftLineLayer.path = startPostionPath.CGPath;
    _leftLineLayer.fillColor = YSColorDefault.CGColor;
    _leftLineLayer.strokeColor = [UIColor blackColor].CGColor;
    _leftLineLayer.lineCap = kCALineCapRound;
    _leftLineLayer.lineJoin = kCALineJoinMiter;//kCALineJoinRound;
    _leftLineLayer.lineWidth = 20;
    [self.layer addSublayer:_leftLineLayer];
}

- (void)startPostionTriangleLayer
{

}

- (void)startPostionCircelLayer
{

}

#pragma mark - CAAnimationDelegate

@end
