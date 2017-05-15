//
//  YSKeyChainViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSKeyChainViewController.h"
#import "MyKeyChainHelper.h"
#import "NSString+YSStringDo.h"

@interface YSKeyChainViewController ()<UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView * kcScrollView;
@property (nonatomic, strong) UIView * kcContentView;
@property (nonatomic, strong) UITextField * kcNameTf;
@property (nonatomic, strong) UITextField * kcPassWordTf;
@property (nonatomic, strong) UILabel * ysContentLabel;

@end

@implementation YSKeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    
    [self createScrollView];
    [self createScrollViewSubviews];
    [self addContaintToScrollView];
    [self addContaintsToScrollViewSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"keychain";
    
    UIBarButtonItem * readBtn = [[UIBarButtonItem alloc] initWithTitle:@"读取" style:UIBarButtonItemStylePlain target:self action:@selector(clickToSee)];
    UIBarButtonItem * saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickToSave)];
    self.navigationItem.rightBarButtonItems = @[readBtn, saveBtn];
}

- (void)createScrollView
{
    _kcScrollView = [UIScrollView new];
    _kcScrollView.delegate = self;
    _kcScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    _kcScrollView.layer.borderColor = [UIColor redColor].CGColor;
    _kcScrollView.layer.borderWidth = 1.0;
    [self.view addSubview:_kcScrollView];
    
    _kcContentView = [UIView new];
    _kcContentView.backgroundColor = [UIColor orangeColor];
    [_kcScrollView addSubview:_kcContentView];
}

- (void)addContaintToScrollView
{
    _kcScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _kcContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary * metricsDic = @{};
    NSDictionary * viewsDic = @{@"_kcScrollView":_kcScrollView, @"_kcContentView":_kcContentView};
    
    // _kcScrollView
    NSString * scroll_vfl1 = @"H:|-0-[_kcScrollView]-0-|";
    NSString * scroll_vfl2 = @"V:|-0-[_kcScrollView]-0-|";
    
    NSArray * scroll_c1 = [NSLayoutConstraint constraintsWithVisualFormat:scroll_vfl1
                                                                  options:0
                                                                  metrics:metricsDic
                                                                    views:viewsDic];
    
    NSArray * scroll_c2 = [NSLayoutConstraint constraintsWithVisualFormat:scroll_vfl2
                                                                  options:0
                                                                  metrics:metricsDic
                                                                    views:viewsDic];
    [self.view addConstraints:scroll_c1];
    [self.view addConstraints:scroll_c2];
    
    // _kcContentView
    NSString * content_vfl1 = @"H:|-0-[_kcContentView]-0-|";
    NSString * content_vfl2 = @"V:|-0-[_kcContentView]-0-|";
    
    NSArray * content_c1 = [NSLayoutConstraint constraintsWithVisualFormat:content_vfl1
                                                                   options:0
                                                                   metrics:metricsDic
                                                                     views:viewsDic];
    
    NSArray * content_c2 = [NSLayoutConstraint constraintsWithVisualFormat:content_vfl2
                                                                   options:0
                                                                   metrics:metricsDic
                                                                     views:viewsDic];
    
    NSLayoutConstraint * content_c3 = [NSLayoutConstraint constraintWithItem:_kcContentView
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:1.0
                                                                    constant:0];
    [self.view addConstraints:content_c1];
    [self.view addConstraints:content_c2];
    [self.view addConstraint:content_c3];
}

- (void)createScrollViewSubviews
{
    _kcNameTf = [UITextField new];
    _kcNameTf.delegate = self;
    _kcNameTf.placeholder = @"钥匙串-name";
    _kcNameTf.borderStyle = UITextBorderStyleRoundedRect;
    [_kcContentView addSubview:_kcNameTf];
    
    _kcPassWordTf = [UITextField new];
    _kcPassWordTf.delegate = self;
    _kcPassWordTf.placeholder = @"钥匙串-password";
    _kcPassWordTf.borderStyle = UITextBorderStyleRoundedRect;
    [_kcContentView addSubview:_kcPassWordTf];
    
    _ysContentLabel = [UILabel new];
    _ysContentLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _ysContentLabel.layer.borderWidth = 1.0;
    _ysContentLabel.numberOfLines = 0;
    [_kcContentView addSubview:_ysContentLabel];
}

