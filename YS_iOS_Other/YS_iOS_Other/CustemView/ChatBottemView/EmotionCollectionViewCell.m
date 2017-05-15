//
//  EmotionCollectionViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "EmotionCollectionViewCell.h"

@implementation EmotionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _emoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_emoImageView];
        
    }
    return self;
}

- (void)setEmoImageView:(NSString *)emoStr
{
    _emoImageView.image = [UIImage imageNamed:emoStr];
}

@end
