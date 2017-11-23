//
//  YSCustemCollectionVC.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/2.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

typedef NS_ENUM(NSInteger, YSCustemCollectionViewType)
{
    YSCustemCollectionViewTypeFallWater = 0,    // 瀑布流
    YSCustemCollectionViewTypeStack,            // 堆叠
    YSCustemCollectionViewTypeCircle,           // 圆形
    YSCustemCollectionViewTypeCard,             // 卡片
    YSCustemCollectionViewTypeNavWheel
};

@interface YSCustemCollectionVC : YSRootViewController

- (instancetype)initWithType:(YSCustemCollectionViewType)type title:(NSString *)title;

@end
