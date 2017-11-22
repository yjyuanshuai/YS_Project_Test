//
//  OneCollectionCollectionViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneCollectionCollectionViewCell.h"
#import "CollectionTestModel.h"

@implementation OneCollectionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [self.contentView addSubview:_imageView];
        
        _itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), 80, 20)];
        _itemTitle.textColor = [UIColor lightGrayColor];
        _itemTitle.textAlignment = NSTextAlignmentCenter;
        _itemTitle.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_itemTitle];
        
        _itemDesc = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_itemTitle.frame), 80, 20)];
        _itemDesc.textColor = [UIColor lightGrayColor];
        _itemDesc.textAlignment = NSTextAlignmentCenter;
        _itemDesc.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_itemDesc];

    }
    return self;
}

- (void)setContentWithModel:(CollectionTestModel *)model
{
    _imageView.image = model.collectionImage;
    _itemTitle.text = model.itemTitle;
    _itemDesc.text = model.itemDesc;
}


@end
