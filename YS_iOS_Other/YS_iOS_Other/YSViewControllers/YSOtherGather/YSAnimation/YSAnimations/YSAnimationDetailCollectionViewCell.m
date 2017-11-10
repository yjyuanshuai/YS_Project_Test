//
//  YSAnimationDetailCollectionViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSAnimationDetailCollectionViewCell.h"

@implementation YSAnimationDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = YSDefaultGrayColor;
        
        _nameLabel = [UILabel new];
        _nameLabel.font = YSFont_Sys(15.0);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    _nameLabel.text = content;
}

@end
