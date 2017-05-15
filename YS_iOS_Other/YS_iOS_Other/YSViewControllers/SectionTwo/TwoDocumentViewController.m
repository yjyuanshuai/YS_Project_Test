//
//  TwoDocumentViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "TwoDocumentViewController.h"
#import "docModel.h"
#import "TwoDocumentTableViewCell.h"

static NSString * twoDocumentTableViewCell_id = @"TwoDocumentTableViewCell";

@interface TwoDocumentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * docTableView;
@property (nonatomic, strong) UIImageView * tableViewHeadView;

@end

@implementation TwoDocumentViewController
{
    NSMutableArray * _sectionArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableViewHeader];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"沙盒";
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"homeDirectiory" ofType:@"plist"];
    NSArray * arr = [NSArray arrayWithContentsOfFile:plistPath];
    for (int i = 0; i < [arr count]; i++) {
        NSDictionary * dic = [arr objectAtIndex:i];
        docModel * model = [[docModel alloc] initWithDic:dic];
        
        if (_sectionArr == nil) {
            _sectionArr = [NSMutableArray array];
        }
        
        [_sectionArr addObject:model];
    }
}

- (void)createTableView
{
    _docTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_docTableView];
    
    _docTableView.sectionHeaderHeight = 40;
    _docTableView.sectionFooterHeight = 0.01;
    
    [_docTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeightNo64));
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _docTableView.delegate = self;
    _docTableView.dataSource = self;
    _docTableView.tableHeaderView = _tableViewHeadView;
}

- (void)createTableViewHeader
{
    _tableViewHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _tableViewHeadView.image = [UIImage imageNamed:@"docImage"];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    docModel * model = [_sectionArr objectAtIndex:section];
    return [model.sectionDetailArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**/
    TwoDocumentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:twoDocumentTableViewCell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TwoDocumentTableViewCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    docModel * model = [_sectionArr objectAtIndex:indexPath.section];
    sectionDetailModel * sectionModel = [model.sectionDetailArr objectAtIndex:indexPath.row];
    [cell setCellContent:sectionModel];
    
    return cell;
     
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**/
    docModel * model = [_sectionArr objectAtIndex:indexPath.section];
    sectionDetailModel * sectionModel = [model.sectionDetailArr objectAtIndex:indexPath.row];
    return [TwoDocumentTableViewCell getDocumentCellHeight:sectionModel.detail];
     
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    docModel * model = [_sectionArr objectAtIndex:section];
    return model.sectionTitle;
}

@end
