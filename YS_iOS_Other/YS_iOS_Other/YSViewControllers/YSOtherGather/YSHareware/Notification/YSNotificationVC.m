//
//  YSNotificationVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/9/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSNotificationVC.h"
#import "YSLocalNotificationVC.h"

@interface YSNotificationVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * notificationTableView;

@end

@implementation YSNotificationVC
{
    NSMutableArray * _notificationArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"通知";
    _notificationArr = [NSMutableArray arrayWithArray:@[@"本地通知", @"远程通知"]];

    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView
{
    _notificationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _notificationTableView.delegate = self;
    _notificationTableView.dataSource = self;
    _notificationTableView.sectionHeaderHeight = 0;
    _notificationTableView.sectionFooterHeight = 0;
    [self.view addSubview:_notificationTableView];

    [_notificationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_notificationArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"cell_id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = _notificationArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            // 本地通知
            YSLocalNotificationVC * localNotifiVC = [[YSLocalNotificationVC alloc] init];
            localNotifiVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:localNotifiVC animated:YES];
        }
            break;

        default:
            break;
    }
}

@end
