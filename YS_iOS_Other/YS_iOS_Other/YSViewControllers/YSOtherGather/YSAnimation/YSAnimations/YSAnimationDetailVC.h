//
//  DemotionVC.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

typedef NS_ENUM(NSInteger, YSAnimationType)
{
    YSAnimationTypeImageKey,    // Image帧
    YSAnimationType2or3D,       // 普通 2D/3D 动画
    YSAnimationTypeTurnArounds  // 转场动画
};

typedef NS_ENUM(NSInteger, YSAnimationWay)
{
    YSAnimationWayDefault,          // API
    YSAnimationWayUIViewAPI,        // UIView api
    YSAnimationWayUIViewBlock,      // UIView block
    YSAnimationWayCAAnimation,      //
    YSAnimationWayCATransition
};

@interface YSAnimationDetailVC : YSRootViewController

- (instancetype)initWithAnimationType:(YSAnimationType)type
                         animationWay:(YSAnimationWay)way
                                title:(NSString *)title;

@end
