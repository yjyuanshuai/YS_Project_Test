//
//  FileOrCodeViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "FileOrCodeViewController.h"

@interface FileOrCodeViewController ()

@property (nonatomic, strong) Class viewClass;

@end

@implementation FileOrCodeViewController

- (instancetype)initWithTitle:(NSString *)title
                    viewClass:(Class)viewClass
                     rightBtn:(NSString *)rightBtn
{
    if (self = [super init]) {
        
        self.title = title;
        _viewClass = viewClass;
        if (rightBtn != nil && ![rightBtn isEqualToString:@""]) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightBtn style:UIBarButtonItemStylePlain target:self action:@selector(clickToDetail)];
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view = [_viewClass new];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)clickToDetail
{
    
}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif

@end
