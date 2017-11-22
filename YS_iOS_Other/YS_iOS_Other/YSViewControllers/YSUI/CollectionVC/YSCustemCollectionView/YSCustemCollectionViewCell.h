//
//  YSCustemCollectionViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/3.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCustemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * itemLabel;

- (void)setYSCustemCollectionViewCellContent:(NSString *)imageStr itemStr:(NSString *)itemStr;

- (void)setStackCellContent:(NSString *)imageStr;

// 圆形
- (void)setCircleCellContent:(NSString *)imageStr;

@end
