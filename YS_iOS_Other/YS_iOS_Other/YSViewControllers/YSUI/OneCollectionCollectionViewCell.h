//
//  OneCollectionCollectionViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionTestModel;

@interface OneCollectionCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * itemTitle;
@property (nonatomic, strong) UILabel * itemDesc;

- (void)setContentWithModel:(CollectionTestModel *)model;

@end
