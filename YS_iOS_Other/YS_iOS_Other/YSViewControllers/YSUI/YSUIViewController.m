//
//  ViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSUIViewController.h"

// 1 选择
#import "OnePickerViewController.h"


// 2 滚动
#import "OneCollectionViewController.h"
#import "YSCustemCollectionVC.h"
#import "OneHorizontalTableViewController.h"


// 3 搜索
#import "OneSearchDisplayController.h"
#import "OneSearchController.h"
#import "CustemSearchViewController.h"


// 4 Application
#import "ApplicationSettingViewController.h"


// 5 alertController
#import "YSAlertController.h"


// 6 UIMenuController
#import "YSMenuControllerVC.h"
#import "ChatViewController.h"

@interface YSUIViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * otherTableView;

@end

@implementation YSUIViewController
{
    NSArray * _sectionTitle;
    NSMutableArray * _sectionCellContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.title = @"UI控件";
    self.tabBarItem.title = @"UI";
    
    _sectionTitle = @[@"1 选择", @"2 滚动", @"3 搜索", @"4 Application", @"5 Alert Controller", @"6 Menu Controller"];
    NSArray * sectionOne    = @[@"Picker"];
    NSArray * sectionTwo    = @[@"CollectionView", @"自定义CollectionView布局", @"横向tableView"];
    NSArray * sectionThree  = @[@"UISearchDisplayController", @"UISearchController", @"自定义SearchBar"];
    NSArray * sectionFour   = @[@"UIApplicaton一些设置"];
    NSArray * sectionFive   = @[@"AlertController"];
    NSArray * sectionSix    = @[@"Menu Controller-UI控件", @"Menu Controller-TableviewCell"];

    
    if (_sectionCellContent == nil) {
        _sectionCellContent = [NSMutableArray array];
    }
    
    _sectionCellContent = [@[sectionOne, sectionTwo, sectionThree, sectionFour, sectionFive, sectionSix] mutableCopy];
}

- (void)initTableView
{
    _otherTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeightNo113) style:UITableViewStyleGrouped];
    _otherTableView.delegate = self;
    _otherTableView.dataSource = self;
    [self.view addSubview:_otherTableView];
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_sectionCellContent objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"CELL_ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    NSArray * sectionContent = [_sectionCellContent objectAtIndex:indexPath.section];
    cell.textLabel.text = [sectionContent objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sectionTitle objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int sectionIndex = (int)indexPath.section;
    switch (sectionIndex) {
        case 0:
        {
            if (indexPath.row == 0)
            {
                // "Picker"
                OnePickerViewController * pickerVC = [[OnePickerViewController alloc] init];
                pickerVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:pickerVC animated:YES];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0)
            {
                // “CollectionView”
                OneCollectionViewController * collectionVC = [[OneCollectionViewController alloc] init];
                collectionVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:collectionVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                // 自定义 ColectionView 布局，瀑布流
                YSCustemCollectionVC * custemCollectionView = [[YSCustemCollectionVC alloc] initWithType:YSCustemCollectionViewTypeFallWater title:@"瀑布流"];
                custemCollectionView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:custemCollectionView animated:YES];
            }
            else if (indexPath.row == 2) {
                // 自定义 CollectionView 布局，堆叠
                YSCustemCollectionVC * custemCollectionView = [[YSCustemCollectionVC alloc] initWithType:YSCustemCollectionViewTypeStack title:@"堆叠"];
                custemCollectionView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:custemCollectionView animated:YES];
            }
            else if (indexPath.row == 3) {
                // 自定义 CollectionView 布局，圆形
                YSCustemCollectionVC * custemCollectionView = [[YSCustemCollectionVC alloc] initWithType:YSCustemCollectionViewTypeCircle title:@"圆形"];
                custemCollectionView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:custemCollectionView animated:YES];
            }
            else if (indexPath.row == 4)
            {
                // 横向 tableview
                OneHorizontalTableViewController * horizontalVC = [[OneHorizontalTableViewController alloc] init];
                horizontalVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:horizontalVC animated:YES];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0)
            {
                // UISearchDisplayController
                OneSearchDisplayController * searchVC = [[OneSearchDisplayController alloc] init];
                searchVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:searchVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                // UISearchController
                OneSearchController * searchVC = [[OneSearchController alloc] init];
                searchVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:searchVC animated:YES];
            }
            else if (indexPath.row == 2)
            {
                // 自定义SearchBar
                CustemSearchViewController * searchBarVC = [[CustemSearchViewController alloc] init];
                searchBarVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:searchBarVC animated:YES];
            }
        }
            break;
        case 3:
        {
            if (indexPath.row == 0)
            {
                // UIApplicaton一些设置
                ApplicationSettingViewController * appVC = [[ApplicationSettingViewController alloc] init];
                appVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:appVC animated:YES];
            }
        }
            break;
        case 4:
        {
            if (indexPath.row == 0) {
                // AlertController
                YSAlertController * alertCon = [[YSAlertController alloc] init];
                alertCon.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:alertCon animated:YES];
            }
        }
            break;
        case 5:
        {
            if (indexPath.row == 0) {
                YSMenuControllerVC * menuVC = [[YSMenuControllerVC alloc] init];
                menuVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:menuVC animated:YES];
            }
            else if (indexPath.row == 1) {
                ChatViewController * cellMenuVC = [[ChatViewController alloc] init];
                cellMenuVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:cellMenuVC animated:YES];
            }
        }
            break;
        default:
            break;
    }
        
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

@end
