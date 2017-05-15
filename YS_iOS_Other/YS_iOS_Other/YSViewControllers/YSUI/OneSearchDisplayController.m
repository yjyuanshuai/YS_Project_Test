//
//  OneSearchDisplayController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneSearchDisplayController.h"
#import "YSSearchBar.h"

@interface OneSearchDisplayController ()<UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * currentTableView;

@property (nonatomic, strong) UIView * custemView;

@property (nonatomic, strong) UISearchBar * ysSearchBar;
@property (nonatomic, strong) UISearchDisplayController * ysSearchDisplayVC;

@property (nonatomic, strong) YSSearchBar * ysNoNavSearchBar;
@property (nonatomic, strong) UISearchDisplayController * ysNoNavSearchDisplayVC;

@end

@implementation OneSearchDisplayController
{
    UITapGestureRecognizer * _tapGesure;
    
    NSArray * _historyArr;
    
    UIBarButtonItem * _rightBarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self createSearchBarInNav];
    [self createSearchInTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [_ysSearchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"右键" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarBtn)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;

    [self ysCustemView];
    
    // 通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyBoardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyBoardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _historyArr = @[@"搜索历史 1", @"搜索历史 2", @"搜索历史 3"];
}

- (void)createTableView
{
    _currentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _currentTableView.delegate = self;
    _currentTableView.dataSource = self;
    [self.view addSubview:_currentTableView];
    
    [_currentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, -64, 0));
    }];
    
    // 将 tableview 无数据横线去掉
    _currentTableView.tableFooterView = [[UIView alloc] init];
}

- (void)createSearchBarInNav
{
    _ysSearchBar = [[UISearchBar alloc] init];
    _ysSearchBar.delegate = self;
    _ysSearchBar.showsCancelButton = NO;
    _ysSearchBar.placeholder = @"导航栏搜索";
    _ysSearchBar.barTintColor = [UIColor lightGrayColor];
    [_ysSearchBar sizeToFit];
    self.navigationItem.titleView = _ysSearchBar;
    
    _ysSearchDisplayVC = [[UISearchDisplayController alloc] initWithSearchBar:_ysSearchBar contentsController:self];
    _ysSearchDisplayVC.delegate = self;
    _ysSearchDisplayVC.searchResultsDataSource = self;
    _ysSearchDisplayVC.searchResultsDelegate = self;
    _ysSearchDisplayVC.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _ysSearchDisplayVC.displaysSearchBarInNavigationBar = YES;
    
    _rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"右键" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarBtn)];
    _ysSearchDisplayVC.navigationItem.rightBarButtonItem = _rightBarBtn;
}

- (void)createSearchInTableView
{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    bgView.backgroundColor = [UIColor redColor];
    
    _ysNoNavSearchBar = [[YSSearchBar alloc] init];
    _ysNoNavSearchBar.frame = CGRectMake(0, 0, kScreenWidth, 80);
    _ysNoNavSearchBar.delegate = self;
    _ysNoNavSearchBar.showsCancelButton = NO;
    _ysNoNavSearchBar.placeholder = @"一般搜索";
    _ysNoNavSearchBar.barTintColor = [UIColor lightGrayColor];
    _ysNoNavSearchBar.textFeildContentInset = UIEdgeInsetsMake(10, 15, 10, 15);
    [bgView addSubview:_ysNoNavSearchBar];
    [_ysNoNavSearchBar sizeToFit];
    
    _ysNoNavSearchDisplayVC = [[UISearchDisplayController alloc] initWithSearchBar:_ysNoNavSearchBar contentsController:self];
    _ysNoNavSearchDisplayVC.delegate = self;
    _ysNoNavSearchDisplayVC.searchResultsDataSource = self;
    _ysNoNavSearchDisplayVC.searchResultsDataSource = self;
    _ysNoNavSearchDisplayVC.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _currentTableView.tableHeaderView = bgView;
}

- (void)clickRightBarBtn
{

}

