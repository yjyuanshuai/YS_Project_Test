//
//  YSCalendarEventTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EKEvent;

@interface YSCalendarEventTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * startDate;
@property (nonatomic, strong) UILabel * endDate;

- (void)setCalendarEventContent:(EKEvent *)event;
- (void)setCreateCalendarEventInfo:(NSString *)title detail:(NSString *)detail;

@end
