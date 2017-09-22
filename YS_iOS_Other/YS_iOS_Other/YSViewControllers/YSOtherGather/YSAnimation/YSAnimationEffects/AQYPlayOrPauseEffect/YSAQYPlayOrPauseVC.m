//
//  YSAQYPlayOrPauseVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/9/20.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSAQYPlayOrPauseVC.h"
#import "YSiQiYiPlayBtn.h"
#import "YSYouKuPlayBtn.h"

static NSInteger iQiYiBtnTag = 2017092001;
static NSInteger YouKuBtnTag = 2017092002;

@interface YSAQYPlayOrPauseVC ()

@end

@implementation YSAQYPlayOrPauseVC
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    YSiQiYiPlayBtn * iQiYiBtn = [[YSiQiYiPlayBtn alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, 100, 200, 200)];
    iQiYiBtn.tag = iQiYiBtnTag;
    [iQiYiBtn addTarget:self action:@selector(clickToBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iQiYiBtn];

//    YSYouKuPlayBtn * youkuBtn = [[YSYouKuPlayBtn alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, 100+200+100, 200, 200)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickToBtn:(UIButton *)btn
{
    if (btn.tag == iQiYiBtnTag) {
        YSiQiYiPlayBtn * iQiYiBtn = (YSiQiYiPlayBtn *)btn;
        if (iQiYiBtn.iQiYiState == YSiQiYiPlayBtnStatusPause) {
            iQiYiBtn.iQiYiState = YSiQiYiPlayBtnStatusPlay;
        }
        else {
            iQiYiBtn.iQiYiState = YSiQiYiPlayBtnStatusPause;
        }
    }
    else if (btn.tag == YouKuBtnTag) {

    }
}

@end
