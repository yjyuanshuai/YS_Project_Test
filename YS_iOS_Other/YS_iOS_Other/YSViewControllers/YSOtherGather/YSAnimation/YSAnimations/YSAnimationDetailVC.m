//
//  DemotionVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSAnimationDetailVC.h"
#import "YSAnimationDetailCollectionViewCell.h"

static NSString * const YSAnimationDetailCollectionViewCellID = @"YSAnimationDetailCollectionViewCellID";

@interface YSAnimationDetailVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView * animationView;
@property (nonatomic, strong) UICollectionView * animationCollectionView;

@end

@implementation YSAnimationDetailVC
{
    YSAnimationType _type;
    YSAnimationWay _way;
    
    NSMutableArray * _animationArr;
}

- (instancetype)initWithAnimationType:(YSAnimationType)type
                         animationWay:(YSAnimationWay)way
                                title:(NSString *)title;
{
    self = [super init];
    if (self) {
        _type = type;
        _way = way;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setInitData];
    [self createBgView];
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInitData
{
    _animationArr = [NSMutableArray array];
}

- (UIView *)createBgView
{
    UIView * bgView = [UIView new];
    bgView.backgroundColor = YSDefaultGrayColor;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 240, 0));
    }];
    
    _animationView = [UIImageView new];
    _animationView.backgroundColor = YSColorDefault;
    [bgView addSubview:_animationView];
    [_animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    return bgView;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (kScreenWidth-50)/4;
    flowLayout.itemSize = CGSizeMake(width, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    
    _animationCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _animationCollectionView.delegate = self;
    _animationCollectionView.dataSource = self;
    [self.view addSubview:_animationView];
    
    [_animationCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom).offset(240);
        make.height.mas_equalTo(230);
    }];
    
    [_animationCollectionView registerClass:[YSAnimationDetailCollectionViewCell class] forCellWithReuseIdentifier:YSAnimationDetailCollectionViewCellID];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_animationArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSAnimationDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSAnimationDetailCollectionViewCellID forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

@end
