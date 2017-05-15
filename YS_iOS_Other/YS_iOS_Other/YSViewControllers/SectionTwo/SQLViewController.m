//
//  SQLViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SQLViewController.h"
#import "SQLDetailViewController.h"

static NSString * const sqlCellId = @"sqlCellId";

@interface SQLViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * sqlTableView;

@end

@implementation SQLViewController
{
    NSArray * _sectionTitleArr;
    NSArray * _sectionContentArr;
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
    self.title = @"sql语句";
    
    _sectionTitleArr = @[@"DDL 定义", @"DML 操作", @"DQL 查询", @"约束", @"连表查询", @"第三方库"];
    
    NSArray * DDLArr = @[@"字段类型", @"create", @"drop"];
    NSArray * DMLArr = @[@"insert", @"update", @"delete"];
    NSArray * DQLArr = @[@"select", @"where", @"order by", @"group by", @"having", @"limit", @"别名", @"count"];
    NSArray * LimitArr = @[@"简单约束", @"主键约束", @"外键约束"];
    NSArray * LinkArr = @[@"内连接", @"左外连接"];
    NSArray * FMDB = @[@"FMDB"];
    
    _sectionContentArr = @[DDLArr, DMLArr, DQLArr, LimitArr, LinkArr, FMDB];
}

- (void)createTableView
{
    _sqlTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _sqlTableView.delegate = self;
    _sqlTableView.dataSource = self;
    [self.view addSubview:_sqlTableView];
    
    [_sqlTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sqlCellId];
    
    [self addContraintsToTableView];
}

- (void)addContraintsToTableView
{
    _sqlTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary * metricsDic = @{};
    NSDictionary * viewsDic = @{@"_sqlTableView" : _sqlTableView};
    
    NSString * vfl1 = @"H:|-0-[_sqlTableView]-0-|";
    NSString * vfl2 = @"V:|-0-[_sqlTableView]-0-|";
    
    NSArray * c1 = [NSLayoutConstraint constraintsWithVisualFormat:vfl1
                                                           options:0
                                                           metrics:metricsDic
                                                             views:viewsDic];
    NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:vfl2
                                                           options:0
                                                           metrics:metricsDic
                                                             views:viewsDic];
    [self.view addConstraints:c1];
    [self.view addConstraints:c2];
}

#pragma mark - UItableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitleArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sectionContentArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sqlCellId];
    cell.textLabel.text = _sectionContentArr[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString * title = [NSString stringWithFormat:@"%@-%@", _sectionTitleArr[indexPath.section], _sectionContentArr[indexPath.section][indexPath.row]];
    SQLDetailViewController * sqlDetailVC = [[SQLDetailViewController alloc] initWithIndex:indexPath titleStr:title];
    [self.navigationController pushViewController:sqlDetailVC animated:YES];
}

@end
