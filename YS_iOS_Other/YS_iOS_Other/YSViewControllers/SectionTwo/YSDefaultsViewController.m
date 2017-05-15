//
//  YSDefaultsViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSDefaultsViewController.h"
#import "YSUserDefaults.h"
#import "NSString+YSStringDo.h"

@interface YSDefaultsViewController ()<UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * ysScrollView;
@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) UITextField * ysNameTextFeild;
@property (nonatomic, strong) UITextField * ysPassTextFeild;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, strong) UIButton * saveBtn;
@property (nonatomic, strong) UIButton * readBtn;

@end

@implementation YSDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createScrollView];
    [self addConstraintWithVFL];
    
    [self createScrollViewSubViews];
    [self addSubViewsContaintWithVFL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"偏好设置";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createScrollView
{
    _ysScrollView = [UIScrollView new];
    _ysScrollView.delegate = self;
    _ysScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    _ysScrollView.layer.borderColor = [UIColor redColor].CGColor;
    _ysScrollView.layer.borderWidth = 1;
    [self.view addSubview:_ysScrollView];
    
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor orangeColor];
    [_ysScrollView addSubview:_contentView];
}

- (void)createScrollViewSubViews
{
    _ysNameTextFeild = [UITextField new];
    [_contentView addSubview:_ysNameTextFeild];
    _ysNameTextFeild.placeholder = @"账号";
    _ysNameTextFeild.delegate = self;
    _ysNameTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    /*
     [_ysNameTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
     make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 40));
     make.top.equalTo(self.view).offset(10);
     make.left.equalTo(self.view).offset(10);
     }];
     */
    
    _ysPassTextFeild = [UITextField new];
    [_contentView addSubview:_ysPassTextFeild];
    _ysPassTextFeild.placeholder = @"密码";
    _ysPassTextFeild.delegate = self;
    _ysPassTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    /*
     [_ysPassTextFeild mas_makeConstraints:^(MASConstraintMaker *make) {
     make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 40));
     make.top.mas_equalTo(_ysNameTextFeild.mas_bottom).with.offset(10);
     make.left.equalTo(self.view).offset(10);
     }];
     */
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _saveBtn.layer.borderWidth = 1;
    [_saveBtn setTitle:@"save" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(clickToSave) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_saveBtn];
    /*
     [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
     make.size.mas_equalTo(CGSizeMake(80, 40));
     make.top.mas_equalTo(_ysPassTextFeild.mas_bottom).with.offset(10);
     make.left.equalTo(self.view).offset(10);
     }];
     */
    
    _readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _readBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _readBtn.layer.borderWidth = 1;
    [_readBtn setTitle:@"read" forState:UIControlStateNormal];
    [_readBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_readBtn addTarget:self action:@selector(clickToRead) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_readBtn];
    /*
     [readBtn mas_makeConstraints:^(MASConstraintMaker *make) {
     make.size.mas_equalTo(CGSizeMake(80, 40));
     make.top.mas_equalTo(_ysPassTextFeild.mas_bottom).with.offset(10);
     make.left.mas_equalTo(saveBtn.mas_right).with.offset(kScreenWidth - 20 - 80*2);
     }];
     */
    
    _detailLabel = [UILabel new];
    _detailLabel.numberOfLines = 0;
    _detailLabel.font = [UIFont systemFontOfSize:16.0];
    _detailLabel.layer.borderWidth = 1.0;
    _detailLabel.layer.borderColor = [UIColor blackColor].CGColor;
    [_contentView addSubview:_detailLabel];
    /*
     [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
     make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(CGRectGetMaxY(saveBtn.frame), 10, 10, 10));
     }];
     */
}

- (void)addConstraintWithVFL
{
    _ysScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary * metricsDic = @{};
    NSDictionary * viewsDic = @{@"_ysScrollView":_ysScrollView, @"_contentView":_contentView};
    
    // _ysScrollView
    NSString * scroll_c_vfl1 = @"H:|-0-[_ysScrollView]-0-|";
    NSString * scroll_c_vfl2 = @"V:|-0-[_ysScrollView]-0-|";
    
    NSArray * scroll_c_1 = [NSLayoutConstraint constraintsWithVisualFormat:scroll_c_vfl1
                                                                   options:0
                                                                   metrics:metricsDic
                                                                     views:viewsDic];
    
    NSArray * scroll_c_2 = [NSLayoutConstraint constraintsWithVisualFormat:scroll_c_vfl2
                                                                   options:0
                                                                   metrics:metricsDic
                                                                     views:viewsDic];
    [self.view addConstraints:scroll_c_1];
    [self.view addConstraints:scroll_c_2];
    
    
    // _contentView
    NSString * content_c_vfl1 = @"V:|-(0)-[_contentView]-(0)-|";
    NSString * content_c_vfl2 = @"H:|-(0)-[_contentView]-(0)-|";
    
    NSArray * content_c_1 = [NSLayoutConstraint constraintsWithVisualFormat:content_c_vfl1
                                                                    options:0
                                                                    metrics:metricsDic
                                                                      views:viewsDic];
    
    NSArray * content_c_2 = [NSLayoutConstraint constraintsWithVisualFormat:content_c_vfl2
                                                                    options:0
                                                                    metrics:metricsDic
                                                                      views:viewsDic];
    
    NSLayoutConstraint * content_c_3 = [NSLayoutConstraint constraintWithItem:_contentView
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeWidth
                                                                   multiplier:1.0
                                                                     constant:0];
    [self.view addConstraints:content_c_1];
    [self.view addConstraints:content_c_2];
    [self.view addConstraint:content_c_3];  // 注意！！！必须是 self.view
}

