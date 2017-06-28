//
//  FileKnowledgeView.h
//  YS_iOS_Other
//
//  Created by YJ on 16/9/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileKnowledgeView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * fileTableView;

@end
