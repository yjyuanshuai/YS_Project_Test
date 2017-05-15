//
//  AppDelegate.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AppDelegate.h"
#import "YSTabBarController.h"
#import "YSDDLogManager.h"
#import "AudioPlayerVC.h"
#import "YSTestDataBase.h"
#import "YSVideoPlayerView.h"
#import "YSEnDecryptionMethod.h"
#import "YSNavController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - 启动阶段
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // app 启动完成时调用
    
    [self initSetting];
    [self login];
    [self startBaiduMap];
    [self notificationApplyToUser];
    
    
    return YES;
}

#pragma mark - 切换到前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // 重新获取焦点(能够和用户交互)
    
    //此时程序已经回到前台，如果需要的话可以让视频继续播放，让UI切换到播放的状态，如果不需要可以什么都不做
    [[NSNotificationCenter defaultCenter] postNotificationName:BackgroundOperation object:@"didBecomeActive"];
}

#pragma mark - 切换到后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // app 进入后台时调用
    // 所以要设置后台继续运行，则在这个函数里面设置即可
    // 使用这个方法来释放共享资源，保存用户数据，废止定时器，并存储足够的应用程序状态信息的情况下被终止后，将应用程序恢复到目前的状态。
    //如果你的应用程序支持后台运行，这种方法被调用
    
    
    //程序进入后台后, 为了让音乐继续播放, 在此方法里创建该代理播放页, 并指定它播放器的代理
    AudioPlayerVC *player = [AudioPlayerVC defaultAudioVC];
    player.ysAudioPlayer.delegate = player;
}

#pragma mark - 切换到非活动状态
- (void)applicationWillResignActive:(UIApplication *)application {
    
    // 即将失去活动状态的时候调用(失去焦点, 不可交互)
    // 这可导致产生某些类型的临时中断（如传入电话呼叫或SMS消息），或者当用户退出应用程序，它开始过渡到的背景状态。
    // 使用此方法暂停正在进行的任务，禁用定时器，踩下油门， OpenGL ES的帧速率。游戏应该使用这种方法来暂停游戏。
    
    //这里可以用通知中心的方式，通知视频播放的界面将UI更新为暂停的状态（视频会自动暂停）
    [[NSNotificationCenter defaultCenter] postNotificationName:BackgroundOperation object:@"willResignActive"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // 应用程序即将进入前台的时候调用
    // 一般在该方法中恢复应用程序的数据,以及状态
    
}

#pragma mark - 终止状态
- (void)applicationWillTerminate:(UIApplication *)application {
    
    // 应用程序即将被销毁的时候会调用该方法
    // 注意：如果应用程序处于挂起状态的时候无法调用该方法
    // 通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值（自动设置）。
}

#pragma mark - --------------------------------------------------------
#pragma mark - UIApplicationDelegate其他方法
/**
 *  内存不足
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 应用程序接收到内存警告的时候就会调用
    // 一般在该方法中释放掉不需要的内存
}

- (void)applicationSignificantTimeChange:(UIApplication*)application
{
    // 当系统时间发生改变时执行
}

- (void)applicationDidFinishLaunching:(UIApplication*)application
{
    // 当程序载入后执行
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
    // 当StatusBar框将要变化时执行
}

- (void)application:(UIApplication*)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
    // 当StatusBar框方向将要变化时执行
}

- (void)application:(UIApplication*)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    // 当StatusBar框方向变化完成后执行
}

- (void)application:(UIApplication*)application didChangeSetStatusBarFrame:(CGRect)oldStatusBarFrame
{
    // 当StatusBar框变化完成后执行
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    // 当通过url执行
    return YES;
}

#pragma mark -
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /**
     *  客户端注册远程通知时，成功后回调这个方法。
     *  客户端把deviceToken取出来发给服务端，push消息的时候要用。
     *
     *  @param application 应用
     *  @param deviceToken 设备token
     */
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    /**
     *  调用完registerUserNotificationSettings:方法之后执行
     *  即调用startToGetPushToken获取权限后调用
     *
     *  @param application          应用
     *  @param notificationSettings 通知方式
     */
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    /**
     *  接收本地通知的时候调用此方法
     *  当应用收到本地通知时会调这个方法，同上面一个方法类似。
     *  如果在前台运行状态直接调用，如果在后台状态，点击通知启动时，也会回调这个方法
     *  本地通知可见另一篇文章：http://bluevt.org/?p=70
     *
     *  @param application  应用
     *  @param notification 本地通知
     */
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    /**
     *  接收远程通知的时候调用此方法
     *  当应用在前台运行中，收到远程通知时，会回调这个方法。
     *   当应用在后台状态时，点击push消息启动应用，也会回调这个方法。
     *
     *  @param application 应用
     *  @param userInfo    通知信息
     */
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    /**
     *   当客户端注册远程通知时
     *   如果失败了，会回调这个方法。可以从error参数中看一下失败原因。
     *
     *  @param application 应用
     *  @param error       错误
     */
}

#pragma mark -
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([YSVideoPlayerView shareVideoPlayerView].isLandScape) {
        return UIInterfaceOrientationMaskAll;
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    /**
     *  有一点要特别注意，你不能阻止其他应用通过自定义 URL scheme 调用你的应用，然而你可以跳过后续的操作并返回 NO，就像下面的代码那样。也就是说，如果你想阻止其它应用调用你的应用，创建一个与众不同的 URL scheme。尽管这不能保证你的应用不会被调用，但至少大大降低了这种可能性
     */
    
    // 自定义了 URL scheme，另一个应用通过 url 向本应用传递参数 或 发起调用
    
    if ([sourceApplication isEqualToString:@"com.3Sixty.CallCustomURL"])
    {
        // 限定只有某一个应用可以传参
        
        NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
        NSLog(@"URL scheme:%@", [url scheme]);
        NSLog(@"URL query: %@", [url query]);
        
        return YES;
    }
    else 
        return NO;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return YES;
}

#pragma mark - -----------------------------------
#pragma mark - 自定义的
/**
 *  初始设置
 */
- (void)initSetting
{
    self.window.frame = [[UIScreen mainScreen] bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 导航栏
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:YSColorDefault];

    // TabBar
    [UITabBar appearance].tintColor = [UIColor whiteColor];
    [UITabBar appearance].barTintColor = YSColorDefault;
    
    // TabBarItem
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    
}

/**
 *  登录逻辑
 */
- (void)login
{
    // 创建数据库
    [YSTestDataBase initDB];
    
    // 日志
    [YSDDLogManager shareDDLogManager];
    
    // 热修复
    
    BOOL hasLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:HasLogin] boolValue];
    if (hasLogin) {
        YSTabBarController * ysTabBarCon = [YSTabBarController sharedYSTabBarController];
        ysTabBarCon.selectedIndex = 0;
        self.window.rootViewController = ysTabBarCon;
    }
    else {
        YSNavController * loginNav = [YSNavController sharedYSTabBarController];
        [loginNav saveAccountOrPassWord];
        self.window.rootViewController = loginNav;
    }
}

/**
 *  百度地图
 */
- (void)startBaiduMap
{
    // 启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设置 generalDelegate
    BOOL ret = [_mapManager start:kBaiduMapAK generalDelegate:nil];
    if (!ret) {
        NSLog(@"Baidu Map Manager start failed!");
    }
}

/**
 *  程序启动时，向用户获取发通知的权限
 */
- (void)notificationApplyToUser
{
    if (kSystemVersion >= 8.0) {
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

/**
 *  注册远程通知
 */
- (void)registRemoteNotification
{
    UIRemoteNotificationType t = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:t];
}

@end
