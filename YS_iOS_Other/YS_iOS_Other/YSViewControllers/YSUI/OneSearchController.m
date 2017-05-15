//
//  OneSearchController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneSearchController.h"

#import "NavigationSearchController.h"
#import "TableHeadSearchController.h"
#import "ViewSearchController.h"

@interface OneSearchController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation OneSearchController
{
    NSMutableArray * _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initUIAndData];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"有关搜索";
    
    NSArray * one = @[@"Navigation上的搜索-结果另起页", @"Navigation上的搜索-结果本页"];
    NSArray * two = @[@"TableViewHead上的搜索-结果另起页", @"TableViewHead上的搜索-结果本页"];
    NSArray * third = @[@"View上的搜索-结果另起页", @"View上的搜索-结果本页"];
    _dataArr = [@[one, two, third] mutableCopy];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                NavigationSearchController * navVC = [[NavigationSearchController alloc] initHasNewResultVC:YES];
                [self.navigationController pushViewController:navVC animated:YES];
            }
            else if (indexPath.row == 1) {
                NavigationSearchController * navVC = [[NavigationSearchController alloc] initHasNewResultVC:NO];
                [self.navigationController pushViewController:navVC animated:YES];
            }
            
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                TableHeadSearchController * tableVC = [[TableHeadSearchController alloc] initHasNewResultVC:YES];
                [self.navigationController pushViewController:tableVC animated:YES];
            }
            else if (indexPath.row == 1) {
                TableHeadSearchController * tableVC = [[TableHeadSearchController alloc] initHasNewResultVC:NO];
                [self.navigationController pushViewController:tableVC animated:YES];
            }
            
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                ViewSearchController * viewVC = [[ViewSearchController alloc] initHasNewResultVC:YES];
                [self.navigationController pushViewController:viewVC animated:YES];
            }
            else if (indexPath.row == 1) {
                ViewSearchController * viewVC = [[ViewSearchController alloc] initHasNewResultVC:NO];
                [self.navigationController pushViewController:viewVC animated:YES];
            }
            
        }
            break;
    }
}

@end
