//
//  YSCustemCollectionViewListView.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionViewListView.h"

@interface YSCustemCollectionViewListView()

@end

@implementation YSCustemCollectionViewListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)createTableView
{
    _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self addSubview:_listTableView];
    
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#param mark - UITableViewDelegate, UITableViewDataSource

@end
