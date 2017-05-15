//
//  ListTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/9/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSSongModel;

@interface ListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * songNameLabel;
@property (nonatomic, strong) UILabel * songerName;
@property (nonatomic, strong) UILabel * timeLabel;

- (void)setListCellContent:(YSSongModel *)model time:(NSString *)timeStr;

@end
