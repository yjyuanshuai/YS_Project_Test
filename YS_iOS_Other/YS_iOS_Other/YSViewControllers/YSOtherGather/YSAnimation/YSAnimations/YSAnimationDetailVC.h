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
    YSAnimationTypeTurnArounds, // 转场动画
    YSAnimationTypeSpring       // 弹簧
};

typedef NS_ENUM(NSInteger, YSAnimation2or3DType)
{
    YSAnimation2or3DTypePosition,    // 位移
    YSAnimation2or3DTypeScale,       // 缩放
    YSAnimation2or3DType2DRotation,  // 2d 旋转
    YSAnimation2or3DType3DRotation,  // 3d 旋转
    YSAnimation2or3DTypePath,        // 路径
    YSAnimation2or3DTypeKey,         // 关键帧
    YSAnimation2or3DTypeColor,       // 渐变色
    YSAnimation2or3DTypeShake,       // 抖动
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
