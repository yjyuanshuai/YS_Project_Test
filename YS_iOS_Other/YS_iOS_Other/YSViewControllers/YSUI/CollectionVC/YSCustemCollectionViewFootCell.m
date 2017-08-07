//
//  YSCustemCollectionViewFootCell.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/3.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionViewFootCell.h"

@implementation YSCustemCollectionViewFootCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _footLabel = [UILabel new];
        _footLabel.font = YSFont_Sys(16);
        _footLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_footLabel];

        [_footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];

        _footLabel.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

@end
