//
//  ChatViewSuperCell.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/13.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ChatViewSuperCell.h"

@implementation ChatViewSuperCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.contentView.transform = CGAffineTransformMakeRotation(-M_PI);

        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    _msgTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 20)];
    _msgTimeLabel.textColor = [UIColor blackColor];
    _msgTimeLabel.font = YSFont_Sys(16);
    _msgTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_msgTimeLabel];

    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_msgTimeLabel.frame) + 10, kScreenWidth - 20 - 45 - 10, 20)];
    _userNameLabel.textColor = [UIColor blackColor];
    _userNameLabel.font = YSFont_Sys(14);
    _userNameLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_userNameLabel];

    _userHeadBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 45, 50 - 45/2, 45, 45)];
    _userHeadBtn.layer.borderColor = YSDefaultGrayColor.CGColor;
    _userHeadBtn.layer.borderWidth = 0.5;
    _userHeadBtn.layer.cornerRadius = 45/2;
    _userHeadBtn.clipsToBounds = YES;
    [self.contentView addSubview:_userHeadBtn];

    _msgBgBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(_userNameLabel.frame), kScreenWidth - 80 - 45 - 10, 20)];
    UIImage * image = [UIImage imageNamed:@"chatBubble_Sending_Solid"];
    CGFloat top = image.size.height * 0.7;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottem = image.size.height - top;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottem, left) resizingMode:UIImageResizingModeStretch];
    [_msgBgBtn setBackgroundImage:image forState:UIControlStateNormal];
    [_msgBgBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    [self.contentView addSubview:_msgBgBtn];
}

#pragma mark -


@end
