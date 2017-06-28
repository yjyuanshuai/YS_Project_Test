//
//  CustemSearchViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CustemSearchViewController.h"
#import "YSCustemSearchController.h"
#import "SearchResultViewController.h"

@interface CustemSearchViewController ()<YSCustemSearchControllerDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YSCustemSearchController * custemSearchController;
@property (nonatomic, strong) UITableView * currentTableView;
@property (nonatomic, strong) UITableView * historyTableView;

@end

@implementation CustemSearchViewController
{
    NSMutableArray * _dataArr;
    NSMutableArray * _historyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createSearchView];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"右键" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _dataArr = [@[@"111", @"222", @"333", @"342", @"444", @"431", @"555", @"666", @"777", @"888", @"999"] mutableCopy];
    _historyArr = [@[] mutableCopy];
}

- (void)createTableView
{
    _currentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _currentTableView.delegate = self;
    _currentTableView.dataSource = self;
    [self.view addSubview:_currentTableView];
    
    [_currentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _currentTableView.tableHeaderView = (UIView *)_custemSearchController.ysSearchBar;
    
    _historyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _historyTableView.delegate = self;
    _historyTableView.dataSource = self;
    _historyTableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_historyTableView];
    
    [_historyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    _historyTableView.hidden = YES;
}

- (void)createSearchView
{
    SearchResultViewController * resultVC = [[SearchResultViewController alloc] init];
    resultVC.view.backgroundColor = [UIColor orangeColor];
    
    _custemSearchController = [[YSCustemSearchController alloc] initWithSearchResultsController:resultVC searchBarFrame:CGRectMake(0, 0, kScreenWidth, 60) textFont:[UIFont systemFontOfSize:16.0] textColor:[UIColor greenColor]];
    _custemSearchController.searchResultsUpdater = self;
    _custemSearchController.delegate = self;
    _custemSearchController.searchBarDelegate = self;
}

- (void)clickRightBtn
{
    NSLog(@"---------------------");
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _currentTableView) {
        return [_dataArr count];
    }
    else if (tableView == _historyTableView) {
        return [_historyArr count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _currentTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        }
        cell.textLabel.text = _dataArr[indexPath.row];
        return cell;
    }
    else if (tableView == _historyTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCellID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCellID"];
        }
        if (indexPath.row < [_historyArr count]) {
            cell.textLabel.text = _historyArr[indexPath.row];
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _historyTableView && indexPath.row < [_historyArr count]) {
        if (_custemSearchController.active) {
            _custemSearchController.searchBar.text = _historyArr[indexPath.row];
            
        }
        _historyTableView.hidden = YES;
    }
}

#pragma mark - YSCustemSearchControllerDelegate
- (void)searchBegin:(UISearchBar *)searchBar
{
    _historyTableView.hidden = NO;
    _currentTableView.hidden = YES;
}

- (void)searchEnd:(UISearchBar *)searchBar
{
    _historyTableView.hidden = YES;
    _currentTableView.hidden = NO;
}

- (void)searchButtonClicked:(UISearchBar *)searchBar
{
    if (![searchBar.text isEqualToString:@""]) {
        [_historyArr addObject:searchBar.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_historyTableView reloadData];
        });
    }
}

- (void)cancleButtonClicked:(UISearchBar *)searchBar
{
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // UISearchController的searchBar中的内容一旦发生变化, 就会调用该方法.
    
    NSString * searchBarStr = searchController.searchBar.text;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", searchBarStr];
    
    SearchResultViewController * searchResultVC = (SearchResultViewController *)searchController.searchResultsController;
    searchResultVC.resultArr = [[_dataArr filteredArrayUsingPredicate:predicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
//        [searchResultVC.resultTableView reloadData];
        [searchResultVC.tableView reloadData];
    });
}

#pragma mark - UISearchControllerDelegate

@end
