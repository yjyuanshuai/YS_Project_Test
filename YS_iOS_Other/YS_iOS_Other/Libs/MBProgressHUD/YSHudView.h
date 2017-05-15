//
//  YSHudView.h
//  HudDemo
//
//  Created by YJ on 16/5/31.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#define _DEVICE_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define _DEVICE_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define _DEVICE_HEIGHT_NO_20    [[UIScreen mainScreen] bounds].size.height - 20
#define _DEVICE_HEIGHT_NO_64    [[UIScreen mainScreen] bounds].size.height - 64

#define _APP_KEYWINDOW  [UIApplication sharedApplication].keyWindow



#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef void(^OverTimeBlock)();

@interface YSHudView : NSObject

@property (nonatomic, assign) BOOL isUserEnable;
@property (nonatomic, strong) OverTimeBlock overTimeBlock;
@property (nonatomic, strong, readonly) MBProgressHUD * mbProgressHud;
@property (nonatomic, strong) UIView * hudView;

@property (nonatomic, strong) UIViewController * currentVC;

#pragma mark - class method -

+ (instancetype)sharedYSHudView;

/**
 *  不覆盖
 */
+ (void)yiBaoEnableHUDShow;
/**
 *  覆盖 + （右侧键隐藏）
 */
+ (void)yiBaoUnEnableHUDShowToViewController:(UIViewController *)viewController;
/**
 *  覆盖 + （右侧键选择隐藏）
 */
+ (void)yiBaoUnEnableHUDShowToViewController:(UIViewController *)viewController
                             enableRightBarBtn:(BOOL)enable;
/**
 *  覆盖 + 超时后事件
 */
+ (void)yiBaoUnEnableHUDShowToViewController:(UIViewController *)viewController
                               overTimeBlock:(OverTimeBlock)overTimeBlock;
/**
 *  提示框 + （右侧键显示）
 */
+ (void)yiBaoHUDStopOrShowWithMsg:(NSString*)msg
                            finsh:(void (^)(void))finshBlock;
/**
 *  移除
 */
+ (void)yiBaoHUDHide;

#pragma mark - instance method -
/**
 *  不覆盖
 */
- (void)showEnableYiBaoHUD;
/**
 *  覆盖 + （隐藏右键）
 */
- (void)showUnEnableYiBaoHUDToViewController:(UIViewController *)viewController;
/**
 *  覆盖 + （隐藏右键） + 超时事件
 */
- (void)showUnEnableYiBaoHUDToViewController:(UIViewController *)viewController
                             enableRightBarBtn:(BOOL)enable
                               overTimeBlock:(OverTimeBlock)overTimeBlock;
/**
 *  提示框 + 右侧键显示
 */
- (void)stopOrShowWithMsg:(NSString*)msg
                    finsh:(void (^)(void))finshBlock;

- (void)hideHUD;

@end
