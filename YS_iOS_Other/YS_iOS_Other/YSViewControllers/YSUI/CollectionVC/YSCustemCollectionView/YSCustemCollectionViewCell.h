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

// 瀑布流
- (void)setYSCustemCollectionViewCellContent:(NSString *)imageStr itemStr:(NSString *)itemStr;

// 堆叠
- (void)setStackCellContent:(NSString *)imageStr;

// 圆形
- (void)setCircleCellContent:(NSString *)imageStr;

// 卡片
- (void)setCardCellContent:(NSString *)imageStr;

// 导航风火轮
- (void)setNavWheelsCellContent:(NSString *)imageStr itemStr:(NSString *)itemStr;

@end
