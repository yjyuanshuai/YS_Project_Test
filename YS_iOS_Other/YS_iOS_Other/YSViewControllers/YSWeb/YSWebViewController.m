//
//  YSWebViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSWebViewController.h"

static NSString * const WebCellID = @"WebCellID";

@interface YSWebViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * webTableView;

@end

@implementation YSWebViewController
{
    NSArray * _sectionTitleArr;
    NSMutableArray * _sectionCellContent;
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
    self.title = @"网络";
    
    _sectionTitleArr = @[@"基本知识", @"原生", @"第三方库", @"基于第三方的封装"];
    
    NSArray * knowledge = @[@"TCP/IP", @"UDP", @"Socket", @"HTTP"];
    NSArray * orignWorking = @[@"原生网络"];
    NSArray * afnetworking = @[@"AFNetworing 3.0"];
    NSArray * myWorking = @[@"自己封装的方法"];
    
    _sectionCellContent = [@[knowledge, orignWorking, afnetworking, myWorking] mutableCopy];
}

- (void)createTableView
{
    _webTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _webTableView.delegate = self;
    _webTableView.dataSource = self;
    [self.view addSubview:_webTableView];
    [_webTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_webTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WebCellID];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitleArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sectionCellContent[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:WebCellID];
    cell.textLabel.text = _sectionCellContent[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitleArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger indexSection = indexPath.section;
    switch (indexSection) {
        case 0:
        {
            if (indexPath.row == 0)
            {
                
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0)
            {
                
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0)
            {
                
            }
            else if (indexPath.row == 1)
            {
                
            }
        }
            break;
            
        default:
            break;
    }
}


@end
