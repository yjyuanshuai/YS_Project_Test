//
//  RightMenuViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "RightMenuViewController.h"
#import "AudioViewController.h"
#import "VideoListVC.h"
#import <RESideMenu.h>

@interface RightMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * rightMenuTableView;

@end

@implementation RightMenuViewController
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
    self.view.backgroundColor = [UIColor clearColor];
    
    _titleArr = @[@"音频", @"视频"];
}

- (void)createTableView
{
    _rightMenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.width - 54*2)/2.0f, self.view.frame.size.width, 54*2) style:UITableViewStylePlain];
    _rightMenuTableView.delegate = self;
    _rightMenuTableView.dataSource = self;
    _rightMenuTableView.backgroundColor = [UIColor clearColor];
    _rightMenuTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_rightMenuTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        AudioViewController * audioVC = [[AudioViewController alloc] init];
        [self.sideMenuViewController.navigationController pushViewController:audioVC animated:YES];
    }
    else if (indexPath.row == 1) {
        VideoListVC * videoVC = [[VideoListVC alloc] init];
        [self.sideMenuViewController.navigationController pushViewController:videoVC animated:YES];
    }
}

@end
