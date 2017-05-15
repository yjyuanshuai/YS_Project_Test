//
//  PhotoCollectionViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 17/2/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoCollectionDelegate;
@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<PhotoCollectionDelegate> delegate;
@property (nonatomic, strong) UITapGestureRecognizer * clickToDetail;
@property (nonatomic, strong) UIImageView * imageView;

- (void)setPhotoCellWithImage:(UIImage *)image currentIndex:(NSInteger)index;

@end


@protocol PhotoCollectionDelegate <NSObject>

- (void)clickToCheckDetailCurrentIndex:(NSInteger)index;

@end
