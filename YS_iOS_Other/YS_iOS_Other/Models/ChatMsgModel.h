//
//  ChatMsgModel.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ChatMsgType)
{
    ChatMsgTypeText,
    ChatMsgTypeImage,
    ChatMsgTypeAudio,
    ChatMsgTypeVideo
};

@interface ChatMsgModel : NSObject

@property (nonatomic, copy) NSString * msgId;
@property (nonatomic, copy) NSString * msgTime;
@property (nonatomic, assign) ChatMsgType msgType;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * userHeadImage;
@property (nonatomic, copy) NSString * msgData;
@property (nonatomic, assign) BOOL isSelfSend;

@end
