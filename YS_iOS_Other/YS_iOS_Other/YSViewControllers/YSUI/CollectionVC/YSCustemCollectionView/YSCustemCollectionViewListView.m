//
//  YSCustemCollectionViewListView.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionViewListView.h"
#import "YSCustemCollectionVC.h"

static NSString * const YSCustemCollectionViewCellID = @"YSCustemCollectionViewCellID";

@interface YSCustemCollectionViewListView()

@end

@implementation YSCustemCollectionViewListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr = [@[@"瀑布流", @"堆叠", @"圆形", @"卡片"] mutableCopy];
        [self createTableView];
    }
    return self;
}

- (void)createTableView
{
    _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.estimatedRowHeight = 45;
    _listTableView.rowHeight = UITableViewAutomaticDimension;
    _listTableView.tableFooterView = [UIView new];
    [self addSubview:_listTableView];
    
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YSCustemCollectionViewCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YSCustemCollectionViewCellID];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!_navigationCon) {
        NSLog(@"--------- navigationController is nil !");
        return;
    }
    
    YSCustemCollectionVC * custemCollectionVC = [[YSCustemCollectionVC alloc] initWithType:indexPath.row title:_dataArr[indexPath.row]];
    custemCollectionVC.hidesBottomBarWhenPushed = YES;
    [_navigationCon pushViewController:custemCollectionVC animated:YES];
}

@end
