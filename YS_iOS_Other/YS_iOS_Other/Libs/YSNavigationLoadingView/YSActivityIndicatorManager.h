//
//  YSActivityIndicatorManager.h
//  加载动画Test
//
//  Created by YJ on 16/4/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;

typedef void(^finishBlock)(void);

@interface YSActivityIndicatorManager : NSObject

+ (void)addDefaultIndicatorInController:(UIViewController *)viewController
                               titleStr:(NSString *)title;

+ (void)addDetailIndicatorInController:(UIViewController *)viewController
                              titleStr:(NSString *)title
                                  desc:(NSString *)desc;

+ (void)hideInController:(UIViewController *)viewController;

+ (void)hideInController:(UIViewController *)viewController
             finishBlock:(finishBlock)block;

+ (void)hideInController:(UIViewController *)viewController
                 msgText:(NSString *)msg;

+ (void)hideInController:(UIViewController *)viewController
                 msgText:(NSString *)msg
             finishBlock:(finishBlock)block;

@end
