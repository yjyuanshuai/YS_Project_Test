//
//  ViewSearchController.h
//  YS_iOS_Other
//
//  Created by YJ on 16/11/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

extern NSString * SearchHistoryKey;
extern NSInteger SearchSizeLimit;

@interface ViewSearchController : YSRootViewController

- (instancetype)initHasNewResultVC:(BOOL)newResult;

@end
