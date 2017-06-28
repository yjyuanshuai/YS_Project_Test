//
//  FileOrCodeViewController.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

@interface FileOrCodeViewController : YSRootViewController

- (instancetype)initWithTitle:(NSString *)title
                    viewClass:(Class)viewClass
                     rightBtn:(NSString *)rightBtn;

@end
