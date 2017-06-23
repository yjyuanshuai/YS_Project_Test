//
//  YS3DTouchVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/21.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YS3DTouchVC.h"
#import "YS3DTouchPeekVC.h"
#import <SafariServices/SFSafariViewController.h>

@interface YS3DTouchVC()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UILabel * infoLabel;
@property (nonatomic, strong) UIButton * changeItemBtn;
@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation YS3DTouchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUIAndData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self regist];
}

- (void)initUIAndData
{
    self.title = @"3D Touch";

    _infoLabel = [UILabel new];
    _infoLabel.font = YSFont_Sys(16);
    _infoLabel.text = @"place hold";
    [self.view addSubview:_infoLabel];

    _changeItemBtn = [UIButton new];
    [_changeItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_changeItemBtn setTitle:@"change short item" forState:UIControlStateNormal];
    [_changeItemBtn addTarget:self action:@selector(setDynamicTouchShortItems) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeItemBtn];

    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"test01"];
    [self.view addSubview:_imageView];

    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];

    [_changeItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_infoLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];

    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 280));
        make.centerX.equalTo(self.view);
        make.top.equalTo(_changeItemBtn.mas_bottom).offset(40);
    }];

    _infoLabel.backgroundColor = [UIColor yellowColor];
    _changeItemBtn.backgroundColor = [UIColor purpleColor];
}
                                                                                                                                                                                                              
- (void)setDynamicTouchShortItems
{
    UIApplicationShortcutIcon * iconType1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc] initWithType:@"com.yjyuanshuai.ui" localizedTitle:@"item1" localizedSubtitle:nil icon:iconType1 userInfo:nil];

    UIApplicationShortcutIcon * iconType2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutItem * item2= [[UIApplicationShortcutItem alloc] initWithType:@"com.yjyuanshuai.3dtouch" localizedTitle:@"item2" localizedSubtitle:nil icon:iconType2 userInfo:nil];

    [[UIApplication sharedApplication] setShortcutItems:@[item1, item2]];

    dispatch_async(dispatch_get_main_queue(), ^{
        _infoLabel.text = @"changed!";
        _changeItemBtn.userInteractionEnabled = NO;
    });
}

- (void)regist
{
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    else {
        NSLog(@"------ 3D Touch unavailable!");
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    // 3D Touch 权限变化
    [super traitCollectionDidChange:previousTraitCollection];

    switch (previousTraitCollection.forceTouchCapability) {
        case UIForceTouchCapabilityAvailable:
        {
            [self registerForPreviewingWithDelegate:self sourceView:self.view];
        }
            break;
        case UIForceTouchCapabilityUnknown:
        {
            NSLog(@"------ 3D Touch unknown!");
        }
            break;
        case UIForceTouchCapabilityUnavailable:
        {
            NSLog(@"------ 3D Touch unavailable!");
        }
            break;

        default:
            break;
    }
}

#pragma mark - UIViewControllerPreviewingDelegate
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    previewingContext.sourceRect = _imageView.frame; // rect 内高亮，其余部分模糊

    YS3DTouchPeekVC * childVC = [[YS3DTouchPeekVC alloc] init];
    childVC.preferredContentSize = CGSizeMake(0, 0);        // 为0的话则系统自动配置最佳大小
    return childVC;
}

// 用力继续某一个Cell之后弹出视图，再次Touch的效果
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    SFSafariViewController * popVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
    popVC.title = @"Pop to Safari";
    [self.navigationController pushViewController:popVC animated:YES];
}

@end
