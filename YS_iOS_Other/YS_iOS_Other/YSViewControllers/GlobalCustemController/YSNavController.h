//
//  YSNavController.h
//  YS_iOS_Other
//
//  Created by YJ on 17/4/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSNavController : UINavigationController

+ (instancetype)sharedYSTabBarController;
- (void)saveAccountOrPassWord;

@end
