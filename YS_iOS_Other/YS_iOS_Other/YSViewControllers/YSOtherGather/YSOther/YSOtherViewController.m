//
//  YSOtherViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSOtherViewController.h"


// test


// 1 地图
#import "SevenBaiduViewController.h"

// 3 图文混排
#import "TextAttachmentViewController.h"
#import "YSCoreTextViewController.h"

// 4 音/视频
#import <RESideMenu.h>
#import "RightMenuViewController.h"
#import "AudioAndVideoMainViewController.h"
#import "AudioViewController.h"
#import "VideoListVC.h"

// 5 支付

// 6 琐碎功能集合
#import "AddIconToDesktopVC.h"      // 添加桌面快捷方式
#import "JSAndOCMethodListVC.h"     // JS 与 OC交互


static NSString * const OtherCellID = @"OtherCellID";

@interface YSOtherViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * otherTableView;

@end

@implementation YSOtherViewController
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
    self.title = @"其他";
    
    _sectionTitleArr = @[@"1 地图", @"2 本地化", @"3 图文混排", @"4 音/视频", @"5 支付", @"6 琐碎功能集合", @"7 "];
    
    NSArray * sectionOne    = @[@"原生", @"百度", @"高德"];
    NSArray * sectionTwo    = @[@"本地化"];
    NSArray * sectionThree  = @[@"NSTextAttachment", @"CoreText"];
    NSArray * audioArr      = @[@"主界面", @"音频", @"视频"];
    NSArray * payArr        = @[@"招行一网通"];
    NSArray * someFun       = @[@"Quartz", @"OpenGL", @"桌面快捷方式", @"JS与OC交互"];
    NSArray * tempArr       = @[@"temp1"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo, sectionThree, audioArr, payArr, someFun, tempArr] mutableCopy];
}

- (void)createTableView
{
    _otherTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _otherTableView.delegate = self;
    _otherTableView.dataSource = self;
    [self.view addSubview:_otherTableView];
    [_otherTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_otherTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OtherCellID];
}

#pragma mark - UITableViewDataSource
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:OtherCellID];
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger indexSection = indexPath.section;
    switch (indexSection) {
        case 0:
        {
            if (indexPath.row == 0)
            {
                // 原生地图
                
            }
            else if (indexPath.row == 1)
            {
                // 百度地图
                SevenBaiduViewController * baiduMapVC = [[SevenBaiduViewController alloc] init];
                baiduMapVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:baiduMapVC animated:YES];
            }
            else if (indexPath.row == 2)
            {
                // 高德
            }
            
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0)
            {
                // 本地化
            }
        }
            break;
            
        case 2:
        {
            if (indexPath.row == 0) {
                
                TextAttachmentViewController * textAttachVC = [[TextAttachmentViewController alloc] init];
                textAttachVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:textAttachVC animated:YES];
                
            }
            else if (indexPath.row == 1) {
                
                // CoreText 图文混排
                YSCoreTextViewController * coreTextVC = [[YSCoreTextViewController alloc] init];
                coreTextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:coreTextVC animated:YES];
                
            }
        }
            break;
            
        case 3:
        {
            if (indexPath.row == 0)
            {
                // 主界面
                AudioAndVideoMainViewController * mainVC = [[AudioAndVideoMainViewController alloc] init];
                
                RightMenuViewController * rightVC = [[RightMenuViewController alloc] init];
                
                RESideMenu * sideMenuVC = [[RESideMenu alloc] initWithContentViewController:mainVC
                                                                     leftMenuViewController:nil
                                                                    rightMenuViewController:rightVC];
                sideMenuVC.backgroundImage = [UIImage imageNamed:@"Stars"];
                sideMenuVC.hidesBottomBarWhenPushed = YES;
                sideMenuVC.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
//                sideMenuVC.contentViewShadowColor = [UIColor blackColor];
//                sideMenuVC.contentViewShadowOffset = CGSizeMake(0, 0);
//                sideMenuVC.contentViewShadowOpacity = 0.6;
//                sideMenuVC.contentViewShadowRadius = 12;
//                sideMenuVC.contentViewShadowEnabled = YES;
                
                sideMenuVC.title = @"音/视频主界面";
                sideMenuVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右滑"
                                                                                                style:UIBarButtonItemStylePlain
                                                                                               target:sideMenuVC
                                                                                               action:@selector(presentRightMenuViewController)];
                [self.navigationController pushViewController:sideMenuVC animated:YES];
                
            }
            else if (indexPath.row == 1) {
                // 音频
                AudioViewController * audioVC = [[AudioViewController alloc] init];
                audioVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:audioVC animated:YES];
            }
            else if (indexPath.row == 2) {
                // 视频
                VideoListVC * videoVC = [[VideoListVC alloc] init];
                videoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:videoVC animated:YES];
            }
        }
            break;

        case 4:
        {
            if (indexPath.row == 0)
            {
                
            }
        }
            break;
        case 5:
        {
            if (indexPath.row == 0) {
                
            }
            else if (indexPath.row == 1) {
                
            }
            else if (indexPath.row == 2) {
                // 创建桌面快捷方式
                AddIconToDesktopVC * addIconVC = [[AddIconToDesktopVC alloc] init];
                addIconVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:addIconVC animated:YES];
            }
            else if (indexPath.row == 3) {
                // JS与交互
                JSAndOCMethodListVC * jsMethodVC = [[JSAndOCMethodListVC alloc] init];
                jsMethodVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:jsMethodVC animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
