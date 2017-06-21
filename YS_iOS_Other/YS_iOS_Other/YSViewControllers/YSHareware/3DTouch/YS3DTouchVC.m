//
//  YS3DTouchVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/21.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YS3DTouchVC.h"

@interface YS3DTouchVC()

@property (nonatomic, strong) UILabel * infoLabel;
@property (nonatomic, strong) UIButton * changeItemBtn;

@end

@implementation YS3DTouchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUIAndData];
}

- (void)initUIAndData
{
    self.title = @"3D Touch";

    _infoLabel = [UILabel new];
    _infoLabel.font = YSFont_Sys(16);
    _infoLabel.text = @"place hold";
    [self.view addSubview:_infoLabel];

    _changeItemBtn = [UIButton new];
    _changeItemBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _changeItemBtn.layer.borderWidth = 1;
    [_changeItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_changeItemBtn setTitle:@"change short item" forState:UIControlStateNormal];
    [_changeItemBtn addTarget:self action:@selector(setDynamicTouchShortItems) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeItemBtn];

    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];

    [_changeItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_infoLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
}

- (void)setDynamicTouchShortItems
{
    NSArray * hasExitstShortItems = [[UIApplication sharedApplication] shortcutItems];
    UIApplicationShortcutItem * changeShortItem = [hasExitstShortItems objectAtIndex:0];

    NSMutableArray * updateShortItems = [hasExitstShortItems mutableCopy];
    UIMutableApplicationShortcutItem * updateShortItem = [changeShortItem mutableCopy];
    updateShortItem.localizedTitle = @"has changed item";
    updateShortItem.localizedSubtitle = nil;
    UIApplicationShortcutIcon * iconType = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    updateShortItem.icon = iconType;

    [updateShortItems replaceObjectAtIndex:0 withObject:updateShortItem];

    [[UIApplication sharedApplication] setShortcutItems:updateShortItems];

    dispatch_async(dispatch_get_main_queue(), ^{
        _infoLabel.text = @"changed!";
        _changeItemBtn.userInteractionEnabled = NO;
    });
}

@end
