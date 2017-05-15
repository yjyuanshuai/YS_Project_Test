//
//  VideoViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "VideoViewController.h"
#import "YSVideoPlayerView.h"

static NSString * YSVideoControlCellID = @"YSVideoControlCellID";

@interface VideoViewController () <UITableViewDelegate, UITableViewDataSource, YSVideoPlayerViewDelegate>

@property (nonatomic, strong) UITableView * videoTableView;

@end

@implementation VideoViewController
{
    BOOL _isLandScape;
    NSMutableArray * _dataTitleArr;
    
    // add by yj
    BOOL _didSavePreviousStateOfNavBar;
    BOOL                _previousNavBarHidden;
    BOOL                _previousNavToolbarHidden;
    UIBarStyle          _previousNavBarStyle;
    UIStatusBarStyle    _previousStatusBarStyle;
    UIColor             *_previousNavBarTintColor;
    UIColor             *_previousNavBarBarTintColor;
    UIBarButtonItem     *_previousViewControllerBackButton;
    UIImage             *_previousNavigationBarBackgroundImageDefault;
    UIImage             *_previousNavigationBarBackgroundImageLandscapePhone;
    
    NSDictionary *_previousNavtitleTextAttributes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createVideoPlayerView];
    [self createTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self storePreviousNavBarAppearance];
//    [self setNavBarAppearance:YES];
    [self.navigationController setNavigationBarHidden:YES];
    if (kSystemVersion <= 9.0) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _isLandScape = NO;
    [[YSVideoPlayerView shareVideoPlayerView] updateVideoPlayerViewWithIsLandScape:NO];
    [self showSmallWindow];
    DDLogInfo(@"------- 关闭横屏");
    
//    [self restorePreviousNavBarAppearance:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    _isLandScape = NO;
    _dataTitleArr = [@[] mutableCopy];
    
    NSArray * sectionOne = @[@"第一行"];
    [_dataTitleArr addObject:sectionOne];
    
    self.view.backgroundColor = [UIColor redColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
}

- (void)createVideoPlayerView
{
    YSVideoPlayerView * playerView = [YSVideoPlayerView shareVideoPlayerView];
    playerView.delegate = self;
    [self.view addSubview:playerView];
}

- (void)createTableView
{
    _videoTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _videoTableView.delegate = self;
    _videoTableView.dataSource = self;
    _videoTableView.tableFooterView = [UIView new];
    [self.view addSubview:_videoTableView];
    
    [_videoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0.75*kScreenWidth, 0, 0, 0));
    }];
    
    [_videoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YSVideoControlCellID];
    _videoTableView.backgroundColor = [UIColor yellowColor];
}

- (BOOL)prefersStatusBarHidden      // 7.0 后生效
{
    return YES;
}

#pragma mark - 旋转屏有关
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (_isLandScape) {
        return UIInterfaceOrientationMaskLandscape;
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataTitleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:YSVideoControlCellID];
    if (indexPath.section < [_dataTitleArr count]) {
        NSArray * sectionArr = _dataTitleArr[indexPath.section];
        if (indexPath.row < [sectionArr count]) {
            cell.textLabel.text = sectionArr[indexPath.row];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - YSVideoPlayerViewDelegate
- (void)clickSpaceBtn
{
    _isLandScape = !_isLandScape;
    [[YSVideoPlayerView shareVideoPlayerView] updateVideoPlayerViewWithIsLandScape:_isLandScape];
    
    if (!_isLandScape) {
        // 缩小
        [self showSmallWindow];
    }
    else {
        // 全屏
        [self showFullWindow];
    }
}

- (void)clickBackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showSmallWindow
{
    [[UIDevice currentDevice]setValue:[NSNumber numberWithInteger:UIDeviceOrientationUnknown]  forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    [UIView animateWithDuration:0.5 animations:^{
        
        [[YSVideoPlayerView shareVideoPlayerView] updateVideoPlayerViewWithFrame:CGRectMake(0, 0, kScreenWidth, 0.75*kScreenWidth)];
        [self.view bringSubviewToFront:[YSVideoPlayerView shareVideoPlayerView]];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showFullWindow
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationUnknown]  forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [[YSVideoPlayerView shareVideoPlayerView] updateVideoPlayerViewWithFrame:self.view.bounds];
        [self.view bringSubviewToFront:[YSVideoPlayerView shareVideoPlayerView]];
        
    } completion:^(BOOL finished) {
        
        
    }];
}

#pragma mark - navigationBar
- (void)storePreviousNavBarAppearance
{
    _didSavePreviousStateOfNavBar = YES;
    
    _previousNavtitleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
    _previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    
    if ([UINavigationBar instancesRespondToSelector:@selector(barTintColor)]) {
        _previousNavBarBarTintColor = self.navigationController.navigationBar.barTintColor;
    }
    
    _previousNavBarTintColor = self.navigationController.navigationBar.tintColor;
    _previousNavBarHidden = self.navigationController.navigationBarHidden;
    _previousNavBarStyle = self.navigationController.navigationBar.barStyle;
    
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
        _previousNavigationBarBackgroundImageDefault = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
        _previousNavigationBarBackgroundImageLandscapePhone = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsCompact];
    }
}

- (void)setNavBarAppearance:(BOOL)animated
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    navBar.tintColor = (kSystemVersion > 7.0) ?[UIColor whiteColor] : nil;
    
    if ([navBar respondsToSelector:@selector(setBarTintColor:)]) {
        navBar.barTintColor = nil;
        navBar.shadowImage = nil;
    }
    
    navBar.barStyle = UIBarStyleDefault;//UIBarStyleBlackTranslucent;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//UIStatusBarStyleLightContent;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0f]};
    
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
        [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    }
}

- (void)restorePreviousNavBarAppearance:(BOOL)animated
{
    if (_didSavePreviousStateOfNavBar) {
        [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle animated:animated];
        
        [self.navigationController setNavigationBarHidden:_previousNavBarHidden animated:animated];
        UINavigationBar *navBar = self.navigationController.navigationBar;
        navBar.tintColor = _previousNavBarTintColor;
        
        if ([UINavigationBar instancesRespondToSelector:@selector(barTintColor)]) {
            navBar.barTintColor = _previousNavBarBarTintColor;
        }
        
        navBar.barStyle = _previousNavBarStyle;
        
        self.navigationController.navigationBar.titleTextAttributes = _previousNavtitleTextAttributes;
        
        if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
            [navBar setBackgroundImage:_previousNavigationBarBackgroundImageDefault forBarMetrics:UIBarMetricsDefault];
            [navBar setBackgroundImage:_previousNavigationBarBackgroundImageLandscapePhone forBarMetrics:UIBarMetricsCompact];
        }
        
        // Restore back button if we need to
        if (_previousViewControllerBackButton) {
            UIViewController *previousViewController = [self.navigationController topViewController]; //
            previousViewController.navigationItem.backBarButtonItem = _previousViewControllerBackButton;
            _previousViewControllerBackButton = nil;
        }
    }
}


@end
