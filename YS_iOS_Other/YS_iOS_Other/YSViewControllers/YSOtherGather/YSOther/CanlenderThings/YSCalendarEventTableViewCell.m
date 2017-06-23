//
//  YSCalendarEventTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCalendarEventTableViewCell.h"
#import <EventKit/EventKit.h>

@implementation YSCalendarEventTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.font = YSFont_Sys(16);
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];

        _startDate = [UILabel new];
        _startDate.font = YSFont_Sys(14);
        _startDate.textColor = [UIColor blackColor];
        [self.contentView addSubview:_startDate];

        _endDate = [UILabel new];
        _endDate.font = YSFont_Sys(14);
        _endDate.textColor = [UIColor blackColor];
        [self.contentView addSubview:_endDate];

        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(10);
        }];

        [_startDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
            make.left.equalTo(_titleLabel);
        }];

        [_endDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_startDate.mas_bottom).offset(10);
            make.left.equalTo(_titleLabel);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

- (void)setCalendarEventContent:(EKEvent *)event
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    _titleLabel.text = event.title;
    _startDate.text = [formatter stringFromDate:event.startDate];
    _endDate.text = [formatter stringFromDate:event.endDate];
}

- (void)setCreateCalendarEventInfo:(NSString *)title detail:(NSString *)detail
{
    _titleLabel.text = detail;
    _startDate.text = @"";
    _endDate.text = title;
}

@end
