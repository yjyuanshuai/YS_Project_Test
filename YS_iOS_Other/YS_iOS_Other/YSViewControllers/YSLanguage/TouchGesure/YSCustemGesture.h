//
//  YSCustemGesture.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YSDirection)
{
    YSDirectionUnknow,
    YSDirectionLeft,
    YSDirectionRight,
    YSDirectionUp,
    YSDirectionDown,
    YSDirectionLeftAndUp,
    YSDirectionLeftAndDown,
    YSDirectionRightAndUp,
    YSDirectionRightAndDown
};




@interface YSCustemGesture : UIGestureRecognizer

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) YSDirection direction;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) NSInteger tickleCount;

@end
