//
//  YSCustemCollectionVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/2.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionVC.h"

@interface YSCustemCollectionVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * weeksScrollView;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation YSCustemCollectionVC
{
    NSArray * _weeksArr;
    NSArray * _timesoltsArr;
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
    self.title = @"自定义 CollectionView 布局";

    _weeksArr = @[@[@"8-1", @"8-2", @"8-3", @"8-4", @"8-5", @"8-6", @"8-7"],
                  @[@"8-8", @"8-9", @"8-10", @"8-11", @"8-12", @"8-13", @"8-14"],
                  @[@"8-15", @"8-16", @"8-17", @"8-18", @"8-19", @"8-20", @"8-21"]];

    _timesoltsArr = @[@"0:00-2:00", @"2:00-4:00", @"4:00-6:00", @"6:00-8:00", @"8:00-10:00", @"10:00-12:00", @"12:00-14:00", @"14:00-16:00", @"16:00-18:00", @"18:00-20:00", @"20:00-22:00", @"22:00-24:00"];


}

- (void)createScrollView
{
    _weeksScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeightNo64)];
    _weeksScrollView.delegate = self;
    _weeksScrollView.contentSize = CGSizeMake([_weeksArr count]*kScreenWidth, kScreenHeightNo64);
    [self.view addSubview:_weeksScrollView];
}

- (void)createCollectionView
{
    
}

#pragma mark - UIScrollViewDelegate


#pragma mark -

@end
