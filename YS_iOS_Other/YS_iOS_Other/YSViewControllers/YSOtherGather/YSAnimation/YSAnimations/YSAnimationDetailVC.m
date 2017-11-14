//
//  DemotionVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSAnimationDetailVC.h"
#import "YSAnimationDetailCollectionViewCell.h"
#import "NSString+YSStringDo.h"

static NSString * const YSAnimationDetailCollectionViewCellID = @"YSAnimationDetailCollectionViewCellID";

@interface YSAnimationDetailVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UIImageView * animationView;
@property (nonatomic, strong) UICollectionView * animationCollectionView;

@end

@implementation YSAnimationDetailVC
{
    YSAnimationType _type;
    YSAnimationWay _way;
    
    NSMutableArray * _imagesArr;
    NSMutableArray * _animationArr;
    NSMutableArray * _animationCanClickArr;
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
    [self getImageDataAndSetDefalutBgView];
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setInitData
{
    if (_type == YSAnimationTypeImageKey) {
        _animationArr = [@[@"image帧"] mutableCopy];
        _animationCanClickArr = [@[@(YES)] mutableCopy];
    }
    else if (_type == YSAnimationTypeTurnArounds) {
        _animationArr = [@[@"fade", @"moveIn", @"push", @"reveal", @"cube", @"suck", @"flip", @"ripple", @"curl", @"uncurl", @"cameraOn", @"cameraOff"] mutableCopy];
        
        if (_way == YSAnimationWayUIViewAPI || _way == YSAnimationWayUIViewBlock) {
            _animationCanClickArr = [@[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(YES), @(NO), @(YES), @(YES), @(NO), @(NO)] mutableCopy];
        }
        else if (_way == YSAnimationWayCATransition) {
            _animationCanClickArr = [@[@(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES)] mutableCopy];
        }
    }
    else {
        _animationArr = [@[@"位移", @"缩放", @"2d旋转", @"3d旋转", @"关键帧", @"颜色", @"路径", @"抖动", @"弹簧"] mutableCopy];
        _animationCanClickArr = [@[@(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES)] mutableCopy];
    }
    
    _imagesArr = [NSMutableArray array];
}

- (void)getImageDataAndSetDefalutBgView
{
    for (int i = 1; i <= 4; i++) {
        NSString * imageName = [NSString stringWithFormat:@"test%.2d", i];
        NSString * path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        [_imagesArr addObject:image];
    }
    
    if (_type == YSAnimationTypeImageKey) {
        _bgImageView.image = [_imagesArr firstObject];
        _bgImageView.animationImages = _imagesArr;
        _bgImageView.animationDuration = [_imagesArr count]*0.5;
        _bgImageView.animationRepeatCount = 0;
        
        _animationView.hidden = YES;
    }
    else if (_type == YSAnimationTypeTurnArounds) {
        _bgImageView.image = [_imagesArr firstObject];
        _animationView.hidden = YES;
    }
    else {
        _bgImageView.image = nil;
        _animationView.hidden = NO;
    }
}

- (UIView *)createBgView
{
    _bgImageView = [UIImageView new];
    _bgImageView.backgroundColor = YSDefaultGrayColor;
    _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 180, 0));
    }];
    
    _animationView = [UIImageView new];
    _animationView.image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"5" ofType:@"jpg"]];
    _animationView.hidden = YES;
    [_bgImageView addSubview:_animationView];
    [_animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgImageView);
        make.left.equalTo(_bgImageView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    return _bgImageView;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (kScreenWidth-50)/3;
    flowLayout.itemSize = CGSizeMake(width, 30);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    _animationCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _animationCollectionView.backgroundColor = [UIColor whiteColor];
    _animationCollectionView.delegate = self;
    _animationCollectionView.dataSource = self;
    [self.view addSubview:_animationCollectionView];
    
    [_animationCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom).offset(-180);
        make.height.mas_equalTo(180);
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
    [cell setContent:_animationArr[indexPath.row] canClick:[_animationCanClickArr[indexPath.row] boolValue]];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == YSAnimationTypeImageKey) {
        [self animationImageKey];
    }
    else if (_type == YSAnimationTypeTurnArounds) {
        [self animationTurnAroundsWithIndexPath:indexPath];
    }
    else {
        [self animation2or3DWithIndexPath:indexPath];
    }
}

#pragma mark - 方法
/**
     image 帧动画
 */
- (void)animationImageKey
{
    if (_bgImageView.animating) {
        [_bgImageView stopAnimating];
    }
    else {
        [_bgImageView startAnimating];
    }
}


/**
     2D / 3D动画
 @param indexPath
 */
