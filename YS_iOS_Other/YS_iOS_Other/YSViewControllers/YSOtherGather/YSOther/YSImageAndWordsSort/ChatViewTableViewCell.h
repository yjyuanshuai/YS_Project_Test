//
//  ChatViewTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatMsgModel;

@interface ChatViewTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * msgTimeLabel;
@property (nonatomic, strong) UIButton * userHeadBtn;
@property (nonatomic, strong) UILabel * userNameLabel;
@property (nonatomic, strong) UIButton * msgBgBtn;
@property (nonatomic, strong) UILabel * msgContentLabel;

- (void)setChatMsgCell:(ChatMsgModel *)model;

@end
