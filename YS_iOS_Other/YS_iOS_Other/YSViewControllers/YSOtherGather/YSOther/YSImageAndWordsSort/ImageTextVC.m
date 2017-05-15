//
//  ImageTextVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/2/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ImageTextVC.h"
#import "YSImageAndTextSort.h"

@interface ImageTextVC ()

@end

@implementation ImageTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图文混排";
    
    NSString * str1 = @"文字加上表情[得意][酷][呲牙]";
    NSString * str2 = @"<微信>腾讯科技讯 微软提供免费升级的Windows 10，在全球获得普遍好评。但微软已经有一段时间没有公布最新升级数据。科技市场研究公司StatCounter发布了有关Windows升级的相关数据，显示出Windows 10的升级节奏开始放缓。<微信>另外，数据显示Windows 8用户是升级的主力军，Windows 7用户升级动力不太足。";
    
    UILabel * label1 = [UILabel new];
    label1.numberOfLines = 0;
    label1.preferredMaxLayoutWidth = kScreenWidth - 30;
    [label1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:label1];
    
    UILabel * label2 = [UILabel new];
    label2.numberOfLines = 0;
    label2.preferredMaxLayoutWidth = kScreenWidth - 30;
    [label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.view addSubview:label2];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    
    NSDictionary * dict = @{NSAttachmentAttributeName:[UIFont systemFontOfSize:18.0]};

    NSMutableArray * emoArr = [[EmotionFileAnalysis sharedEmotionFile] analysisEmoData:@"expression" type:@"plist"];
    label1.attributedText = [YSImageAndTextSort textAttach:str1 attributDic:dict emoArr:emoArr originY:-8];
    label2.attributedText = [YSImageAndTextSort textAttach:str2 attributDic:dict exchangeStr:@"<微信>" image:@"tab_two_sel"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
