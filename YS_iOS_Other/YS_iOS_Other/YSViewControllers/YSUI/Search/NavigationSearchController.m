//
//  NavigationSearchController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "NavigationSearchController.h"
#import "SearchResultViewController.h"
#import "NSString+YSStringDo.h"

#import "ApplicationSettingViewController.h"

NSString * SearchHistoryKey = @"SearchHistoryKey";
NSInteger SearchSizeLimit = 5;

@interface NavigationSearchController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic, strong) UISearchController * ysSearchCon;
@property (nonatomic, strong) SearchResultViewController * searchResultVC;
@property (nonatomic, strong) UITableView * searchRetTableView;

@property (nonatomic, strong) UITableView * currentTableView;
@property (nonatomic, strong) UITableView * historyTableView;

@end

@implementation NavigationSearchController
{
    NSMutableArray * _dataArr;
    NSMutableArray * _historyArr;
    BOOL _hasNewResult;
    NSMutableArray * _searchResultArr;
}

- (instancetype)initHasNewResultVC:(BOOL)newResult
{
    if (self = [super init]) {
        _hasNewResult = newResult;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self initUIAndData];
    [self createTableView];
    [self createNavigationSearchView];
    [self obtainHistoryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    _dataArr = [@[@"111", @"222", @"333", @"342", @"444", @"431", @"555", @"666", @"777", @"888", @"999"] mutableCopy];
    _historyArr = [@[] mutableCopy];
    _searchResultVC = [@[] mutableCopy];
    
    if (_hasNewResult) {
        _searchResultVC = [[SearchResultViewController alloc] init];
        _searchResultVC.tableView.delegate = self;
    }
    else {
        _searchRetTableView = [UITableView new];
        _searchRetTableView.delegate = self;
        _searchRetTableView.dataSource = self;
        [self.view addSubview:_searchRetTableView];
        [_searchRetTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
        }];
        
        _searchRetTableView.hidden = YES;
    }
}

- (void)obtainHistoryData
{
    _historyArr = [[NSUserDefaults standardUserDefaults] objectForKey:SearchHistoryKey];
    [_historyTableView reloadData];
}

- (void)AddHistoryDataWithStr:(NSString *)str
{
    if (![str isBlank]) {
        
        NSArray * historyTemp = [[NSUserDefaults standardUserDefaults] objectForKey:SearchHistoryKey];
        NSMutableArray * history = [historyTemp mutableCopy];
        
        if ([history count] > 0) {
            for (int i = 0; i < [history count]; i++) {
                NSString * subStr = history[i];
                if ([str isEqualToString:subStr]) {
                    [history removeObject:str];
                    i--;
                }
            }
            
            [history insertObject:str atIndex:0];
            
            if ([history count] > SearchSizeLimit) {
                for (int i = (int)SearchSizeLimit; i < [history count]; i++) {
                    [history removeObjectAtIndex:i];
                    i--;
                }
            }
            
            _historyArr = history;
        }
        else {
            _historyArr = [@[str] mutableCopy];
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:_historyArr] forKey:SearchHistoryKey];
    }
}


- (void)createTableView
{
    _currentTableView = [UITableView new];
    _currentTableView.delegate = self;
    _currentTableView.dataSource = self;
    [self.view addSubview:_currentTableView];
    
    [_currentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    _historyTableView = [UITableView new];
    _historyTableView.delegate = self;
    _historyTableView.dataSource = self;
    [self.view addSubview:_historyTableView];
    
    [_historyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    _historyTableView.hidden = YES;
    
    _currentTableView.backgroundColor = [UIColor redColor];
    _historyTableView.backgroundColor = [UIColor greenColor];
}

- (void)createNavigationSearchView
{
    if (_hasNewResult == YES) {
        
        _ysSearchCon = [[UISearchController alloc] initWithSearchResultsController:_searchResultVC];
        
    }
    else {
        
        _ysSearchCon = [[UISearchController alloc] initWithSearchResultsController:nil];
        
    }
    
    _ysSearchCon.searchResultsUpdater = self;
    _ysSearchCon.delegate = self;
    _ysSearchCon.dimsBackgroundDuringPresentation = NO;
    _ysSearchCon.hidesNavigationBarDuringPresentation = NO;
    _ysSearchCon.searchBar.delegate = self;

    self.definesPresentationContext = YES;
    
    self.navigationItem.titleView = _ysSearchCon.searchBar;
    [_ysSearchCon.searchBar sizeToFit];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _historyTableView) {
        return [_historyArr count];
    }
    else if (tableView == _searchRetTableView) {
        return [_searchResultArr count];
    }
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _historyTableView) {
        
        static NSString * cellID = @"HistoryTableViewCellID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = _historyArr[indexPath.row];
        return cell;
        
    }
    else if (tableView == _currentTableView) {
        
        static NSString * cellID = @"CurrentTableViewCellID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = _dataArr[indexPath.row];
        return cell;
        
    }
    else if (tableView == _searchRetTableView) {
        
        static NSString * cellID = @"SearchResultTableViewCellID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = _searchResultArr[indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _historyTableView) {
        
        _ysSearchCon.searchBar.text = _historyArr[indexPath.row];
    }
    else if (tableView == _currentTableView) {
        
    }
    else if (tableView == _searchRetTableView) {
        
        ApplicationSettingViewController * appVC = [[ApplicationSettingViewController alloc] init];
        [self.navigationController pushViewController:appVC animated:YES];
    }
    else if (tableView == _searchResultVC.tableView) {
        
        // 跳转
        ApplicationSettingViewController * appVC = [[ApplicationSettingViewController alloc] init];
        [self.navigationController pushViewController:appVC animated:YES];
    }
}


#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _historyTableView.hidden = NO;
    _currentTableView.hidden = YES;
    
    if (!_hasNewResult) {
        _searchRetTableView.hidden = YES;
    }
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _historyTableView.hidden = YES;
    _currentTableView.hidden = NO;
    
    if (!_hasNewResult) {
        _searchRetTableView.hidden = YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![searchBar.text isBlank]) {
        
        [self AddHistoryDataWithStr:searchBar.text];
        [_historyTableView reloadData];
        
        if (!_hasNewResult) {
            
            [_searchRetTableView reloadData];
            _searchRetTableView.hidden = NO;
            _historyTableView.hidden = YES;
            _currentTableView.hidden = YES;
        }
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString * searchBarStr = searchController.searchBar.text;
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", searchBarStr];
    
    _searchResultArr = [[_dataArr filteredArrayUsingPredicate:predicate] mutableCopy];
    
    if (_hasNewResult) {
        _searchResultVC.resultArr = _searchResultArr;
        [_searchResultVC.tableView reloadData];
    }
}

#pragma mark - UISearchControllerDelegate


@end
