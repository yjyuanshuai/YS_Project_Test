//
//  YSFirstPageTableViewCell.h
//  YS_LightBlue
//
//  Created by YJ on 17/5/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSPeripheralModel;

@interface YSFirstPageTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView * signStrengthView;
@property (nonatomic, strong) UILabel * signStrengthLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * servicesLabel;

- (void)setFirstPageCell:(YSPeripheralModel *)model;

@end

