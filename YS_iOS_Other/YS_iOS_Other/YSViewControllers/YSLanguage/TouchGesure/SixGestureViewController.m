//
//  SixGestureViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SixGestureViewController.h"
#import "GestureCollectionReusableView.h"
#import "GestureCollectionViewCell.h"

static NSString * const collectionViewCellID = @"collectionViewCellID";
static NSString * const collectionViewHeadID = @"collectionViewHeadID";
static NSString * const collectionViewFootID = @"collectionViewFootID";

@interface SixGestureViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITapGestureRecognizer *          ysTapGesure;            // 点按
@property (nonatomic, strong) UILongPressGestureRecognizer *    ysLongGesure;           // 长按
@property (nonatomic, strong) UISwipeGestureRecognizer *        ysSwipeGesture;         // 轻扫
@property (nonatomic, strong) UIPanGestureRecognizer *          ysPanGesture;           // 拖动
@property (nonatomic, strong) UIPinchGestureRecognizer *        ysPinchGesture;         // 捏合
@property (nonatomic, strong) UIRotationGestureRecognizer *     ysRotationGesture;      // 旋转

@property (nonatomic, strong) UICollectionView * gestureCollectionView;

@end

@implementation SixGestureViewController
{
    NSArray * _sectionTitlesArr;
    NSArray * _sectionContentsArr;
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
    self.title = @"手势";
    
    _sectionTitlesArr = @[@"系统手势", @"自定义手势"];
    NSArray * sectionOne = @[@"点按", @"长按", @"轻扫", @"拖动", @"捏合", @"旋转"];
    NSArray * sectionTwo = @[@""];
    _sectionContentsArr = @[sectionOne, sectionTwo];
    
    _ysTapGesure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesureAction)];
    _ysTapGesure.numberOfTapsRequired = 1;      // 点按的次数
    _ysTapGesure.numberOfTouchesRequired = 1;   // 手指数
    
    
    _ysLongGesure = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesureAction)];
    _ysLongGesure.numberOfTouchesRequired = 1;
    _ysLongGesure.numberOfTapsRequired = 0;
    _ysLongGesure.minimumPressDuration = 0.5;   // 最小的长按时间
    _ysLongGesure.allowableMovement = 10;       // 最大移动距离
    
    
    _ysSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesureAction)];
    _ysSwipeGesture.numberOfTouchesRequired = 1;
    _ysSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;  // 轻扫的方向
    
    
    _ysPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesureAction)];
    _ysPanGesture.minimumNumberOfTouches = 1;
    _ysPanGesture.maximumNumberOfTouches = 1;
    
    
    _ysPinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinGesureAction)];
    _ysPinchGesture.scale = 10;
    
    
    _ysRotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGesureAction)];
    _ysRotationGesture.rotation = M_PI/2;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    _gestureCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeightNo64) collectionViewLayout:flowLayout];
    _gestureCollectionView.delegate = self;
    _gestureCollectionView.dataSource = self;
    [self.view addSubview:_gestureCollectionView];
    
    [_gestureCollectionView registerClass:[GestureCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellID];
    [_gestureCollectionView registerClass:[GestureCollectionReusableView class]
               forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                      withReuseIdentifier:collectionViewHeadID];
    [_gestureCollectionView registerClass:[GestureCollectionReusableView class]
               forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                      withReuseIdentifier:collectionViewFootID];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_sectionTitlesArr count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_sectionContentsArr[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GestureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeadID forIndexPath:indexPath];
        
        return headerView;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionViewFootID forIndexPath:indexPath];
        
        return footerView;
    }
    else {
        return nil;
    }
}

@end
