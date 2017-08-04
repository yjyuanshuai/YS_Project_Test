//
//  YSCustemCollectionViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/3.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionViewCell.h"

@implementation YSCustemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
        }];

        _itemLabel = [UILabel new];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        _itemLabel.font = YSFont_Sys(15);
        [self.contentView addSubview:_itemLabel];
        [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setYSCustemCollectionViewCellContent:(NSString *)imageStr itemStr:(NSString *)itemStr
{
    UIImage * image = [UIImage imageNamed:imageStr];
    _imageView.image = image;

    _itemLabel.text = itemStr;
}

@end