- (void)animation2or3DWithIndexPath:(NSIndexPath *)indexPath
{
    if (_way == YSAnimationWayDefault) {
        
    }
    else if (_way == YSAnimationWayUIViewAPI) {
        
    }
    else if (_way == YSAnimationWayUIViewBlock) {
        
    }
    else if (_way == YSAnimationWayCABasicAnimation) {
        
    }
    
    switch (indexPath.row) {
        case 0:     // 位移
        {
            if (_way == YSAnimationWayDefault) {
                
            }
            else if (_way == YSAnimationWayUIViewAPI) {
                [self positionByUIViewAPI];
            }
            else if (_way == YSAnimationWayUIViewBlock) {
                [self positionByUIViewBlock];
            }
            else if (_way == YSAnimationWayCABasicAnimation) {
                [self positionByCAAnimation];
            }
        }
            break;
        case 1:     // 缩放
        {
            
        }
            break;
        case 2:     // 2d旋转
        {
            
        }
            break;
        case 3:     // 3d旋转
        {
            
        }
            break;
        case 4:     // 关键帧
        {
            
        }
            break;
        case 5:     // 颜色
        {
            
        }
            break;
        case 6:     // 路径
        {
            
        }
            break;
        case 7:     // 抖动
        {
            
        }
            break;
        case 8:     // 弹簧
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)animationTurnAroundsWithIndexPath:(NSIndexPath *)indexPath
{
    if (_way == YSAnimationWayUIViewAPI) {
        [self turnAroundByUIViewAPIWithIndexPath:indexPath];
    }
    else if (_way == YSAnimationWayUIViewBlock) {
        [self turnAroundByUIViewBlockWithIndexPath:indexPath];
    }
    else if (_way ==  YSAnimationWayCATransition) {
        [self turnAroundByCATransitionWithIndexPath:indexPath];
    }
}

#pragma mark - 位移动画
- (void)positionByDefault
{
    
}

- (void)positionByUIViewAPI
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [_animationView mas_updateConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)positionByUIViewBlock
{
    [UIView animateWithDuration:1.0 animations:^{
        [_animationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgImageView.mas_bottom).offset(-80);
            make.left.equalTo(_bgImageView.mas_right).offset(-80);
        }];
    } completion:^(BOOL finished) {
        [_animationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgImageView);
            make.left.equalTo(_bgImageView);
        }];
    }];
}

- (void)positionByCAAnimation
{
    CABasicAnimation * positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMaxX(_bgImageView.frame)-80, CGRectGetMaxY(_bgImageView.frame)-80)];
    positionAnimation.duration = 1.0f;
    //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    //positionAnimation.fillMode = kCAFillModeForwards;
    //positionAnimation.removedOnCompletion = NO;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_animationView.layer addAnimation:positionAnimation forKey:@"positionAnimationYS"];
}


#pragma mark - 转场动画
- (void)turnAroundByUIViewAPIWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger animationType = indexPath.row;
    UIViewAnimationTransition animationTransition = UIViewAnimationTransitionNone;
    if (animationType == 8) {
        animationTransition = UIViewAnimationTransitionCurlUp;
    }
    else if (animationType == 9) {
        animationTransition = UIViewAnimationTransitionCurlDown;
    }
    else if (animationType == 6) {
        animationTransition = UIViewAnimationTransitionFlipFromLeft;
    }
    
    [UIView setAnimationTransition:animationTransition forView:_bgImageView cache:NO];
}

- (void)turnAroundByUIViewBlockWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger animationType = indexPath.row;
    UIViewAnimationOptions option = UIViewAnimationOptionTransitionNone;
    if (animationType == 6) {
        option = UIViewAnimationOptionTransitionFlipFromTop;
    }
    else if (animationType == 8) {
        option = UIViewAnimationOptionTransitionCurlUp;
    }
    else if (animationType == 9) {
        option = UIViewAnimationOptionTransitionCurlDown;
    }
    
    [UIView transitionWithView:_bgImageView duration:1.0 options:option animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

/**
 CATransition
 */
- (void)turnAroundByCATransitionWithIndexPath:(NSIndexPath *)indexPath
{
    NSString * type = @"";
    NSString * subType = @"";
    
    switch (indexPath.row) {
        case 0:     // fade - 淡入淡出
            type = kCATransitionFade;
            break;
        case 1:     // moveIn - 覆盖
            type = kCATransitionMoveIn;
            break;
        case 2:     // push - 推出
            type = kCATransitionPush;
            break;
        case 3:     // reveal - 揭开
            type = kCATransitionReveal;
            break;
        case 4:     // cube - 立体旋转
            type = @"cube";
            break;
        case 5:     // suck - 飘缩
            type = @"suckEffect";
            break;
        case 6:     // flip - 翻转
            type = @"oglFlip";
            subType = kCATransitionFromTop;
            break;
        case 7:     // ripple - 水滴波纹
            type = @"rippleEffect";
            break;
        case 8:     // curl - 翻页翻过
            type = @"pageCurl";
            subType = kCATransitionFromBottom;
            break;
        case 9:     // uncurl - 翻页翻回
            type = @"pageUnCurl";
            break;
        case 10:     // curl - 相机打开
            type = @"cameraIrisHollowOpen";
            break;
        case 11:     // curl - 相机关闭
            type = @"cameraIrisHollowClose";
            break;
        default:
            type = @"";
            break;
    }
    if (![type isBlank]) {
        CATransition * tran = [CATransition animation];
        tran.type = type;
        if (![subType isBlank]) {
            tran.subtype = subType;
        }
        tran.duration = 1;
        [_bgImageView.layer addAnimation:tran forKey:nil];
    }
}


@end
