//
//  YSHarewareViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSHarewareViewController.h"

// 1
#import "CameraOrImageListVC.h"

//2
#import "CanlenderViewController.h"

static NSString * const HarewareCellID = @"HarewareCellID";

@interface YSHarewareViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * harewareTableView;

@end

@implementation YSHarewareViewController
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
    self.title = @"系统功能与硬件";
    
    _sectionTitleArr = @[@"1 系统功能", @"2 其他"];
    
    NSArray * sectionOne  = @[@"相册相机", @"闹钟", @"健康", @"日历", @"硬件连接", @"蓝牙", @"耳机", @"麦克风", @"邮件"];
    NSArray * sectionTwo  = @[@"陀螺仪", @"加速器"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo] mutableCopy];
}

- (void)createTableView
{
    _harewareTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _harewareTableView.delegate = self;
    _harewareTableView.dataSource = self;
    [self.view addSubview:_harewareTableView];
    [_harewareTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_harewareTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HarewareCellID];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:HarewareCellID];
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
            switch (indexPath.row) {
                case 0:
                {
                    CameraOrImageListVC * listVC = [[CameraOrImageListVC alloc] init];
                    listVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:listVC animated:YES];
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                case 3:
                {
                    
                }
                    break;
                case 4:
                {
                    // 日历事件
                    CanlenderViewController * canlenderVC = [[CanlenderViewController alloc] init];
                    canlenderVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:canlenderVC animated:YES];
                }
                    break;
                case 5:
                {
                    
                }
                    break;
                case 6:
                {
                    
                }
                    break;
                    
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
    }
}


@end
