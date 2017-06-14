//
//  ChatViewSuperCell.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/13.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatMsgModel;

@interface ChatViewSuperCell : UITableViewCell

@property (nonatomic, strong) UILabel * msgTimeLabel;
@property (nonatomic, strong) UIButton * userHeadBtn;
@property (nonatomic, strong) UILabel * userNameLabel;
@property (nonatomic, strong) UIButton * msgBgBtn;

- (void)setChatMsgCell:(ChatMsgModel *)model;
+ (CGFloat)getChatViewTableViewHeight:(ChatMsgModel *)model;

@end
