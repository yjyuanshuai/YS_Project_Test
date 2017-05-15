//
//  VideoListVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/4/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "VideoListVC.h"
#import "VideoViewController.h"

static NSString * VideoListCellID = @"VideoListCellID";

@interface VideoListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * videoTableView;

@end

@implementation VideoListVC
{
    NSMutableArray * _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"视频列表";
    _dataArr = [@[] mutableCopy];
    
    NSArray * landScape = @[@"横屏显示"];
    [_dataArr addObject:landScape];
    
    _videoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _videoTableView.delegate = self;
    _videoTableView.dataSource = self;
    _videoTableView.tableFooterView = [UIView new];
    [self.view addSubview:_videoTableView];
    
    [_videoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_videoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:VideoListCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * sectionArr = _dataArr[section];
    return [sectionArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:VideoListCellID];
    if (indexPath.section < [_dataArr count]) {
        NSArray * sectionArr = _dataArr[indexPath.section];
        if (indexPath.row < [sectionArr count]) {
            cell.textLabel.text = sectionArr[indexPath.row];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            VideoViewController * landScapeVC = [[VideoViewController alloc] init];
            [self.navigationController pushViewController:landScapeVC animated:YES];
        }
    }
}

@end