- (void)addContaintsToScrollViewSubView
{
    _kcNameTf.translatesAutoresizingMaskIntoConstraints = NO;
    _kcPassWordTf.translatesAutoresizingMaskIntoConstraints = NO;
    _ysContentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary * metricsDic = @{@"padding_left"   :@10,
                                  @"padding_top"    :@10,
                                  @"tfHeight"       :@40};
    
    NSDictionary * viewsDic = @{@"_kcNameTf"        :_kcNameTf,
                                @"_kcPassWordTf"    :_kcPassWordTf,
                                @"_ysContentLabel"  :_ysContentLabel};
    
    // _kcNameTf
    NSString * name_vfl1 = @"H:|-padding_left-[_kcNameTf]-padding_left-|";
    NSString * name_vfl2 = @"V:|-padding_top-[_kcNameTf(==tfHeight)]";
    
    NSArray * name_c1 = [NSLayoutConstraint constraintsWithVisualFormat:name_vfl1
                                                                options:0
                                                                metrics:metricsDic
                                                                  views:viewsDic];
    NSArray * name_c2 = [NSLayoutConstraint constraintsWithVisualFormat:name_vfl2
                                                                options:0
                                                                metrics:metricsDic
                                                                  views:viewsDic];
    [_kcContentView addConstraints:name_c1];
    [_kcContentView addConstraints:name_c2];
    
    // _kcPassWordTf
    NSString * pass_vfl1 = @"H:|-padding_left-[_kcPassWordTf]-padding_left-|";
    NSString * pass_vfl2 = @"V:[_kcNameTf]-padding_top-[_kcPassWordTf(==tfHeight)]";
    
    NSArray * pass_c1 = [NSLayoutConstraint constraintsWithVisualFormat:pass_vfl1
                                                                options:0
                                                                metrics:metricsDic
                                                                  views:viewsDic];
    NSArray * pass_c2 = [NSLayoutConstraint constraintsWithVisualFormat:pass_vfl2
                                                                options:0
                                                                metrics:metricsDic
                                                                  views:viewsDic];
    [_kcContentView addConstraints:pass_c1];
    [_kcContentView addConstraints:pass_c2];
    
    // _ysContentLabel
    NSString * content_vfl1 = @"H:|-padding_left-[_ysContentLabel]-padding_left-|";
    NSString * content_vfl2 = @"V:[_kcPassWordTf]-padding_top-[_ysContentLabel]-padding_top-|";
    
    NSArray * content_c1 = [NSLayoutConstraint constraintsWithVisualFormat:content_vfl1
                                                                   options:0
                                                                   metrics:metricsDic
                                                                     views:viewsDic];
    NSArray * content_c2 = [NSLayoutConstraint constraintsWithVisualFormat:content_vfl2
                                                                   options:0
                                                                   metrics:metricsDic
                                                                     views:viewsDic];
    [_kcContentView addConstraints:content_c1];
    [_kcContentView addConstraints:content_c2];
}

- (void)clickToSave
{
    NSString * name = @"初始account";
    NSString * password = @"初始password";
    
    [MyKeyChainHelper saveUserName:name
                   userNameService:KeyChainUserAccount
                          psaaword:password
                   psaawordService:KeyChainUserPassword];
}

- (void)clickToSee
{
    NSString * name = [MyKeyChainHelper getUserNameWithService:UserNameKey];
    NSString * password = [MyKeyChainHelper getPasswordWithService:UserPassWordKey];
    
    name = [name isBlank] ? @"" : name;
    password = [password isBlank] ? @"" : password;

    NSString * contentStr = [NSString stringWithFormat:@" 账号：%@\n 密码：%@", name, password];
    
    _ysContentLabel.text = [contentStr analyseBreakLine];
}

@end
