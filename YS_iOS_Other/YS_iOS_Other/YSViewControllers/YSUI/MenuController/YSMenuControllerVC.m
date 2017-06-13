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

    _menuLabel = [[YSMenuLabel alloc] initWithFrame:CGRectMake(10, 10, 150, 50)];
    _menuLabel.text = @"长按label显示Menu";
    _menuLabel.font = YSFont_Sys(15);
    _menuLabel.textAlignment = NSTextAlignmentCenter;
    _menuLabel.delegate = self;
    _menuLabel.backgroundColor = [UIColor greenColor];
    UILongPressGestureRecognizer * longGesure = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickLongGesure)];
    [_menuLabel addGestureRecognizer:longGesure];
    [self.view addSubview:_menuLabel];

    _menuBtn = [[YSMenuButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_menuLabel.frame) + 10, 10, kScreenWidth - CGRectGetMaxX(_menuLabel.frame) - 20, 50)];
    [_menuBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [_menuBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    _menuBtn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_menuBtn];

    _menuTextView = [[YSMenuTextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_menuLabel.frame) + 50, kScreenWidth - 20, kScreenHeightNo113 - CGRectGetMaxY(_menuLabel.frame) - 50 - 20)];
    _menuTextView.delegate = self;
    _menuTextView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_menuTextView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
}

- (void)KeyboardWillShow
{
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)menuControllerWillHide
{
    _menuTextView.overrideNext = nil;
    [[UIMenuController sharedMenuController] setMenuItems:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)clickLongGesure
{
    if ([_menuTextView isFirstResponder]) {

        _menuTextView.overrideNext = _menuLabel;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillHide) name:UIMenuControllerWillHideMenuNotification object:nil];
    }
    else {
        [_menuLabel becomeFirstResponder];
    }

    UIMenuController * menu = [UIMenuController sharedMenuController];
    UIMenuItem * menuItem = [[UIMenuItem alloc] initWithTitle:@"自定义" action:@selector(custemItem:)];
    [menu setMenuItems:@[menuItem]];
    [menu setTargetRect:_menuLabel.frame inView:_menuLabel];
    [menu setMenuVisible:YES animated:YES];
    [menu update];

}

- (void)clickBtn
{
    if ([_menuTextView isFirstResponder]) {

        _menuTextView.overrideNext = _menuBtn;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillHide) name:UIMenuControllerWillHideMenuNotification object:nil];
    }
    else {
        [_menuBtn becomeFirstResponder];
    }

    UIMenuController * menu = [UIMenuController sharedMenuController];
    UIMenuItem * menuItem = [[UIMenuItem alloc] initWithTitle:@"自定义" action:@selector(custemItem:)];
    [menu setMenuItems:@[menuItem]];
    [menu setTargetRect:_menuBtn.frame inView:_menuBtn];
    [menu setMenuVisible:YES animated:YES];
    [menu update];
}

- (void)custemItem:(id)sender
{
    DDLogInfo(@"-------- 点击了菜单事件");
}

#pragma mark - YSMenuLabelDelegate
- (void)showMenu
{
    if ([_menuTextView isFirstResponder]) {

        _menuTextView.overrideNext = _menuLabel;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillHide) name:UIMenuControllerWillHideMenuNotification object:nil];
    }
    else {
        [_menuLabel becomeFirstResponder];
    }
}

#pragma mark - UITextViewDelegate


@end
