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
    NSMutableArray * _allSectionDataArr;
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

#pragma mark -

- (void)initUIAndData
{
    self.title = @"自定义 CollectionView 布局";

    _allSectionDataArr = [NSMutableArray array];

    NSMutableArray * sectionZeroImagesMutArr = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSString * str = [NSString stringWithFormat:@"collection_%d", (int)i];
        [sectionZeroImagesMutArr addObject:str];
    }
    NSMutableArray * sectionOneImageMutArr = [NSMutableArray arrayWithArray:sectionZeroImagesMutArr];

    _allSectionDataArr = [NSMutableArray arrayWithArray:@[sectionZeroImagesMutArr, sectionOneImageMutArr]];
}

- (void)createCollectionView
{
    _ysCollectionViewFlowLayout = [[YSCustemCollectionViewFlowLayout alloc] init];
    _ysCollectionViewFlowLayout.delegate = self;
    _ysCollectionViewFlowLayout.ysSectionHeadHeightArr = [NSMutableArray arrayWithArray:@[@(80), @(20)]];
    _ysCollectionViewFlowLayout.ysSectionFootHeightArr = [NSMutableArray arrayWithArray:@[@(45), @(20)]];

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_ysCollectionViewFlowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];

    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [_collectionView registerClass:[YSCustemCollectionViewCell class] forCellWithReuseIdentifier:YSCustemCollectionViewCellID];
    [_collectionView registerClass:[YSCustemCollectionViewHeadCell class] forSupplementaryViewOfKind:YSCustemCollectionView_SectionHeadKind withReuseIdentifier:YSCustemCollectionViewHeadCellID];
    [_collectionView registerClass:[YSCustemCollectionViewFootCell class] forSupplementaryViewOfKind:YSCustemCollectionView_SectionFootKind withReuseIdentifier:YSCustemCollectionViewFootCellID];

    UILongPressGestureRecognizer * longGesureToMove = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesureToMove:)];
    [_collectionView addGestureRecognizer:longGesureToMove];
}

- (void)longGesureToMove:(UILongPressGestureRecognizer *)longGesure
{
    if (kSystemVersion < 9.0) {
        return;
    }
    
    UIGestureRecognizerState state = longGesure.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath * indexPath = [_collectionView indexPathForItemAtPoint:[longGesure locationInView:_collectionView]];
            if (indexPath) {
                [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            else {
                [_collectionView cancelInteractiveMovement];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [_collectionView updateInteractiveMovementTargetPosition:[longGesure locationInView:_collectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [_collectionView endInteractiveMovement];
        }
            break;
        default:
            break;
    }
}

#pragma mark - YSCustemCollectionViewFlowLayoutDelegate
- (CGFloat)ysCustemCollectionView:(UICollectionView *)collectionView
          itemHeightWithIndexPath:(NSIndexPath *)indexPath
                        itemWidth:(CGFloat)itemWidth
{
    NSMutableArray * images = _allSectionDataArr[indexPath.section];
    NSString * path = [[NSBundle mainBundle] pathForResource:images[indexPath.row] ofType:@"jpg"];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    CGFloat itemHeight = (image.size.height/image.size.width)*itemWidth + 20;
    return itemHeight;
}

- (void)ysCustemCollectionView:(UICollectionView *)collectionView
                beginIndexPath:(NSIndexPath *)beginIndexPath
                  endIndexPath:(NSIndexPath *)endIndexPath
{
    if ((beginIndexPath.section == endIndexPath.section) && (beginIndexPath.row != endIndexPath.row)) {
        NSMutableArray * images = _allSectionDataArr[beginIndexPath.section];
        NSString * value = images[beginIndexPath.row];
        [images removeObjectAtIndex:beginIndexPath.row];
        [images insertObject:value atIndex:endIndexPath.row];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_allSectionDataArr count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[_allSectionDataArr objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSCustemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSCustemCollectionViewCellID forIndexPath:indexPath];
    NSMutableArray * images = _allSectionDataArr[indexPath.section];
    if (indexPath.row < [images count]) {
        [cell setYSCustemCollectionViewCellContent:images[indexPath.row] itemStr:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:YSCustemCollectionView_SectionHeadKind]) {
        YSCustemCollectionViewHeadCell * headCell = [collectionView dequeueReusableSupplementaryViewOfKind:YSCustemCollectionView_SectionHeadKind withReuseIdentifier:YSCustemCollectionViewHeadCellID forIndexPath:indexPath];
        headCell.headLabel.text = @"段头文字";
        return headCell;
    }
    else if ([kind isEqualToString:YSCustemCollectionView_SectionFootKind]) {
        YSCustemCollectionViewFootCell * footCell = [collectionView dequeueReusableSupplementaryViewOfKind:YSCustemCollectionView_SectionFootKind withReuseIdentifier:YSCustemCollectionViewFootCellID forIndexPath:indexPath];
        footCell.footLabel.text = @"段尾文字";
        return footCell;
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0)
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0)
{
    
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 加显示动画
    cell.contentView.alpha = 0;
    cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0, 0), 0);


    [UIView animateKeyframesWithDuration:.5 delay:0.0 options:0 animations:^{

        /**
         *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
         */
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            cell.contentView.alpha = .5;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0);

        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = 1;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), 0);

        }];

    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"cut:"] ||
        [NSStringFromSelector(action) isEqualToString:@"paste:"] ||
        [NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        return YES;
    }

    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    if ([NSStringFromSelector(action) isEqualToString:@"cut:"]) {
        NSArray* itemPaths = @[indexPath];
        for (NSIndexPath * index in itemPaths) {
            NSMutableArray * images = [_allSectionDataArr objectAtIndex:index.section];
            [images removeObjectAtIndex:index.row];
        }
        [_collectionView deleteItemsAtIndexPaths:itemPaths];
    }else if ([NSStringFromSelector(action) isEqualToString:@"paste:"]){

    }else if ([NSStringFromSelector(action) isEqualToString:@"copy:"]){
        NSArray* itemPaths = @[indexPath];
        for (NSIndexPath * index in itemPaths) {
            NSMutableArray * images = [_allSectionDataArr objectAtIndex:index.section];
            UIImage * image = images[index.row];
            [images insertObject:image atIndex:index.row];
        }
        [_collectionView insertItemsAtIndexPaths:itemPaths];
    }
}

@end
