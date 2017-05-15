//
//  YSCoreTextViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCoreTextViewController.h"

#import "ShowImageWordSortViewController.h"

#import "FirstSimpleView.h"
#import "AttributeBaseView.h"

static NSString * const CoreTextCellID = @"CoreTextCellID";

@interface YSCoreTextViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * coreTextTableView;

@end

@implementation YSCoreTextViewController
{
    NSMutableArray * _coretextArr;
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
    self.title = @"CoreText";
    
    _coretextArr = [@[@"简单实现", @"各种基本样式设置", @"", @"自动识别链接及跳转", @"插入图片"] mutableCopy];
}

- (void)createTableView
{
    _coreTextTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _coreTextTableView.delegate = self;
    _coreTextTableView.dataSource = self;
    [self.view addSubview:_coreTextTableView];
    
    [_coreTextTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_coreTextTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CoreTextCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_coretextArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CoreTextCellID];
    cell.textLabel.text = _coretextArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        // 简单文字
        
        ShowImageWordSortViewController * simpleVC = [[ShowImageWordSortViewController alloc] initWithView:[FirstSimpleView class] title:@"简单实现"];
        simpleVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:simpleVC animated:YES];
        
    }
    else if (indexPath.row == 1) {
        
        // 富文本
        ShowImageWordSortViewController * attributeStrVC = [[ShowImageWordSortViewController alloc] initWithView:[AttributeBaseView class] title:@"各种基本样式设置"];
        attributeStrVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:attributeStrVC animated:YES];
    
    }
    else if (indexPath.row == 2) {
    
    }
    else if (indexPath.row == 3) {
    
    }
}

@end
