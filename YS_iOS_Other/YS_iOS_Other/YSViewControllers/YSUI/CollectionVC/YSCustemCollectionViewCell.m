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
        self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
        self.contentView.layer.borderWidth = 1;

        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];

        _itemLabel = [UILabel new];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        _itemLabel.font = YSFont_Sys(15);
        [self.contentView addSubview:_itemLabel];

        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];

        [_itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        _itemLabel.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)setYSCustemCollectionViewCellContent:(NSString *)imageStr itemStr:(NSString *)itemStr
{
    NSString * path = [[NSBundle mainBundle] pathForResource:imageStr ofType:@"jpg"];
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    _imageView.image = image;
    _itemLabel.text = itemStr;
}

@end
