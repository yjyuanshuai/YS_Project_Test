//
//  FileManagerView.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileManagerView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * fileTableView;

@end
