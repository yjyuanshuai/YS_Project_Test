//
//  YSAnimationsViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSAnimationsViewController.h"
#import "YSAnimationDetailVC.h"

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
#import "YSAQYPlayOrPauseVC.h"

static NSString * const AnimationTableViewCellID = @"AnimationTableViewCellID";
static NSInteger const SectionTag = 20171109;

@interface YSAnimationsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * animationTableView;

@end

@implementation YSAnimationsViewController
{
    NSMutableArray * _sectionTitlesArr;
    NSMutableArray * _sectionOpenArr;
    NSMutableArray * _animationsArr;
    NSInteger _clickSection;
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
    self.title = @"动画";
    
    _sectionTitlesArr = [@[@"Image帧动画", @"普通2D/3D", @"转场动画", @"一些动画效果"] mutableCopy];
    _sectionOpenArr = [@[@(NO), @(NO), @(NO), @(NO)] mutableCopy];
    
    _animationsArr = [@[@[@"Image帧动画"],
                        @[@"属性实现", @"UIView-API", @"UIView-Block", @"核心动画"],
                        @[@"UIView-API", @"UIView-Block", @"CATrantion"],
                        @[@"导航栏效果", @"爱奇艺播放/暂停按钮"]] mutableCopy];
    _clickSection = -1;
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

- (void)clickSectionView:(UITapGestureRecognizer *)tap
{
    NSInteger clickSection = tap.view.tag - SectionTag;
    if (clickSection == [_sectionOpenArr count]-1) {
        return;
    }
    Boolean isOpen = [_sectionOpenArr[clickSection] boolValue];
    [_sectionOpenArr replaceObjectAtIndex:clickSection withObject:@(!isOpen)];
    NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:clickSection];
    [_animationTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitlesArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * animationSection = _animationsArr[section];
    if (section == [_sectionTitlesArr count] - 1) {
        return [animationSection count];
    }
    else if ([animationSection count] > 0 && [_sectionOpenArr[section] boolValue]) {
        return [animationSection count];
    }
    return 0;
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
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    sectionView.tag = SectionTag + section;
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 50)];
    titleLabel.text = _sectionTitlesArr[section];
    [sectionView addSubview:titleLabel];
    
    UITapGestureRecognizer * tapGesure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSectionView:)];
    [sectionView addGestureRecognizer:tapGesure];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
        
        NSString * title = _animationsArr[indexPath.section][indexPath.row];
        YSAnimationType type = -1;
        YSAnimationWay way = -1;
        
        if (indexPath.section == 0) {
            type = YSAnimationTypeImageKey;
            way = YSAnimationWayDefault;
        }
        else if (indexPath.section == 1) {
            type = YSAnimationType2or3D;
            if (indexPath.row == 0) {
                way = YSAnimationWayDefault;
            }
            else if (indexPath.row == 1) {
                way = YSAnimationWayUIViewAPI;
            }
            else if (indexPath.row == 2) {
                way = YSAnimationWayUIViewBlock;
            }
            else if (indexPath.row == 3) {
                way = YSAnimationWayCABasicAnimation;
            }
        }
        else if (indexPath.section == 2) {
            type = YSAnimationTypeTurnArounds;
            if (indexPath.row == 0) {
                way = YSAnimationWayUIViewAPI;
            }
            else if (indexPath.row == 1) {
                way = YSAnimationWayUIViewBlock;
            }
            else if (indexPath.row == 2) {
                way = YSAnimationWayCATransition;
            }
        }
        
        YSAnimationDetailVC * animationDetailVC = [[YSAnimationDetailVC alloc] initWithAnimationType:type animationWay:way title:title];
        animationDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:animationDetailVC animated:YES];
    }
    else if (indexPath.section == 3) {
        // 其他效果动画
        if (indexPath.row == 0) {
            // navigationBar
            JianShuNavAnimationViewController * navigationVC = [JianShuNavAnimationViewController new];
            navigationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:navigationVC animated:YES];
        }
        else {
            // 爱奇艺播放/暂停动画
            YSAQYPlayOrPauseVC * aqyVC = [[YSAQYPlayOrPauseVC alloc] init];
            aqyVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aqyVC animated:YES];
        }
    }
    
     /*
    if (indexPath.section == 0) {
        NSInteger index = indexPath.row;
        
        switch (index) {
            
           
            case 0:
            {
                // 帧动画
      
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
            // navigationBar
            JianShuNavAnimationViewController * navigationVC = [JianShuNavAnimationViewController new];
            navigationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:navigationVC animated:YES];
        }
        else {
            // 爱奇艺播放/暂停动画
            YSAQYPlayOrPauseVC * aqyVC = [[YSAQYPlayOrPauseVC alloc] init];
            aqyVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aqyVC animated:YES];
        }
    }
    else {
    
    }
      */
}

@end
