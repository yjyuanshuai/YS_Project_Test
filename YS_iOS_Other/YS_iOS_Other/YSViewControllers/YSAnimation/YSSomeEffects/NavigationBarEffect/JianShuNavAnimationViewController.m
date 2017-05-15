//
//  JianShuNavAnimationViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/29.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "JianShuNavAnimationViewController.h"
#import "UIImage+YSImageCategare.h"

static CGFloat maxSize = 100;
static CGFloat minSize = 36;

static NSString * const preNavBarTitleTextAttributes    = @"preNavBarTitleTextAttributes";
static NSString * const preNavBarStyle                  = @"preNavBarStyle";
static NSString * const preNavBarTintColor              = @"preNavBarTintColor";
static NSString * const preNavBarbarTintColor           = @"preNavBarbarTintColor";
static NSString * const preNavBarTranslucent            = @"preNavBarTranslucent";
static NSString * const preNavBarShadowImage            = @"preNavBarShadowImage";
static NSString * const preNavBarBackIndicatorImage     = @"preNavBarBackIndicatorImage";
static NSString * const preNavBarHidden                 = @"preNavBarHidden";
static NSString * const preNavBarBackIndicatorTransitionMaskImage = @"preNavBarBackIndicatorTransitionMaskImage";

@interface JianShuNavAnimationViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * jianshuTableView;
@property (nonatomic, strong) UIImageView * headImageView;

@property (nonatomic, strong) UITableView * effectTableView;

@end

@implementation JianShuNavAnimationViewController
{
    NSArray * _navAnimationArr;
    NSInteger _touchNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self savePreNavigationBar];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _jianshuTableView.delegate = self;
    [self setNavigationBar];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _jianshuTableView.delegate = nil;   // 释放delegate
    [self resetNavigationBar];
}

#pragma mark -
// 存储上一个页面的
- (void)savePreNavigationBar
{
    
}

// 设置当前页面的
- (void)setNavigationBar
{
    
}

// 重置
- (void)resetNavigationBar
{
    
}

#pragma mark -
- (void)initUIAndData
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navAnimationArr = @[@"1-改颜色", @"2-隐藏", @"3-头像缩放"];
    _touchNum = 1;
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"切换效果" style:UIBarButtonItemStylePlain target:self action:@selector(changeEffect)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    headView.backgroundColor = [UIColor orangeColor];
    
    _headImageView = [UIImageView new];
    _headImageView.bounds = CGRectMake(0, 0, 80, 80);
    _headImageView.center = CGPointMake(headView.center.x, 44);
    NSString * path = [[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"];
    _headImageView.image = [UIImage imageWithContentsOfFile:path];
    _headImageView.layer.cornerRadius = 80/2;
    _headImageView.clipsToBounds = YES;
    [headView addSubview:_headImageView];
    
    self.navigationItem.titleView = headView;
}

- (void)initTableView
{
    _jianshuTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _jianshuTableView.delegate = self;
    _jianshuTableView.dataSource = self;
    _jianshuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_jianshuTableView];
    [_jianshuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    UIView * tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    _jianshuTableView.tableHeaderView = tempView;
    tempView.backgroundColor = [UIColor redColor];

    UIImageView * imageView = [UIImageView new];
    [tempView addSubview:imageView];
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"6" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenWidth));
        make.left.equalTo(tempView.mas_left).offset(0);
        make.top.equalTo(tempView.mas_top).offset(0);
    }];
    
    
    _effectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _effectTableView.delegate = self;
    _effectTableView.dataSource = self;
    _effectTableView.hidden = YES;
    _effectTableView.rowHeight = 40;
    _effectTableView.scrollEnabled = NO;
    [self.view addSubview:_effectTableView];
    [_effectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 120));
        make.top.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
    }];
    
    [_effectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"other_cell_id"];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _jianshuTableView) {
        return [_navAnimationArr count]*10;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _jianshuTableView) {
        static NSString * cell_id = @"cell_id";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        }
        if (indexPath.row < 3) {
            cell.textLabel.text = _navAnimationArr[indexPath.row];
        }
        else {
            cell.textLabel.text = @"......";
        }
        return cell;
    }
    else {
        static NSString * cell_id = @"other_cell_id";
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.textLabel.text = [NSString stringWithFormat:@"效果%d", (int)indexPath.row+1];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _effectTableView) {
        
        _touchNum = (int)indexPath.row + 1;
        _effectTableView.hidden = YES;
        [UIView animateWithDuration:0.7 animations:^{
            _jianshuTableView.contentOffset = CGPointZero;
        }];
    }
}

