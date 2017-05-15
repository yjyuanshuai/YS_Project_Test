//
//  YSAnimationsViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSAnimationsViewController.h"

// 1
#import "PictureAnimateViewController.h"
#import "TwoDemotionViewController.h"
#import "ThreeDemotionViewController.h"
#import "TurnPageViewController.h"
#import "ViewSimpleViewController.h"
#import "CoreAnimationViewController.h"
#import "CALayerAndBerzierVC.h"
#import "PresentViewController.h"

// 2
#import "JianShuNavAnimationViewController.h"

static NSString * const AnimationTableViewCellID = @"AnimationTableViewCellID";

@interface YSAnimationsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * animationTableView;

@end

@implementation YSAnimationsViewController
{
    NSMutableArray * _sectionTitlesArr;
    NSMutableArray * _animationsArr;
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
    self.title = @"各种动画效果";
    
    _sectionTitlesArr = [@[@"各种动画", @"一些效果"] mutableCopy];
    
    NSArray * sectionOne = @[@"帧动画", @"2D", @"3D", @"翻页", @"UIView简单", @"模态跳转", @"CoreAnimation", @"CALayer+UIBezierPath"];
    NSArray * sectionTwo = @[@"导航栏效果"];
    
    if (_animationsArr == nil) {
        _animationsArr = [@[sectionOne, sectionTwo] mutableCopy];
    }
}

- (void)createTableView
{
    _animationTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _animationTableView.delegate = self;
    _animationTableView.dataSource = self;
    [self.view addSubview:_animationTableView];
    
    [_animationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_animationTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AnimationTableViewCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_animationsArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_animationsArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AnimationTableViewCellID];
    NSArray * sectionData = _animationsArr[indexPath.section];
    cell.textLabel.text = sectionData[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitlesArr[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        NSInteger index = indexPath.row;
        
        switch (index) {
            case 0:
            {
                // 帧动画
                PictureAnimateViewController * pictureVC = [PictureAnimateViewController new];
                pictureVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:pictureVC animated:YES];
            }
                break;
            case 1:
            {
                // 2D 位移
                TwoDemotionViewController * twoVC = [TwoDemotionViewController new];
                twoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:twoVC animated:YES];
            }
                break;
            case 2:
            {
                // 3D 位移
                ThreeDemotionViewController * threeVC = [ThreeDemotionViewController new];
                threeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:threeVC animated:YES];
            }
                break;
            case 3:
            {
                // 翻页 CATransition
                TurnPageViewController * tureVC = [TurnPageViewController new];
                tureVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tureVC animated:YES];
            }
                break;
            case 4:
            {
                // UIView 动画
                ViewSimpleViewController * viewSimpleVC = [ViewSimpleViewController new];
                viewSimpleVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewSimpleVC animated:YES];
            }
                break;
            case 5:
            {
                // 模态跳转
                PresentViewController * presentVC = [PresentViewController new];
                presentVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:presentVC animated:YES];
            }
                break;
            case 6:
            {
                // CoreAnimation
                CoreAnimationViewController * coreVC = [CoreAnimationViewController new];
                coreVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:coreVC animated:YES];
            }
                break;
            case 7:
            {
                // CALayer + UIBezierPath
                CALayerAndBerzierVC * calayerAndBerVC = [[CALayerAndBerzierVC alloc] init];
                calayerAndBerVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:calayerAndBerVC animated:YES];
            }
                break;
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            JianShuNavAnimationViewController * navigationVC = [JianShuNavAnimationViewController new];
            navigationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:navigationVC animated:YES];
        }
    }
    else {
    
    }
}

@end
