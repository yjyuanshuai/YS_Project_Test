//
//  YSDDLogManager.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSDDLogManager.h"
#import "YSDevSettingFile.h"

int ddLogLevel = DDLogLevelVerbose;

@implementation YSDDLogManager

static YSDDLogManager * instance = nil;

/**
 *  为了防止别人不小心利用alloc/init方式创建示例，也为了防止别人故意为之，我们要保证不管用什么方式创建都只能是同一个实例对象
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)shareDDLogManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YSDDLogManager alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        DDLogInfo(@"------------ current ddLogLevel: %d", ddLogLevel);
        
#ifdef Project_Env

#if Project_Env == 0x01
        ddLogLevel = DDLogLevelVerbose;
#else
        ddLogLevel = DDLogLevelWarning;
#endif
        
#elif
        ddLogLevel = DDLogLevelOff;
#endif
        
        
        
#ifdef  YSDDTTYLog_ON
        
        // DDTTYLoyger（发送日志语句到Xcode控制台，如果可用）
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
#endif
        
        
        
        
#ifdef  YSDDASLLog_ON
        
        // DDASLLogger（发送日志语句到苹果的日志系统，以便它们显示在Console.app上）
        [DDLog addLogger:[DDASLLogger sharedInstance]];
#endif
        
        
        
        
#ifdef YSDDFileLog_ON
        
        // DDFIleLoger（把日志语句发送至文件）
        DDFileLogger * fileLogger = [[DDFileLogger alloc] init];
        // 保存周期
        fileLogger.rollingFrequency = 660 * 660 * 24;
        // 最大的日志文件数量
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        
        [DDLog addLogger:fileLogger];
        
#endif

    }
    
    return self;
}

@end
