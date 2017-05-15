//
//  YSActivityIndicatorManager.m
//  加载动画Test
//
//  Created by YJ on 16/4/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSActivityIndicatorManager.h"
#import "YSActivityIndicator.h"

@implementation YSActivityIndicatorManager

#pragma mark -
+ (void)addDefaultIndicatorInController:(UIViewController *)viewController titleStr:(NSString *)title
{
    YSActivityIndicator * loadingView = [YSActivityIndicator showInViewController:viewController];
    loadingView.ysType = YSLoadViewTypeSystemActIndicatorDefault;
    loadingView.ysActivityIndicatorStyle = UIActivityIndicatorViewStyleWhite;
    loadingView.titleStr = title;
    loadingView.titleTextColor = [UIColor whiteColor];
    loadingView.titleFont = [UIFont systemFontOfSize:20];
}

+ (void)addDetailIndicatorInController:(UIViewController *)viewController titleStr:(NSString *)title desc:(NSString *)desc
{
    YSActivityIndicator * loadingView = [YSActivityIndicator showInViewController:viewController];
    loadingView.ysType = YSLoadViewTypeSystemActIndicatorDetail;
    loadingView.ysActivityIndicatorStyle = UIActivityIndicatorViewStyleWhite;
    loadingView.titleStr = title;
    loadingView.descStr = desc;
    loadingView.titleTextColor = [UIColor whiteColor];
    loadingView.descTextColor = [UIColor whiteColor];
    loadingView.titleFont = [UIFont systemFontOfSize:20];
}

+ (void)hideInController:(UIViewController *)viewController
{
    [YSActivityIndicator hideInViewController:viewController];
}

+ (void)hideInController:(UIViewController *)viewController finishBlock:(finishBlock)block
{
    [YSActivityIndicator hideInViewController:viewController finishBlock:block];
}

+ (void)hideInController:(UIViewController *)viewController msgText:(NSString *)msg
{
    [YSActivityIndicator hideInViewController:viewController msgHUDTitle:msg];
}

+ (void)hideInController:(UIViewController *)viewController msgText:(NSString *)msg finishBlock:(finishBlock)block
{
    [YSActivityIndicator hideInViewController:viewController msgHUDTitle:msg finishBlock:block];
}

@end
