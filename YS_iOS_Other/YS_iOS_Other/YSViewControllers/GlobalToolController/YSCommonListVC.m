//
//  YSCommonListVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCommonListVC.h"

@interface YSCommonListVC ()

@property (strong, nonatomic) UIView * custemView;

@end

@implementation YSCommonListVC

- (instancetype)initWithTitle:(NSString *)title view:(UIView *)view
{
    self = [super init];
    if (self) {
        self.title = title;
        self.custemView = view;
    }
    return self;
}

- (void)loadView
{
    self.view = self.custemView;
    self.view.backgroundColor = [UIColor whiteColor];
}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif

@end
