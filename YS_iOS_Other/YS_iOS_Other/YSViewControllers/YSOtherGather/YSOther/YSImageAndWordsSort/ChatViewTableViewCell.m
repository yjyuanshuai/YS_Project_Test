//
//  ChatViewTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChatViewTableViewCell.h"
#import "ChatMsgModel.h"
#import "YSImageAndTextSort.h"
#import "NSString+YSStringDo.h"

@implementation ChatViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.transform = CGAffineTransformMakeRotation(-M_PI);
        [self createSubViews];
        [self addConstraintsToSelf];
    }
    return self;
}

- (void)setChatMsgCell:(ChatMsgModel *)model
{
    _msgTimeLabel.text = model.msgTime;
    _userNameLabel.text = model.userName;
    [_userHeadBtn setBackgroundImage:[UIImage imageNamed:@"Expression_57"] forState:UIControlStateNormal];
    [_userHeadBtn setBackgroundImage:[UIImage imageNamed:@"Expression_57"] forState:UIControlStateHighlighted];
    
    if (![model.msgData isBlank]) {
        _msgContentLabel.attributedText = [YSImageAndTextSort textAttach:model.msgData attributDic:@{NSFontAttributeName:_msgContentLabel.font} emoArr:[EmotionFileAnalysis sharedEmotionFile].emoArr originY:-8];
    }
}

+ (CGFloat)getChatViewTableViewHeight:(ChatMsgModel *)model
{
    // 时间
    
    
    return 0;
}

#pragma mark -
- (void)createSubViews
{
    _msgTimeLabel = [UILabel new];
    _msgTimeLabel.textColor = [UIColor blackColor];
    _msgTimeLabel.font = YSFont_Sys(16);
    _msgTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_msgTimeLabel];
    
    _userHeadBtn = [UIButton new];
    _userHeadBtn.layer.borderColor = YSDefaultGrayColor.CGColor;
    _userHeadBtn.layer.borderWidth = 0.5;
    _userHeadBtn.layer.cornerRadius = 45/2;
    _userHeadBtn.clipsToBounds = YES;
    [self.contentView addSubview:_userHeadBtn];
    
    _userNameLabel = [UILabel new];
    _userNameLabel.textColor = [UIColor blackColor];
    _userNameLabel.font = YSFont_Sys(14);
    [self.contentView addSubview:_userNameLabel];
    
    _msgBgBtn = [UIButton new];
    UIImage * image = [UIImage imageNamed:@"chatBubble_Sending_Solid"];
    CGFloat top = image.size.height * 0.7;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottem = image.size.height - top;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottem, left) resizingMode:UIImageResizingModeStretch];
    [_msgBgBtn setBackgroundImage:image forState:UIControlStateNormal];
    [_msgBgBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    [self.contentView addSubview:_msgBgBtn];
    
    _msgContentLabel = [UILabel new];
    _msgContentLabel.font = YSFont_Sys(16);
    _msgContentLabel.textColor = [UIColor blackColor];
    _msgContentLabel.numberOfLines = 0;
    [self.contentView addSubview:_msgContentLabel];
    
    [self.contentView sendSubviewToBack:_msgBgBtn];
}

- (void)addConstraintsToSelf
{
    [_msgTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    
    [_userHeadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_msgTimeLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userHeadBtn);
        make.right.equalTo(_userHeadBtn.mas_left).offset(-10);
    }];
    
    [_msgContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameLabel.mas_bottom).offset(20);
        make.right.equalTo(_userNameLabel).offset(-10);
        make.left.greaterThanOrEqualTo(self.contentView).offset(80);
        make.bottom.equalTo(self.contentView).offset(-25);
    }];
    
    [_msgBgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_msgContentLabel).insets(UIEdgeInsetsMake(-10, -10, -10, -15));
    }];
    
    [_msgContentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_msgContentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    _msgContentLabel.preferredMaxLayoutWidth = CGRectGetWidth(_msgContentLabel.frame);
}

@end
