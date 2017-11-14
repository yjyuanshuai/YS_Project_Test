//
//  YSAnimationDetailCollectionViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSAnimationDetailCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * nameLabel;

- (void)setContent:(NSString *)content canClick:(BOOL)canClick;

@end
