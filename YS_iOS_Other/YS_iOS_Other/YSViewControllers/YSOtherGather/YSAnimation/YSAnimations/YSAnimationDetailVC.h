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
    YSAnimationType2or3D,       
    YSAnimationTypeTurnArounds  // 转场动画
};

typedef NS_ENUM(NSInteger, YSAnimation2or3DType)
{
    YSAnimationTypePosition,    // 位移
    YSAnimationTypeScale,       // 缩放
    YSAnimationType2DRotation,  // 2d 旋转
    YSAnimationType3DRotation,  // 3d 旋转
    YSAnimationTypePath,        // 路径
    YSAnimationTypeKey,         // 关键帧
    YSAnimationTypeColor,       // 渐变色
    YSAnimationTypeShake,       // 抖动
    YSAnimationTypeSpring       // 弹簧
};

typedef NS_ENUM(NSInteger, YSAnimationWay)
{
    YSAnimationWayDefault,          // API
    YSAnimationWayUIViewAPI,        // UIView api
    YSAnimationWayUIViewBlock,      // UIView block
    YSAnimationWayCAAnimationGroup,      //
    YSAnimationWayCABasicAnimation,
    YSAnimationWayCAKeyframeAnimation,
    YSAnimationWayCASpringAnimation,
    YSAnimationWayCATransition
};

@interface YSAnimationDetailVC : YSRootViewController

- (instancetype)initWithAnimationType:(YSAnimationType)type
                         animationWay:(YSAnimationWay)way
                                title:(NSString *)title;

@end
