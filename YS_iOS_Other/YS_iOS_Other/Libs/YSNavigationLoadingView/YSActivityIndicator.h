//
//  YSActivityIndicator.h
//  加载动画Test
//
//  Created by YJ on 16/4/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class MBProgressHUD;

typedef NS_ENUM(NSUInteger, YSLoadViewType)
{
    YSLoadViewTypeSystemActIndicatorDefault,     // 系统菊花 + 标题
    YSLoadViewTypeSystemActIndicatorDetail,      // 系统菊花 + 标题 + 描述
    YSLoadViewTypeTextDefault,                   // 标题
    YSLoadViewTypeTextDetail,                    // 标题 + 描述
    YSLoadViewTypeCustom                         // 自定义
};

@interface YSActivityIndicator : UIView

#pragma mark - property -

@property (nonatomic, assign) YSLoadViewType ysType;

@property (nonatomic, strong) UIActivityIndicatorView *     ysAcitityIndicator;
@property (nonatomic, assign) UIActivityIndicatorViewStyle  ysActivityIndicatorStyle;
@property (nonatomic, copy)   NSString * titleStr;                          // 加载标题
@property (nonatomic, copy)   NSString * descStr;                           // 加载描述
@property (nonatomic, strong) UIFont * titleFont;                           // 标题的字体
@property (nonatomic, strong) UIFont * descFont;                            // 描述的字体
@property (nonatomic, strong) UIColor * titleTextColor;                     // 标题的颜色
@property (nonatomic, strong) UIColor * descTextColor;                      // 描述的颜色
@property (nonatomic, assign) NSTimeInterval overTimeInterval;              // 超时时间
@property (nonatomic, strong) UIViewController * blongToViewController;
@property (nonatomic, copy)   NSString * msgText;                           // 提示语句（如超时 / 数据加载出错等）

@property (nonatomic, strong) UIView * ysCustomView;

#pragma mark - instance method -


#pragma mark - class method -
+ (instancetype)showInViewController:(UIViewController *)viewController;

+ (void)hideInViewController:(UIViewController *)viewController;
+ (void)hideInViewController:(UIViewController *)viewController finishBlock:(void (^)(void))block;

+ (void)hideInViewController:(UIViewController *)viewController msgHUDTitle:(NSString *)msg;
+ (void)hideInViewController:(UIViewController *)viewController msgHUDTitle:(NSString *)msg finishBlock:(void (^)(void))block;

@end
