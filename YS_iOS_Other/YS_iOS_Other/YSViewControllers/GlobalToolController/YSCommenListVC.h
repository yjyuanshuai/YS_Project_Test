//
//  YSCommenListVC.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

typedef NS_ENUM(NSInteger, YSListType)
{
    YSListTypeCalendarEvent
};

@interface YSCommenListVC : YSRootViewController

@property (nonatomic, strong) NSMutableArray * sectionTitleArr;
@property (nonatomic, strong) NSMutableArray * contentArr;

- (instancetype)initWithType:(YSListType)type title:(NSString *)title;

@end
