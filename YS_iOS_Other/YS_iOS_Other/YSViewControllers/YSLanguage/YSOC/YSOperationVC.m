//
//  YSOperationVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/3/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSOperationVC.h"
#import "YSActivityIndicator.h"
#import "YSOperationDetailUserVC.h"

@interface YSOperationVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * operationTableView;

@end

@implementation YSOperationVC
{
    NSArray * _titleArr;
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
    self.title = @"NSOperation";
    
    _titleArr = @[@"Invocation", @"Block", @"自定义"];

    [self addActivity];
}

- (void)createTableView
{
    _operationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _operationTableView.tableFooterView = [UIView new];
    _operationTableView.delegate = self;
    _operationTableView.dataSource = self;
    _operationTableView.estimatedRowHeight = 44;
    _operationTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_operationTableView];
    
    [_operationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)addActivity
{
    UIView * cusView = [UIView new];
    cusView.backgroundColor = [UIColor redColor];

    YSActivityIndicator * acti = [YSActivityIndicator showInViewController:self];
    acti.ysType = YSLoadViewTypeCustom;
    acti.ysCustomView = cusView;
    acti.overTimeInterval = 10;



    UIButton * rightTest = [UIButton buttonWithType:UIButtonTypeSystem];
    rightTest.frame = CGRectMake(0, 0, 100, 30);
    [rightTest setTitle:@"哈哈疯狂拉升的规划gas刚卡死点火开关" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightTest];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cell_id = @"cell_id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YSOperationDetailUserVC * operationVC = [[YSOperationDetailUserVC alloc] initWithType:indexPath.row title:_titleArr[indexPath.row]];
    operationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:operationVC animated:YES];
}

@end
