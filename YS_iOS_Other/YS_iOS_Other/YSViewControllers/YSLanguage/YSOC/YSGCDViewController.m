//
//  YSGCDViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/26.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSGCDViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "YSGCDTableViewCell.h"
#import "GlobalWebVC.h"

@interface YSGCDViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * gcdTableView;

@end

@implementation YSGCDViewController
{
    NSArray * _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"GCD";
    _titleArr = @[@"Objc中国-并发编程：API及挑战"];
    
    _gcdTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _gcdTableView.delegate = self;
    _gcdTableView.dataSource = self;
    [self.view addSubview:_gcdTableView];
    
    [self addConstraintsInTableView];
}

- (void)addConstraintsInTableView
{
    _gcdTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary * metricsDic = @{};
    NSDictionary * viewsDic = @{@"_gcdTableView":_gcdTableView};
    
    NSString * h_vfl1 = @"H:|-0-[_gcdTableView]-0-|";
    NSString * v_vfl1 = @"V:|-0-[_gcdTableView]-0-|";
    
    NSArray * h_c1 = [NSLayoutConstraint constraintsWithVisualFormat:h_vfl1
                                                             options:0
                                                             metrics:metricsDic
                                                               views:viewsDic];
    NSArray * v_c1 = [NSLayoutConstraint constraintsWithVisualFormat:v_vfl1
                                                             options:0
                                                             metrics:metricsDic
                                                               views:viewsDic];
    [self.view addConstraints:h_c1];
    [self.view addConstraints:v_c1];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"Cell_Id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.05;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        GlobalWebVC * webVC = [[GlobalWebVC alloc] initWithTitle:_titleArr[indexPath.row] webUrl:@"https://objccn.io/issue-2-1/"];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

@end
