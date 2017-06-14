//
//  ChatMsgModel.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChatMsgModel.h"

@implementation ChatMsgModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _msgId = @"";
        _msgTime = @"";
        _msgType = ChatMsgTypeNone;
        _userName = @"";
        _userHeadImage = @"";
        _msgContentData = [NSData data];
        _isSelfSend = NO;
    }
    return self;
}

@end
