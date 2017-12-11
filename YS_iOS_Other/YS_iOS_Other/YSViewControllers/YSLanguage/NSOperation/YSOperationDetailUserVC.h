//
//  YSOperationDetailUserVC.h
//  YS_iOS_Other
//
//  Created by YJ on 17/3/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSRootViewController.h"


typedef NS_ENUM(NSInteger, YS_OperationType)
{
    YS_OperationTypeInvocation,
    YS_OperationTypeBlock,
    YS_OperationTypeCustem
};

@interface YSOperationDetailUserVC : YSRootViewController

- (instancetype)initWithType:(YS_OperationType)type title:(NSString *)title;

@end