#pragma mark - UIScrollViewDelegate

/**
 *  scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"------------- scrollViewDidScroll");
    
    if (_touchNum == 1) {
        // 颜色
        CGFloat miniAlphaOffset = 0;
        CGFloat maxAlphaOffset = 80;
        CGFloat offset = scrollView.contentOffset.y;
        offset = (offset > maxAlphaOffset) ? maxAlphaOffset : offset;
        CGFloat alpha = (maxAlphaOffset - offset)/(maxAlphaOffset - miniAlphaOffset);
        
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        
    }
    else if (_touchNum == 2) {
        // 隐藏
        CGFloat offsetY = scrollView.contentOffset.y + _jianshuTableView.contentInset.top;
        CGFloat gesureY = [scrollView.panGestureRecognizer translationInView:_jianshuTableView].y;
        
        if (offsetY > 64) {
            if (gesureY > 0) {  //下滑
                [self.navigationController setNavigationBarHidden:NO animated:YES];
                
            } else {
                [self.navigationController setNavigationBarHidden:YES animated:YES];
            }
        } else {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            
        }
    }
    else if (_touchNum == 3) {
        // 缩放
        CGFloat contentY = scrollView.contentOffset.y;
        CGFloat contentInsertTop = scrollView.contentInset.top;
        CGFloat offsetY = contentY + contentInsertTop;
        
//        CGFloat gesureY = [scrollView.panGestureRecognizer translationInView:_jianshuTableView].y;
//        CGFloat headSizeHeight = _headImageView.frame.size.height;
        
//        NSLog(@"---------------------------- headSize: %f +++++++++++++ off: %f", headSizeHeight, offsetY);
        
        
        CGFloat scale = 1.0;
        
        if (offsetY < 0) {
            scale = MIN(maxSize/80, 1 - offsetY/300);      // 放大系数
            
        }
        else if (offsetY > 0) {
            scale = MAX(minSize/80, 1 - offsetY/300);      // 缩小系数
            
        }
        
        _headImageView.transform = CGAffineTransformMakeScale(scale, scale);
        CGRect originFrame = _headImageView.frame;
        originFrame.origin.y = 4;
        _headImageView.frame = originFrame;
    }
}

/**
 *  当scrollView缩放时，调用该方法。在缩放过程中，回多次调用
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    NSLog(@"------------- scrollViewDidZoom");
    float value=scrollView.zoomScale;
    NSLog(@"%f",value);
    
    
}

// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"------------- scrollViewWillBeginDragging");
    
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    NSLog(@"------------- scrollViewWillEndDragging");
    
}

// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    NSLog(@"------------- scrollViewDidEndDragging");
    if (decelerate) {
        NSLog(@"decelerate");
    }else{
        NSLog(@"no decelerate");
        
    }
    
    CGPoint point=scrollView.contentOffset;
    NSLog(@"%f,%f",point.x,point.y);
    
}

// 滑动减速时调用该方法。
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"------------- scrollViewWillBeginDecelerating");
    // 该方法在scrollViewDidEndDragging方法之后。
    
    
}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"------------- scrollViewDidEndDecelerating");
    
}

// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSLog(@"------------- scrollViewDidEndScrollingAnimation");
    // 有效的动画方法为：
    //    - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated 方法
    //    - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated 方法
    
    
}

// 返回将要缩放的UIView对象。要执行多次
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    NSLog(@"------------- viewForZoomingInScrollView");
    return nil;
}

// 当将要开始缩放时，执行该方法。一次有效缩放，就只执行一次。
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
    NSLog(@"------------- scrollViewWillBeginZooming");
    
}

// 当缩放结束后，并且缩放大小回到minimumZoomScale与maximumZoomScale之间后（我们也许会超出缩放范围），调用该方法。
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    
    NSLog(@"------------- scrollViewDidEndZooming");
    
}

// 指示当用户点击状态栏后，滚动视图是否能够滚动到顶部。需要设置滚动视图的属性：_scrollView.scrollsToTop=YES;
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    
    NSLog(@"------------- scrollViewShouldScrollToTop");
    return YES;
    
}

// 当滚动视图滚动到最顶端后，执行该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
    NSLog(@"------------- scrollViewDidScrollToTop");
}

#pragma mark -
- (void)changeEffect
{
    if (_effectTableView.hidden) {
        _effectTableView.hidden = NO;
        [self.view bringSubviewToFront:_effectTableView];
    }
    else {
        _effectTableView.hidden = YES;
    }
}

@end
