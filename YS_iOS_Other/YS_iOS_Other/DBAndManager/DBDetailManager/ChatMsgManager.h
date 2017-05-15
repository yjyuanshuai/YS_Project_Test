//
//  ChatMsgManager.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChatMsgModel;

@interface ChatMsgManager : NSObject

+ (BOOL)insertChatMsg:(ChatMsgModel *)model;
+ (BOOL)deleteChatMsg:(ChatMsgModel *)model;
+ (BOOL)deleteAllChatMsgs;
+ (NSMutableArray *)queryChatMsgsWithLimit:(NSInteger)limit currentModel:(ChatMsgModel *)model;

@end
