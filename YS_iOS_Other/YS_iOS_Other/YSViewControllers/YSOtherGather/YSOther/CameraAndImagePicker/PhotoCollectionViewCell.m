//
//  PhotoCollectionViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell
{
    NSInteger _currentIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"btn1"];
        _imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        _clickToDetail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToDetailImage)];
        [_imageView addGestureRecognizer:_clickToDetail];
    }
    return self;
}

- (void)setPhotoCellWithImage:(UIImage *)image currentIndex:(NSInteger)index
{
    _currentIndex = index;
    if (image) {
        _imageView.image = image;
    }
}

- (void)clickToDetailImage
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickToCheckDetailCurrentIndex:)]) {
        
        [_delegate clickToCheckDetailCurrentIndex:_currentIndex];
    }
}

@end
