//
//  YSVedioPlayerView.h
//  YS_iOS_Other
//
//  Created by YJ on 17/4/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSVideoPlayerViewDelegate;

@interface YSVideoPlayerView : UIView

@property (nonatomic, assign) BOOL isShowToolBar;
@property (nonatomic, assign) BOOL isLandScape;         //是否横屏
@property (nonatomic, strong) UIImageView * imageView;  //临时
@property (nonatomic, strong) UIButton * backBtn;
@property (nonatomic, strong) UIButton * spaceBtn;
@property (nonatomic, strong) UIView * topToolBar;
@property (nonatomic, strong) UIView * bottemToolBar;
@property (nonatomic, strong) UITapGestureRecognizer * tapGesure;
@property (nonatomic, weak) id<YSVideoPlayerViewDelegate> delegate;

+ (instancetype)shareVideoPlayerView;
- (void)updateVideoPlayerViewWithFrame:(CGRect)frame;
- (void)updateVideoPlayerViewWithIsLandScape:(BOOL)isLandScape;

@end



@protocol YSVideoPlayerViewDelegate <NSObject>

- (void)clickSpaceBtn;
- (void)clickTapGesure;
- (void)clickBackBtn;

@end
