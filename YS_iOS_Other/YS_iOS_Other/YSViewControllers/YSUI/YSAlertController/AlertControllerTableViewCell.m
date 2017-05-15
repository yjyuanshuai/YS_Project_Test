//
//  AlertControllerTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AlertControllerTableViewCell.h"
#import "NSString+YSStringDo.h"

@implementation AlertControllerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViewsAndContraints];
    }
    return self;
}

- (void)setAlertConCellContent:(NSString *)str
{
    if (![str isBlank]) {
        _showLabel.textColor = [UIColor blackColor];
        _showLabel.text = str;
    }
}


- (void)createSubViewsAndContraints
{
    _showLabel = [UILabel new];
    _showLabel.textAlignment = NSTextAlignmentLeft;
    _showLabel.font = YSFont_Sys(16);
    _showLabel.text = @"点击选择/输入";
    _showLabel.textColor = YSFontValidColor;
    [self.contentView addSubview:_showLabel];
    
    [_showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
}

@end
