//
//  YSTabBarController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSTabBarController.h"

#import "YSNavController.h"
#import "ViewController.h"
#import "YSSaveDataViewController.h"
#import "YSLanguageViewController.h"
#import "YSWebViewController.h"
#import "YSOtherGatherVC.h"

NSInteger const TabBarTag = 20160715;

@interface YSTabBarController ()

@property (nonatomic, strong) NSArray * tabbarItemTitles;
@property (nonatomic, strong) NSArray * navItemTitles;

@property (nonatomic, strong) YSNavController * languageNavCon;
@property (nonatomic, strong) YSNavController * uiNavCon;
@property (nonatomic, strong) YSNavController * saveDataNavCon;
@property (nonatomic, strong) YSNavController * webNavCon;
@property (nonatomic, strong) YSNavController * otherNavCon;

@end

@implementation YSTabBarController

+ (instancetype)sharedYSTabBarController
{
    static YSTabBarController * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSTabBarController alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self createViewController];
    [self setTabbarItemTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    _tabbarItemTitles = @[@"语言", @"UI", @"存储", @"网络", @"硬件", @"其他"];
    _navItemTitles = @[@"语言有关", @"UI有关", @"存储有关", @"网络有关", @"硬件有关", @"其他有关"];
}

- (void)createViewController
{
    YSLanguageViewController * languageVC = [[YSLanguageViewController alloc] init];
    languageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[0]
                                                          image:[self deleteMaskImage:@"tab_thr_num"]
                                                  selectedImage:[UIImage imageNamed:@"tab_thr_sel"]];
    languageVC.tabBarItem.title = _tabbarItemTitles[0];
    _languageNavCon = [[YSNavController alloc] initWithRootViewController:languageVC];
    _languageNavCon.navigationItem.title = _navItemTitles[0];
    
    ViewController * uiVC = [[ViewController alloc] init];
    uiVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[1]
                                                    image:[self deleteMaskImage:@"tab_one_num"]
                                            selectedImage:[UIImage imageNamed:@"tab_one_sel"]];
    uiVC.tabBarItem.title = _tabbarItemTitles[1];
    _uiNavCon = [[YSNavController alloc] initWithRootViewController:uiVC];
    _uiNavCon.navigationItem.title = _navItemTitles[1];
    
    YSSaveDataViewController * savedataVC = [[YSSaveDataViewController alloc] init];
    savedataVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[2]
                                                          image:[self deleteMaskImage:@"tab_two_num"]
                                                  selectedImage:[UIImage imageNamed:@"tab_two_sel"]];
    savedataVC.tabBarItem.title = _tabbarItemTitles[2];
    _saveDataNavCon = [[YSNavController alloc] initWithRootViewController:savedataVC];
    _saveDataNavCon.navigationItem.title = _navItemTitles[2];
    
    YSWebViewController * webVC = [[YSWebViewController alloc] init];
    webVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[3]
                                                     image:[self deleteMaskImage:@"tab_fou_num"]
                                             selectedImage:[UIImage imageNamed:@"tab_fou_sel"]];
    webVC.tabBarItem.title = _tabbarItemTitles[3];
    _webNavCon = [[YSNavController alloc] initWithRootViewController:webVC];
    _webNavCon.navigationItem.title = _navItemTitles[3];
    
    YSOtherGatherVC * otherVC = [[YSOtherGatherVC alloc] init];
    otherVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:_tabbarItemTitles[5]
                                                       image:[self deleteMaskImage:@"tab_six_num"]
                                               selectedImage:[UIImage imageNamed:@"tab_six_sel"]];
    otherVC.tabBarItem.title = _tabbarItemTitles[5];
    _otherNavCon = [[YSNavController alloc] initWithRootViewController:otherVC];
    _otherNavCon.navigationItem.title = _navItemTitles[5];
    
    self.viewControllers = @[_languageNavCon, _uiNavCon, _saveDataNavCon, _webNavCon, _otherNavCon];
}

- (void)setTabbarItemTitle
{
    NSArray * tabBarItems = self.tabBar.items;
    for (int i = 0; i < [tabBarItems count]; i++) {
        UITabBarItem * item = tabBarItems[i];
        item.title = _tabbarItemTitles[i];
    }
}

- (UIImage *)deleteMaskImage:(NSString *)orgImageStr
{
    UIImage * orgImage = [UIImage imageNamed:orgImageStr];
    UIImage * retImage = [orgImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return retImage;
}

#pragma mark - 
- (BOOL)shouldAutorotate
{
    return [[self.viewControllers objectAtIndex:(int)self.selectedIndex] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self.viewControllers objectAtIndex:(int)self.selectedIndex] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers objectAtIndex:(int)self.selectedIndex] preferredInterfaceOrientationForPresentation];
}

@end
