//
//  GlobalWebVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/3/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "GlobalWebVC.h"
#import <WebKit/WebKit.h>

@interface GlobalWebVC ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView * webView;

@end

@implementation GlobalWebVC
{
    NSString * _title;
    NSString * _currentUrl;
}

- (instancetype)initWithTitle:(NSString *)title webUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        _title = title;
        _currentUrl = url;
    }
    return self;
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
    self.title = _title;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeightNo64)];
    NSURL * url = [NSURL URLWithString:_currentUrl];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    [self.view addSubview:_webView];
}

#pragma mark - WKUIDelegate
/*
 *  UI界面相关，原生控件支持，三种提示框：输入、确认、警告。首先将web提示框拦截然后再做处理。
 */

/// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{return nil;}
/// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{}
/// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{}
/// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{}


#pragma mark - WKScriptMessageHandler
/*
 *  必须实现的函数，是APP与js交互，提供从网页中收消息的回调方法
 */

// message: 收到的脚本信息.
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{}


#pragma mark - WKNavigationDelegate
/*
 *  最常用，和UIWebViewDelegate功能类似，追踪加载过程，有是否允许加载、开始加载、加载完成、加载失败。下面会对函数做简单的说明，并用数字标出调用的先后次序：1-2-3-4-5
 */


//------------------------ 追踪加载过程的函数 ----------------------//
// 2 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{}
// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{}
// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{}



//------------------------ 是否允许加载的函数 ----------------------//
// 接收到服务器跳转请求之后调用(服务器端redirect)，不一定调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{}
// 3 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{}
// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{}


@end