- (void)addSubViewsContaintWithVFL
{
    _ysNameTextFeild.translatesAutoresizingMaskIntoConstraints = NO;
    _ysPassTextFeild.translatesAutoresizingMaskIntoConstraints = NO;
    _saveBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _readBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary * metricsDic = @{@"leftDis":@10,
                                  @"rightDis":@10,
                                  @"topDis":@10,
                                  @"textFeildH":@40,
                                  @"textFeildSpace":@10,
                                  @"tFWithBtnSpace": @10,
                                  @"btnSpace":@80,
                                  @"btnHeight":@40,
                                  @"btnWithLabel":@10,
                                  @"bottemDis":@10};
    
    NSDictionary * viewsDic = @{@"_ysNameTextFeild":_ysNameTextFeild,
                                @"_ysPassTextFeild":_ysPassTextFeild,
                                @"_saveBtn":_saveBtn,
                                @"_readBtn":_readBtn,
                                @"_detailLabel":_detailLabel};
    
    // _ysNameTextFeild
    NSString * name_c_vfl1 = @"H:|-leftDis-[_ysNameTextFeild]-rightDis-|";
    NSString * name_c_vfl2 = @"V:|-topDis-[_ysNameTextFeild(==textFeildH)]";
    
    NSArray * name_c_1 = [NSLayoutConstraint constraintsWithVisualFormat:name_c_vfl1
                                                                 options:0
                                                                 metrics:metricsDic
                                                                   views:viewsDic];
    
    NSArray * name_c_2 = [NSLayoutConstraint constraintsWithVisualFormat:name_c_vfl2
                                                                 options:0
                                                                 metrics:metricsDic
                                                                   views:viewsDic];
    [_contentView addConstraints:name_c_1];
    [_contentView addConstraints:name_c_2];
    
    
    // _ysPassTextFeild
    NSString * pass_c_vfl1 = @"V:[_ysNameTextFeild]-textFeildSpace-[_ysPassTextFeild(==_ysNameTextFeild)]";
    NSString * pass_c_vfl2 = @"H:|-leftDis-[_ysPassTextFeild]-rightDis-|";
    
    NSArray * pass_c_1 = [NSLayoutConstraint constraintsWithVisualFormat:pass_c_vfl1
                                                                 options:0
                                                                 metrics:metricsDic
                                                                   views:viewsDic];
    
    NSArray * pass_c_2 = [NSLayoutConstraint constraintsWithVisualFormat:pass_c_vfl2
                                                                 options:0
                                                                 metrics:metricsDic
                                                                   views:viewsDic];
    [_contentView addConstraints:pass_c_1];
    [_contentView addConstraints:pass_c_2];
    
    
    // saveBtn
    NSString * saveBtn_c_vfl1 = @"V:[_ysPassTextFeild]-tFWithBtnSpace-[_saveBtn(==btnHeight)]";
    
    NSArray * saveBtn_c_1 = [NSLayoutConstraint constraintsWithVisualFormat:saveBtn_c_vfl1
                                                                    options:0
                                                                    metrics:metricsDic
                                                                      views:viewsDic];
    // readBtn
    NSString * readBtn_c_vfl1 = @"V:[_ysPassTextFeild]-tFWithBtnSpace-[_readBtn(==_saveBtn)]";
    
    NSArray * readBtn_c_1 = [NSLayoutConstraint constraintsWithVisualFormat:readBtn_c_vfl1
                                                                    options:0
                                                                    metrics:metricsDic
                                                                      views:viewsDic];
    
    // btn
    NSString * btn_c_vfl1 = @"H:|-leftDis-[_saveBtn]-btnSpace-[_readBtn(==_saveBtn)]-rightDis-|";
    
    NSArray * btn_c_1 = [NSLayoutConstraint constraintsWithVisualFormat:btn_c_vfl1
                                                                options:0
                                                                metrics:metricsDic
                                                                  views:viewsDic];
    
    [_contentView addConstraints:saveBtn_c_1];
    [_contentView addConstraints:readBtn_c_1];
    [_contentView addConstraints:btn_c_1];
    
    
    // _detailLabel
    NSString * detail_c_vfl1 = @"V:[_saveBtn]-btnWithLabel-[_detailLabel]-bottemDis-|";
    NSString * detail_c_vfl2 = @"H:|-leftDis-[_detailLabel]-rightDis-|";
    
    NSArray * detail_c_1 = [NSLayoutConstraint constraintsWithVisualFormat:detail_c_vfl1
                                                                   options:0
                                                                   metrics:metricsDic
                                                                     views:viewsDic];
    
    NSArray * detail_c_2 = [NSLayoutConstraint constraintsWithVisualFormat:detail_c_vfl2
                                                                   options:0
                                                                   metrics:metricsDic
                                                                     views:viewsDic];
    [_contentView addConstraints:detail_c_1];
    [_contentView addConstraints:detail_c_2];
}

- (void)clickToSave
{
    [self.view endEditing:YES];
    
    YSUserDefaults * ysdefault = [YSUserDefaults shareUserDefualts];
    ysdefault.userName = _ysNameTextFeild.text;
    ysdefault.passWord = _ysPassTextFeild.text;
    [ysdefault saveUserDefaults];
}

- (void)clickToRead
{
    [self.view endEditing:YES];
    
    YSUserDefaults * ysdefault = [YSUserDefaults shareUserDefualts];
    [ysdefault readUserDefaults];
    NSMutableString * tempStr = [NSMutableString string];
    [tempStr appendFormat:@" userName: %@\n password: %@", ysdefault.userName, ysdefault.passWord];
    
    _detailLabel.text = [tempStr analyseBreakLine];
}

@end
