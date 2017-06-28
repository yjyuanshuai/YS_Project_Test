//
//  YSSaveDataViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSaveDataViewController.h"

// 1 存储
#import "TwoDocumentViewController.h"
#import "FileKnowledgeView.h"
#import "CodeKnowledgeView.h"
#import "FileOrCodeViewController.h"
#import "YSDefaultsViewController.h"
#import "YSKeyChainViewController.h"


// 2 数据库
#import "SQLViewController.h"
#import "CoreDataViewController.h"


// 3 数据解析
#import "JSonViewController.h"
#import "XmlViewController.h"


// 4 其他




static NSString * const SaveDataCellID = @"SaveDataCellID";

@interface YSSaveDataViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * savedateTableView;

@end

@implementation YSSaveDataViewController
{
    NSArray * _sectionTitleArr;
    NSMutableArray * _sectionCellContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initWithUIAndData];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initWithUIAndData
{
    self.title = @"数据持久化";
    self.tabBarItem.title = @"数据";
    
    _sectionTitleArr = @[@"1 存储", @"2 数据库", @"3 数据解析", @"4 其他"];
    
    NSArray * sectionOne    = @[@"沙盒", @"文件", @"归档", @"偏好设置", @"钥匙串"];
    NSArray * sectionTwo    = @[@"sqlite", @"CoreData"];
    NSArray * sectionThree  = @[@"使用UIDocument管理文件存储", @"添加iCloud支持"];
    NSArray * dataAnalysis  = @[@"JSon", @"XML"];
    
    _sectionCellContent = [@[sectionOne, sectionTwo, dataAnalysis, sectionThree] mutableCopy];
}

- (void)createTableView
{
    _savedateTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _savedateTableView.delegate = self;
    _savedateTableView.dataSource = self;
    [self.view addSubview:_savedateTableView];
    
    [_savedateTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SaveDataCellID];
    
//    [self addConstraintWithClassMethod];
    [self addConstraintWithVFL];
}

- (void)addConstraintWithClassMethod
{
    _savedateTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint * top_c = [NSLayoutConstraint constraintWithItem:_savedateTableView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0];
    NSLayoutConstraint * left_c = [NSLayoutConstraint constraintWithItem:_savedateTableView
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:0];
    NSLayoutConstraint * bottem_c = [NSLayoutConstraint constraintWithItem:_savedateTableView
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0];
    NSLayoutConstraint * right_c = [NSLayoutConstraint constraintWithItem:_savedateTableView
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:0];
    
    [self.view addConstraints:@[top_c, left_c, bottem_c, right_c]];
}

- (void)addConstraintWithVFL
{
    /**
     *  水平方向        H:
     *  垂直方向        V:
     *  Views         [view]
     *  SuperView     |
     *  关系           >=,==,<=
     *  空间,间隙       -
     *  优先级         @value
     */
    NSString * top_VFL = @"V:|-topDistence-[_savedateTableView]";
    NSString * left_VFL = @"H:|-leftDistance-[_savedateTableView]";
    NSString * bottem_VFL = @"V:[_savedateTableView]-bottemDistance-|";
    NSString * right_VFL = @"H:[_savedateTableView]-rightDistance-|";
    
    // _savedateTableView 是目标控件
    // customWidth 设置的宽度（NSNumber类型）
//    NSString * width_VFL = @"H:[_savedateTableView(== customWidth)]";
//    NSString * height_VFL = @"V:[_savedateTableView(== customHeight)]";
    
    // metrics Dic
    NSDictionary * metricsDic = @{@"topDistence":@0, @"leftDistance":@0, @"bottemDistance":@0, @"rightDistance":@0};
    
    // views Dic
    NSDictionary * viewsDic = @{@"_savedateTableView":_savedateTableView};
    
    
    
    
    _savedateTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray * top_c = [NSLayoutConstraint constraintsWithVisualFormat:top_VFL
                                                               options:0
                                                               metrics:metricsDic
                                                                 views:viewsDic];
    
    NSArray * left_c = [NSLayoutConstraint constraintsWithVisualFormat:left_VFL
                                                               options:0
                                                               metrics:metricsDic
                                                                 views:viewsDic];
    
    NSArray * bottem_c = [NSLayoutConstraint constraintsWithVisualFormat:bottem_VFL
                                                                 options:0
                                                                 metrics:metricsDic
                                                                   views:viewsDic];
    
    NSArray * right_c = [NSLayoutConstraint constraintsWithVisualFormat:right_VFL
                                                                options:0
                                                                metrics:metricsDic
                                                                  views:viewsDic];
    [self.view addConstraints:top_c];
    [self.view addConstraints:left_c];
    [self.view addConstraints:bottem_c];
    [self.view addConstraints:right_c];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SaveDataCellID];
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
                // “沙盒”
                TwoDocumentViewController * collectionVC = [[TwoDocumentViewController alloc] init];
                collectionVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:collectionVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                // "文件"
                FileOrCodeViewController * fileVC = [[FileOrCodeViewController alloc] initWithTitle:@"文件管理" viewClass:NSClassFromString(@"FileKnowledgeView") rightBtn:@"应用"];
                fileVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:fileVC animated:YES];
            }
            else if (indexPath.row == 2)
            {
                // “归档”
                FileOrCodeViewController * codeVC = [[FileOrCodeViewController alloc] initWithTitle:@"归档管理" viewClass:NSClassFromString(@"CodeKnowledgeView") rightBtn:@"归档"];
                codeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:codeVC animated:YES];
            }
            else if (indexPath.row == 3)
            {
                // “偏好设置”
                YSDefaultsViewController * defaultVC = [[YSDefaultsViewController alloc] init];
                defaultVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:defaultVC animated:YES];
            }
            else if (indexPath.row == 4)
            {
                // “钥匙串”
                YSKeyChainViewController * keychainVC = [[YSKeyChainViewController alloc] init];
                keychainVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:keychainVC animated:YES];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row == 0)
            {
                SQLViewController * sqlVC = [[SQLViewController alloc] init];
                sqlVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:sqlVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                CoreDataViewController * coredataVC = [[CoreDataViewController alloc] init];
                coredataVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:coredataVC animated:YES];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0)
            {
                JSonViewController * jsonVC = [[JSonViewController alloc] init];
                [self.navigationController pushViewController:jsonVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                XmlViewController * XMLVC = [[XmlViewController alloc] init];
                [self.navigationController pushViewController:XMLVC animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}


@end
