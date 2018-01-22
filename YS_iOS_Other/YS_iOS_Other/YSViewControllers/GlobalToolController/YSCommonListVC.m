//
//  YSCommonListVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCommonListVC.h"
#import "NSString+YSStringDo.h"

static NSString * const YSCommonListVCCellID = @"YSCommonListVCCellID";

@interface YSCommonListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView * custemView;
@property (nonatomic, strong) UITableView * listTableView;

@end

@implementation YSCommonListVC
{
    YSListType _type;
}

- (instancetype)initWithType:(YSListType)type title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        self.custemView = nil;
        _type = type;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title view:(UIView *)view
{
    self = [super init];
    if (self) {
        self.title = title;
        self.custemView = view;
        _type = YSListTypeDefault;
    }
    return self;
}

//- (void)loadView
//{
//    if (self.custemView) {
//        self.view = self.custemView;
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
//}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(_type != YSListTypeDefault){
        [self initUIAndData];
        [self createTableView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    if (!_sectionTitleArr) {
        _sectionTitleArr = [NSMutableArray array];
    }
    if (!_contentArr) {
        _contentArr = [NSMutableArray array];
    }
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
    
    [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YSCommonListVCCellID];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YSCommonListVCCellID];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = YSFont_Sys(14);
    NSArray * sectionContent = [_contentArr objectAtIndex:indexPath.section];
    cell.textLabel.text = sectionContent[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString * sectionTitle = _sectionTitleArr[section];
    if(![sectionTitle isBlank]){
        return 50;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString * sectionTitle = _sectionTitleArr[section];
    if(![sectionTitle isBlank]){
        UIView * sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        sectionHeaderView.backgroundColor = YSColorDefault;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.font = YSFont_Sys(14);
        label.textAlignment = NSTextAlignmentLeft;
        label.text = sectionTitle;
        [sectionHeaderView addSubview:label];
        
        return sectionHeaderView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
