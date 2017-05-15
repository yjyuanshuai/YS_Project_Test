//
//  YSOtherGatherVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/18.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSOtherGatherVC.h"
#import "YSNavController.h"

#import "YSOtherViewController.h"
#import "YSHarewareViewController.h"
#import "YSAnimationsViewController.h"


@interface YSOtherGatherVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * otherGatherTableView;

@end

@implementation YSOtherGatherVC
{
    NSMutableArray * _sectionTitleArr;
    NSMutableArray * _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self createFootView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"其他";
    self.tabBarItem.title = @"其他集合";
    
    NSArray * one = @[@"其他"];
    NSArray * two = @[@"硬件&系统"];
    NSArray * third = @[@"各种动画"];
    
    _sectionTitleArr = [@[@"其他", @"硬件&系统", @"各种动画"] mutableCopy];
    _dataArr = [@[one, two, third] mutableCopy];
}

- (void)createTableView
{
    _otherGatherTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _otherGatherTableView.delegate = self;
    _otherGatherTableView.dataSource = self;
    _otherGatherTableView.tableFooterView = [UIView new];
    [self.view addSubview:_otherGatherTableView];
    
    [_otherGatherTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    if ([_otherGatherTableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [_otherGatherTableView setLayoutMargins:UIEdgeInsetsZero];
//    }
//    if ([_otherGatherTableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [_otherGatherTableView setSeparatorInset:UIEdgeInsetsZero];
//    }
}

- (void)createFootView
{
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    [footView addSubview:contentView];
    
    UIButton * logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [logOutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    logOutBtn.layer.borderColor = [UIColor redColor].CGColor;
    logOutBtn.layer.borderWidth = 1;
    [logOutBtn addTarget:self action:@selector(clickLogOut) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:logOutBtn];
    
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView).insets(UIEdgeInsetsMake(60, 15, 20, 15));
    }];
    
    _otherGatherTableView.tableFooterView = footView;
}

- (void)clickLogOut
{
    [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:HasLogin];
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:HasKickOut];
    
    YSNavController * navCon = [YSNavController sharedYSTabBarController];
    [navCon saveAccountOrPassWord];
    [UIApplication sharedApplication].keyWindow.rootViewController = navCon;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"CELL_ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            YSOtherViewController * otherVC = [[YSOtherViewController alloc] init];
            otherVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:otherVC animated:YES];
        }
            break;
        case 1:
        {
            YSHarewareViewController * hareAndSystemVC = [[YSHarewareViewController alloc] init];
            hareAndSystemVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hareAndSystemVC animated:YES];
        }
            break;
        case 2:
        {
            YSAnimationsViewController * animationVC = [[YSAnimationsViewController alloc] init];
            animationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:animationVC animated:YES];
        }
            break;
    }
}

@end
