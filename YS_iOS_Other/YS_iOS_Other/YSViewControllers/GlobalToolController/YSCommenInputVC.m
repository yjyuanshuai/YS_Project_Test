//
//  YSCommenInputVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCommenInputVC.h"

@interface YSCommenInputVC ()<UITextViewDelegate>

@end

@implementation YSCommenInputVC
{
    YSInputCallBackBlock _block;
    UITextView * _inputTextView;
}

- (instancetype)initWithTitle:(NSString *)title block:(YSInputCallBackBlock)block
{
    self = [super init];
    if (self) {
        self.title = title;
        _block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _inputTextView = [UITextView new];
    _inputTextView.delegate = self;
    _inputTextView.font = YSFont_Sys(16);
    _inputTextView.layer.borderWidth = 1.0;
    _inputTextView.layer.borderColor = YSDefaultGrayColor.CGColor;
    [self.view addSubview:_inputTextView];

    [_inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(300);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(10);
    }];

    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishedInput)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedInput
{
    if (_block) {
        _block(_inputTextView.text);
    }

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

@end
