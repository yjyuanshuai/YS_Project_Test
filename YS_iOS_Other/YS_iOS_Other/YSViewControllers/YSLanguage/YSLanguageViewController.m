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
#import "YSRuntimeUse.h"
#import "GlobalWebVC.h"
#import "YSCommonListVC.h"
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
    
    // temp
    NSMutableArray * _runtimeClassTitleArr;
    NSMutableArray * _runtimeClassContentArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
    [self getClassContentList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"语言";

    _sectionTitleArr = @[@"1 线程", @"2 触摸", @"3 Runtime"];
    
    NSArray * sectionOne    = @[@"GCD", @"NSOperation", @"NSThread", @"test"];
    NSArray * sectionTwo    = @[@"手势", @"自定义手势", @"触摸"];
    NSArray * sectionThird  = @[@"简介", @"1.获取列表", @"2.扩展系统方法（黑魔法）", @"3.动态添加方法", @"4.动态添加属性", @"5.动态加类"];
    
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

#pragma mark - 数据
// runtime 获取 class 的各种列表
- (void)getClassContentList
{
    if(!_runtimeClassTitleArr) {
        _runtimeClassTitleArr = [NSMutableArray array];
    }
    if(!_runtimeClassContentArr) {
        _runtimeClassContentArr = [NSMutableArray array];
    }
    
    _runtimeClassTitleArr = [NSMutableArray arrayWithArray:@[@"属性列表", @"方法列表", @"变量列表", @"协议列表"]];
    
    NSMutableArray * propertyList = [YSRuntimeUse getPropertyListForClass:[self class]];
    NSMutableArray * methodList = [YSRuntimeUse getMethodListForClass:[self class]];
    NSMutableArray * ivarList = [YSRuntimeUse getIvarListForClass:[self class]];
    NSMutableArray * protocolList = [YSRuntimeUse getProtocolListForClass:[self class]];
    
    [_runtimeClassContentArr addObjectsFromArray:@[propertyList, methodList, ivarList, protocolList]];
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
                // 简介
                GlobalWebVC * methodSwizzlingVC = [[GlobalWebVC alloc] initWithTitle:@"黑魔法" webUrl:YSURL_MethodSwizzling];
                methodSwizzlingVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:methodSwizzlingVC animated:YES];
            }
            else if (indexPath.row == 1) {
                // 1.获取列表
                YSCommonListVC * commonListVC = [[YSCommonListVC alloc] initWithType:YSListTypeRuntimeClass title:[NSString stringWithFormat:@"%@列表", NSStringFromClass([self class])]];
                commonListVC.sectionTitleArr = _runtimeClassTitleArr;
                commonListVC.contentArr = _runtimeClassContentArr;
                commonListVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:commonListVC animated:YES];
            }
            else if (indexPath.row == 2 ||
                     indexPath.row == 4) {
                // 2.扩展系统方法（黑魔法）
                // 4.动态添加属性
            }
            else if (indexPath.row == 3 ||
                     indexPath.row == 5) {
                // 3.动态添加方法
                // 5.动态加类
                YSRuntimeUse * runtimeUse = [[YSRuntimeUse alloc] init];
                if (indexPath.row == 3) {
                    [runtimeUse ysPerformSelector];
                }
                else if (indexPath.row == 5) {
                    [runtimeUse runtimeAddClassWithName:@"YSRuntimeAddClass"];
                }
                
            }
            
//            else if (indexPath.row == 2)
//            {
//                YS3DTouchVC * useVC = [[YS3DTouchVC alloc] init];
//                useVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:useVC animated:YES];
//            }
        }
            break;
            
        default:
            break;
    }
}


@end
