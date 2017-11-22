//
//  YSCommonListVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCommonListVC.h"

@interface YSCommonListVC ()

@property (strong, nonatomic) Class viewClass;

@end

@implementation YSCommonListVC

- (instancetype)initWithTitle:(NSString *)title viewClass:(Class)viewClass
{
    self = [super init];
    if (self) {
        self.title = title;
        self.viewClass = viewClass;
    }
    return self;
}

- (void)loadView
{
    self.view = self.viewClass.new;
    self.view.backgroundColor = [UIColor whiteColor];
}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif

@end
