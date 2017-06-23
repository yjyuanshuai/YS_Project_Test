//
//  YS3DTouchPeekVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YS3DTouchPeekVC.h"

@interface YS3DTouchPeekVC()<UIViewControllerPreviewingDelegate>

@end

@implementation YS3DTouchPeekVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView * whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth-40, 7.0/5*(kScreenWidth-40))];
    whiteBgView.backgroundColor = [UIColor whiteColor];
    whiteBgView.layer.borderWidth = 1.0;
    whiteBgView.layer.cornerRadius = 10;
    whiteBgView.clipsToBounds = YES;
    [self.view addSubview:whiteBgView];

    UIImageView * showImageView = [[UIImageView alloc] initWithFrame:whiteBgView.bounds];
    showImageView.image = [UIImage imageNamed:@"test01"];
    [whiteBgView addSubview:showImageView];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction * action1 = [UIPreviewAction actionWithTitle:@"动作1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {

        NSLog(@"-------- 动作1");
    }];

    UIPreviewAction * action2 = [UIPreviewAction actionWithTitle:@"动作2" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {

        NSLog(@"-------- 动作2");
    }];

    UIPreviewAction * action3 = [UIPreviewAction actionWithTitle:@"动作3" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {

        NSLog(@"-------- 动作3");
    }];

    return @[action1, action2, action3];
}

@end
