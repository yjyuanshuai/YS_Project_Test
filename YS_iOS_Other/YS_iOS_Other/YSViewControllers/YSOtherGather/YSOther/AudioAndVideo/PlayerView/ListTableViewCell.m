//
//  ListTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ListTableViewCell.h"
#import "YSSongModel.h"

@implementation ListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];
        
        [self createSubViews];
        [self addConstraintsToSelf];
        
    }
    return self;
}

- (void)createSubViews
{
    _songNameLabel = [UILabel new];
    _songNameLabel.textColor = [UIColor whiteColor];
    _songNameLabel.textAlignment = NSTextAlignmentLeft;
    _songNameLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_songNameLabel];
    
    _songerName = [UILabel new];
    _songerName.textColor = [UIColor whiteColor];
    _songerName.textAlignment = NSTextAlignmentLeft;
    _songerName.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_songerName];
    
    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_timeLabel];
}

- (void)addConstraintsToSelf
{
    [_songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [_songerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(_songNameLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.right.equalTo(_songNameLabel.mas_right);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_songNameLabel.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
}

- (void)setListCellContent:(YSSongModel *)model time:(NSString *)timeStr
{
    if ([model.songerName isEqualToString:@""] || model.songerName == nil) {
        
        [_songerName mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_songNameLabel.mas_bottom);
        }];
        
    }
    _songNameLabel.text = model.name;
    _songerName.text = model.songerName;
    _timeLabel.text = timeStr;
}

@end
