//
//  YSOperationDetailCollectionViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 17/3/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSOperationDetailCollectionViewCell.h"

@implementation YSOperationDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)setCollectionCell:(id)image
{
    if ([image isKindOfClass:[UIImage class]]) {
        _imageView.image = image;
    }
    else if ([image isKindOfClass:[NSData class]]) {
        _imageView.image = [UIImage imageWithData:image];
    }
}

@end
