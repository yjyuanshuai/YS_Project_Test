//
//  EmotionCollectionViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * emoImageView;

- (void)setEmoImageView:(NSString *)emoStr;

@end
