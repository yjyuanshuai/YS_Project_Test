//
//  ChatMsgManager.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChatMsgManager.h"
#import "ChatMsgModel.h"
#import "YSTestDataBase.h"

@implementation ChatMsgManager

+ (BOOL)insertChatMsg:(ChatMsgModel *)model
{
    __block BOOL insertSuc = NO;
    
    FMDatabaseQueue * dbQueue = [YSTestDataBase getDBQueue];
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString * insertStr = [NSString stringWithFormat:@"replace into %@(msgId, msgTime, msgType, userName, userHeadImage, msgData, isSelfSend) values(?,?,?,?,?,?,?)", TABLE_CHATMSG];
        insertSuc = [db executeUpdate:insertStr, model.msgId, model.msgTime, @(model.msgType), model.userName, model.userHeadImage, model.msgData, @(model.isSelfSend)];
    }];
    [dbQueue close];
    
    if (insertSuc) {
        DDLogInfo(@"------------- Chat_Msg_Table 插入数据成功！");
    }
    else {
        DDLogInfo(@"------------- Chat_Msg_Table 插入数据失败！");
    }
    
    return insertSuc;
}

+ (BOOL)deleteChatMsg:(ChatMsgModel *)model
{
    __block BOOL deleteSuc = NO;
    
    FMDatabaseQueue * dbQueue = [YSTestDataBase getDBQueue];
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from %@ where msgId = ?", TABLE_CHATMSG];
        deleteSuc = [db executeUpdate:deleteStr, model.msgId];
    }];
    [dbQueue close];
    
    if (deleteSuc) {
        DDLogInfo(@"------------- Chat_Msg_Table 删除数据成功！");
    }
    else {
        DDLogInfo(@"------------- Chat_Msg_Table 删除数据失败！");
    }
    
    return deleteSuc;
}

+ (BOOL)deleteAllChatMsgs
{
    __block BOOL deleteSuc = NO;
    
    FMDatabaseQueue * dbQueue = [YSTestDataBase getDBQueue];
    [dbQueue inDatabase:^(FMDatabase *db) {
        deleteSuc = [db executeUpdate:[NSString stringWithFormat:@"delete from %@", TABLE_CHATMSG]];
    }];
    [dbQueue close];
    
    if (deleteSuc) {
        DDLogInfo(@"------------- Chat_Msg_Table 删除数据成功！");
    }
    else {
        DDLogInfo(@"------------- Chat_Msg_Table 删除数据失败！");
    }
    
    return deleteSuc;
}

+ (NSMutableArray *)queryChatMsgsWithLimit:(NSInteger)limit currentModel:(ChatMsgModel *)model;
{
    NSMutableArray * queryArr = [@[] mutableCopy];
    
    FMDatabaseQueue * queue = [YSTestDataBase getDBQueue];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * queryStr = @"";
        if (model) {
            queryStr = [NSString stringWithFormat:@"select * from %@ where msgTime < %@ order by msgTime desc limit %d", TABLE_CHATMSG, model.msgTime, (int)limit];
        }
        else {
            queryStr = [NSString stringWithFormat:@"select * from %@ order by msgTime desc limit %d", TABLE_CHATMSG, (int)limit];
        }
        FMResultSet * ret = [db executeQuery:queryStr];
        while ([ret next]) {
            ChatMsgModel * model = [self modelWithResultSet:ret];
            [queryArr addObject:model];
        }
    }];
    [queue close];
    
    return queryArr;
}

#pragma mark -
+ (ChatMsgModel *)modelWithResultSet:(FMResultSet *)ret
{
    ChatMsgModel * model = [[ChatMsgModel alloc] init];
    model.msgId         = [ret stringForColumn:@"msgId"];
    model.msgTime       = [ret stringForColumn:@"msgTime"];
    model.msgType       = [ret intForColumn:@"msgType"];
    model.userName      = [ret stringForColumn:@"userName"];
    model.userHeadImage = [ret stringForColumn:@"userHeadImage"];
    model.msgData       = [ret stringForColumn:@"msgData"];
    model.isSelfSend    = [ret stringForColumn:@"isSelfSend"];
    return model;
}

@end
