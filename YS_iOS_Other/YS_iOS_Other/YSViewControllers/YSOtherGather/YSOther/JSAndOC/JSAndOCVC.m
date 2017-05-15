//
//  JSAndOCVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "JSAndOCVC.h"
#import "YSHudView.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface JSAndOCVC () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * jsWebView;

@end

@implementation JSAndOCVC
{
    NSString * _titleStr;
    MethodType _methodType;
}

- (instancetype)initWithMethodType:(MethodType)type title:(NSString *)titleStr
{
    if (self = [super init]) {
        _methodType = type;
        _titleStr = titleStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = _titleStr;
    
    if (_methodType == MethodTypeOCToJSString || _methodType == MethodTypeOCToJSJavaScriptCore) {
        
        UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"调JS" style:UIBarButtonItemStylePlain target:self action:@selector(clickRight)];
        self.navigationItem.rightBarButtonItem = rightBtn;
    }
}

- (void)createWebView
{
    _jsWebView = [UIWebView new];
    _jsWebView.delegate = self;
    [self.view addSubview:_jsWebView];
    
    [_jsWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    switch (_methodType) {
        case MethodTypeJSToOCIntercept:
        case MethodTypeOCToJSString:
        {
            NSString * path = [[NSBundle mainBundle] pathForResource:@"jsandoc" ofType:@"html"];
            NSURL * url = [NSURL URLWithString:path];
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            [_jsWebView loadRequest:request];
            
        }
            break;
        case MethodTypeJSToOCJavaScriptCore:
        case MethodTypeOCToJSJavaScriptCore:
        {
            NSString * path = [[NSBundle mainBundle] pathForResource:@"jsandoc2" ofType:@"html"];
            NSURL * url = [NSURL URLWithString:path];
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            [_jsWebView loadRequest:request];
        }
            break;

        default:
            break;
    }
}

- (void)clickRight
{
    if (_methodType == MethodTypeOCToJSString) {
        NSString * jsStr = [NSString stringWithFormat:@"showAlert('%@')",@"这里是JS中alert弹出的message"];
        [_jsWebView stringByEvaluatingJavaScriptFromString:jsStr];

    }
    else if (_methodType == MethodTypeOCToJSJavaScriptCore) {
        
        JSContext *context = [_jsWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        NSString *textJS = @"showAlert('这里是JS中alert弹出的message')";
        [context evaluateScript:textJS];
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (_methodType == MethodTypeJSToOCIntercept) {
        
        /*******************************
         
         1. JS中的firstClick,在拦截到的url scheme全都被转化为小写。
         2. html中需要设置编码，否则中文参数可能会出现编码问题。
         3. JS用打开一个iFrame的方式替代直接用document.location的方式，以避免多次请求，被替换覆盖的问题。
         
         *******************************/
        
        
        NSURL * url = [request URL];
        if ([[url scheme] isEqualToString:@"firstclick"]) {
            NSArray * params = [url.query componentsSeparatedByString:@"&"];
            
            NSMutableDictionary * tempDic = [NSMutableDictionary dictionary];
            for (NSString * paramStr in params) {
                NSArray * dicArr = [paramStr componentsSeparatedByString:@"="];
                if (dicArr.count > 1) {
                    NSString * decodeValue = [dicArr[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [tempDic setObject:decodeValue forKey:dicArr[0]];
                }
            }
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:_titleStr message:@"OC原生对话框" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertView show];
            
            return NO;
        }

    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (_methodType == MethodTypeJSToOCJavaScriptCore) {
        
        /******************************
         
         1、导入库 <JavaScriptCore/JavaScriptCore.h>
         2、获取 JS 上下文
         3、再然后定义好JS需要调用的方法，例如JS要调用share方法。则可以在UIWebView加载url完成后（webViewDidFinishLoad），在其代理方法中添加要调用的share方法：
         
         
         注：可能最新版本的iOS系统做了改动，现在（iOS9，Xcode 7.3，去年使用Xcode 6 和iOS 8没有线程问题）中测试,block中是在子线程，因此执行UI操作，控制台有警告，需要回到主线程再操作UI。
         
         ******************************/
        
        JSContext * context = [_jsWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        //定义好JS要调用的方法, share就是调用的share方法名
        context[@"share"] = ^(){
            
            DDLogInfo(@"-------End start-------");
            
            NSArray *args = [JSContext currentArguments];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式二" message:@"OC原生对话框" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
                [alertView show];
            });
            for (JSValue *jsVal in args) {
                NSLog(@"-------%@", jsVal.toString);
            }
            
            DDLogInfo(@"-------End Log-------");
        };
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [YSHudView yiBaoHUDStopOrShowWithMsg:@"加载出错！" finsh:nil];
    DDLogInfo(@"---------------- didFailLoadWithError: %@", error.localizedDescription);
}

@end
