//
//  YSLanguageViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSLanguageViewController.h"

// 1
#import "YSGCDViewController.h"
#import "YSOperationVC.h"
#import "YSThreadVC.h"

// 2
#import "SixGestureViewController.h"
#import "YSTouchViewController.h"

// 3 黑魔法
#import "GlobalWebVC.h"
#import "YS3DTouchVC.h"

//test
#import "YSTestVC.h"

static NSString * const LanguageCellID = @"LanguageCellID";

@interface YSLanguageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * languageTableView;

@end

@implementation YSLanguageViewController
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
    self.title = @"语言";

    _sectionTitleArr = @[@"1 线程", @"2 触摸", @"3 黑魔法"];
    
    NSArray * sectionOne    = @[@"GCD", @"NSOperation", @"NSThread", @"test"];
    NSArray * sectionTwo    = @[@"手势", @"自定义手势", @"触摸"];
    NSArray * sectionThird  = @[@"简介", @"扩展系统方法", @"动态添加属性", @"动态添加方法", @"动态变量控制"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo, sectionThird] mutableCopy];
}

- (void)createTableView
{
    _languageTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _languageTableView.delegate = self;
    _languageTableView.dataSource = self;
    [self.view addSubview:_languageTableView];
    [_languageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_languageTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LanguageCellID];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LanguageCellID];
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
            if (indexPath.row == 0) {
                // GCD
                YSGCDViewController * gcdVC = [[YSGCDViewController alloc] init];
                gcdVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:gcdVC animated:YES];
            }
            else if (indexPath.row == 1) {
                // NSOperation
                YSOperationVC * operationVC = [[YSOperationVC alloc] init];
                operationVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:operationVC animated:YES];
            }
            else if (indexPath.row == 2) {
                
                // NSThread
                YSThreadVC * threadVC = [[YSThreadVC alloc] init];
                threadVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:threadVC animated:YES];
            }
            else {
                YSTestVC * testVC = [[YSTestVC alloc] init];
                testVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:testVC animated:YES];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0)
            {
                // 手势
                SixGestureViewController * gestureVC = [[SixGestureViewController alloc] init];
                gestureVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:gestureVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                // 自定义手势
                
            }
            else if (indexPath.row == 2){
                // 触摸
                YSTouchViewController * touchVC = [[YSTouchViewController alloc] init];
                touchVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:touchVC animated:YES];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0)
            {
                GlobalWebVC * methodSwizzlingVC = [[GlobalWebVC alloc] initWithTitle:@"黑魔法" webUrl:YSURL_MethodSwizzling];
                methodSwizzlingVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:methodSwizzlingVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                YS3DTouchVC * useVC = [[YS3DTouchVC alloc] init];
                useVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:useVC animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
