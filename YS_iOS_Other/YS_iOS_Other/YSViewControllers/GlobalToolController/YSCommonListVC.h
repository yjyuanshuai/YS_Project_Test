//
//  YSCommonListVC.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//


#import "YSRootViewController.h"

typedef NS_ENUM(NSInteger, YSListType)
{
    YSListTypeDefault,          // 默认，传入 View
    YSListTypeCalendarEvent,    // 日历事件
    YSListTypeRuntimeClass      // 获取 class 中各种列表
};

@interface YSCommonListVC : YSRootViewController

@property (nonatomic, strong) NSMutableArray * sectionTitleArr;
@property (nonatomic, strong) NSMutableArray * contentArr;


- (instancetype)initWithType:(YSListType)type title:(NSString *)title;

// 传入 View
- (instancetype)initWithTitle:(NSString *)title view:(UIView *)view;

@end





