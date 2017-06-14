//
//  YSMenuControllerVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/6/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSMenuControllerVC.h"
#import "YSMenuLabel.h"
#import "YSMenuButton.h"
#import "YSMenuTextView.h"

@interface YSMenuControllerVC ()<UITextViewDelegate, YSMenuLabelDelegate>

@property (nonatomic, strong) YSMenuLabel * menuLabel;
@property (nonatomic, strong) YSMenuButton * menuBtn;
@property (nonatomic, strong) YSMenuTextView * menuTextView;
@property (nonatomic, strong) UIWebView * menuWebView;

@end

@implementation YSMenuControllerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initUIAndData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUIAndData
{
    self.title = @"Menu Controller";

    // Lable
    _menuLabel = [[YSMenuLabel alloc] initWithFrame:CGRectMake(10, 10, 150, 50)];
    _menuLabel.text = @"长按label显示Menu";
    _menuLabel.font = YSFont_Sys(15);
    _menuLabel.textAlignment = NSTextAlignmentCenter;
    _menuLabel.delegate = self;
    _menuLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_menuLabel];

    // Button
    _menuBtn = [[YSMenuButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_menuLabel.frame) + 10, 10, kScreenWidth - CGRectGetMaxX(_menuLabel.frame) - 20, 50)];
    [_menuBtn setTitle:@"按钮" forState:UIControlStateNormal];
//    [_menuBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    _menuBtn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_menuBtn];

    // TextView
    _menuTextView = [[YSMenuTextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_menuLabel.frame) + 20, kScreenWidth - 20, 80)];
    _menuTextView.delegate = self;
    _menuTextView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_menuTextView];

    // TextFeild
    

    // WebView
    _menuWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_menuTextView.frame) + 10, kScreenWidth - 20, kScreenHeightNo113 - 10 - CGRectGetMaxY(_menuTextView.frame))];
    _menuWebView.layer.borderWidth = 1;
    _menuWebView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_menuWebView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
}

- (void)KeyboardWillShow
{
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    [[UIMenuController sharedMenuController] setMenuItems:nil];
}

- (void)MenuControllerWillHide
{
    [[UIMenuController sharedMenuController] setMenuItems:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

//- (void)clickBtn
//{
//    if ([_menuTextView isFirstResponder]) {
//
//        _menuTextView.overrideNext = _menuBtn;
//
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillHide) name:UIMenuControllerWillHideMenuNotification object:nil];
//    }
//    else {
//        [_menuBtn becomeFirstResponder];
//    }
//
//    UIMenuController * menu = [UIMenuController sharedMenuController];
//    UIMenuItem * menuItem = [[UIMenuItem alloc] initWithTitle:@"自定义" action:@selector(custemItem:)];
//    [menu setMenuItems:@[menuItem]];
//    [menu setTargetRect:_menuBtn.frame inView:_menuBtn];
//    [menu setMenuVisible:YES animated:YES];
//    [menu update];
//}

#pragma mark - YSMenuLabelDelegate
- (void)showMenu
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MenuControllerWillHide) name:UIMenuControllerWillHideMenuNotification object:nil];
}

#pragma mark - UITextViewDelegate


@end
