//
//  YSCommenInputVC.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSRootViewController.h"


typedef void (^YSInputCallBackBlock)(NSString * inputStr);

@interface YSCommenInputVC : YSRootViewController

- (instancetype)initWithTitle:(NSString *)title block:(YSInputCallBackBlock)block;

@end
