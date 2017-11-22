//
//  YSCustemCollectionViewHeadCell.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/3.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionViewHeadCell.h"

@implementation YSCustemCollectionViewHeadCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headLabel = [UILabel new];
        _headLabel.font = YSFont_Sys(16);
        _headLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_headLabel];

        [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];

        _headLabel.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