#pragma mark - 
- (void)KeyBoardWillShow
{
    if (_ysSearchBar.isFirstResponder) {
        
        // 导航栏
        if ([self respondsToSelector:@selector(searchDisplayControllerWillBeginSearch:)]) {
            [self searchDisplayControllerWillBeginSearch:_ysSearchDisplayVC];
        }
        
        
    } else if (_ysNoNavSearchBar.isFirstResponder) {
    
        // 非导航栏
        if ([self respondsToSelector:@selector(searchDisplayControllerWillBeginSearch:)]) {
            [self searchDisplayControllerWillBeginSearch:_ysNoNavSearchDisplayVC];
        }
        
    }
}

- (void)KeyBoardWillHide
{

}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _currentTableView) {
        NSString * cell_id = @"cell_id";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        }
        cell.textLabel.text = @"测试测试测试测试";
        return cell;
    } else {
        NSString * cell_id = @"cell_history_id";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        }
        cell.textLabel.text = @"搜索中";
        return cell;

    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _custemView.hidden = NO;
    searchBar.showsCancelButton = YES;
//    _ysSearchDisplayVC.navigationItem.rightBarButtonItem = nil;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        _custemView.hidden = NO;
    } else {
        _custemView.hidden = YES;
    }
}

#pragma mark -
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    
    [self resetSearchDisplayView:controller];
    
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
//    _ysSearchDisplayVC.navigationItem.rightBarButtonItem = _rightBarBtn;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    [tableView setContentInset:UIEdgeInsetsZero];
    [tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    
}

#pragma mark -
- (void)resetSearchDisplayView:(id)searchDisplayController
{
    if ([searchDisplayController isKindOfClass:[UISearchDisplayController class]]) {
        
        UISearchDisplayController * ysSearchDisplayView = (UISearchDisplayController *)searchDisplayController;
        
        UIView * supSupView = ysSearchDisplayView.searchResultsTableView.superview.superview;
        
        for (UIView * subView in supSupView.subviews) {
            for (UIView * subsubView in subView.subviews) {
                if ([subsubView isKindOfClass:NSClassFromString(@"_UISearchDisplayControllerDimmingView")]) {
                    
                    subsubView.superview.hidden = YES;
                    subsubView.hidden = YES;
                    
                }
            }
        }
        
        UIView * disViewSuperView = ysSearchDisplayView.searchResultsTableView.superview;
//        disViewSuperView.backgroundColor = [UIColor orangeColor];
        if (![_custemView isDescendantOfView:disViewSuperView]) {
            [disViewSuperView addSubview:_custemView];
        }
        
    }
}

- (void)ysCustemView
{
    _tapGesure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyWindow:)];
    
    _custemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _custemView.backgroundColor = [UIColor yellowColor];
    [_custemView addGestureRecognizer:_tapGesure];

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1.0;
    [btn setBackgroundImage:[UIImage imageNamed:@"btn1"] forState:UIControlStateNormal];
    [_custemView addSubview:btn];
     
    /*
    UILabel * historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 6, kScreenWidth - 20 - 30, 20)];
    historyLabel.textColor = [UIColor blackColor];
    historyLabel.font = [UIFont systemFontOfSize:16.0];
    historyLabel.text = @"搜索历史";
    [_custemView addSubview:historyLabel];
    
    UIButton * deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deletBtn.frame = CGRectMake(kScreenWidth - 10 - 20, 70, 20, 20);
    [deletBtn setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateNormal];
    [deletBtn addTarget:self action:@selector(deleteHistory) forControlEvents:UIControlEventTouchUpInside];
    [_custemView addSubview:deletBtn];
     */
}

- (void)deleteHistory
{
    
}

- (void)clickBtn
{
    NSLog(@"================ ");
}

- (void)hideKeyWindow:(UITapGestureRecognizer *)tapGesure
{
    if ([_ysSearchBar isFirstResponder]) {
        [_ysSearchBar resignFirstResponder];
        _ysSearchBar.showsCancelButton = YES;
    } else if ([_ysNoNavSearchBar isFirstResponder]) {
        [_ysNoNavSearchBar resignFirstResponder];
        _ysNoNavSearchBar.showsCancelButton = YES;
    }
}

@end
