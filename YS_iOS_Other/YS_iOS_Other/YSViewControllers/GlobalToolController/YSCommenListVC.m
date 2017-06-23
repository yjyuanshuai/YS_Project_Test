//
//  YSCommenListVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCommenListVC.h"

@interface YSCommenListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * listTableView;

@end

@implementation YSCommenListVC
{
    YSListType _type;
}

- (instancetype)initWithType:(YSListType)type title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        _type = type;
    }
    return self;
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
    _sectionTitleArr = [NSMutableArray array];
    _contentArr = [NSMutableArray array];
}

- (void)createTableView
{
    _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    _listTableView.tableFooterView = [UIView new];
    _listTableView.rowHeight = 80;
    _listTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_listTableView];

    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitleArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionContent = [_contentArr objectAtIndex:section];
    if (sectionContent && [sectionContent count]) {
        return [sectionContent count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == YSListTypeCalendarEvent) {

    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_type == YSListTypeCalendarEvent) {
        return 0.01;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_type == YSListTypeCalendarEvent) {
        return 0.01;
    }
    return 0.01;
}

@end
