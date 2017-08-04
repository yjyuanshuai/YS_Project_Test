//
//  YSCustemCollectionVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/2.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionVC.h"
#import "YSCustemCollectionViewFlowLayout.h"
#import "YSCustemCollectionViewCell.h"
#import "YSCustemCollectionViewHeadCell.h"
#import "YSCustemCollectionViewFootCell.h"

static NSString * const YSCustemCollectionViewCellID = @"YSCustemCollectionViewCellID";
static NSString * const YSCustemCollectionViewHeadCellID = @"YSCustemCollectionViewHeadCellID";
static NSString * const YSCustemCollectionViewFootCellID = @"YSCustemCollectionViewFootCellID";

@interface YSCustemCollectionVC ()<YSCustemCollectionViewFlowLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) YSCustemCollectionViewFlowLayout * ysCollectionViewFlowLayout;
@property (nonatomic, strong) UICollectionView * collectionView;


@end

@implementation YSCustemCollectionVC
{
    NSMutableArray * _imagesArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initUIAndData];
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"自定义 CollectionView 布局";
    if (!_imagesArr) {
        _imagesArr = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            NSString * str = [NSString stringWithFormat:@"collection_%d", (int)i];
            [_imagesArr addObject:str];
        }
    }
}

- (void)createCollectionView
{
    _ysCollectionViewFlowLayout = [[YSCustemCollectionViewFlowLayout alloc] init];
    _ysCollectionViewFlowLayout.delegate = self;
    _ysCollectionViewFlowLayout.ysSectionHeadHeightArr = [NSMutableArray arrayWithArray:@[@(80)]];
    _ysCollectionViewFlowLayout.ysSectionFootHeightArr = [NSMutableArray arrayWithArray:@[@(45)]];

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_ysCollectionViewFlowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];

    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [_collectionView registerClass:[YSCustemCollectionViewCell class] forCellWithReuseIdentifier:YSCustemCollectionViewCellID];
    [_collectionView registerClass:[YSCustemCollectionViewHeadCell class] forSupplementaryViewOfKind:YSCustemCollectionView_SectionHeadID withReuseIdentifier:YSCustemCollectionViewHeadCellID];
    [_collectionView registerClass:[YSCustemCollectionViewFootCell class] forSupplementaryViewOfKind:YSCustemCollectionView_SectionFootID withReuseIdentifier:YSCustemCollectionViewFootCellID];
}

#pragma mark - YSCustemCollectionViewFlowLayoutDelegate
- (CGFloat)ysCustemCollectionView:(UICollectionView *)collectionView
          itemHeightWithIndexPath:(NSIndexPath *)indexPath
                        itemWidth:(CGFloat)itemWidth
{
    UIImage * image = [UIImage imageNamed:_imagesArr[indexPath.row]];
    return (image.size.height/image.size.width)*itemWidth;
}

#pragma mark - UICollectionViewDelegate / UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_imagesArr count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSCustemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSCustemCollectionViewCellID forIndexPath:indexPath];
    [cell setYSCustemCollectionViewCellContent:_imagesArr[indexPath.row] itemStr:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    return cell;
}

@end
