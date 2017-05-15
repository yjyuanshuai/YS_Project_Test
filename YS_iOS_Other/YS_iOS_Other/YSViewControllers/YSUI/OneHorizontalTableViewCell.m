//
//  OneHorizontalTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/14.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneHorizontalTableViewCell.h"
#import "CollectionTestModel.h"

@implementation OneHorizontalTableViewCell
{
    NSIndexPath * _indexPath;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;
        
        _ysImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        [self.contentView addSubview:_ysImageView];
        
        _itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_ysImageView.frame), 80, 20)];
        _itemTitle.textColor = [UIColor lightGrayColor];
        _itemTitle.textAlignment = NSTextAlignmentCenter;
        _itemTitle.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_itemTitle];
        
        _itemDesc = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_itemTitle.frame), 80, 20)];
        _itemDesc.textColor = [UIColor lightGrayColor];
        _itemDesc.textAlignment = NSTextAlignmentCenter;
        _itemDesc.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_itemDesc];

    }
    return self;
}

- (void)setCellContent:(CollectionTestModel *)model indexPath:(NSIndexPath *)indexPath
{
    _ysImageView.image = model.collectionImage;
    _itemTitle.text = model.itemTitle;
    _itemDesc.text = model.itemDesc;
    
    _indexPath = indexPath;
}

@end
