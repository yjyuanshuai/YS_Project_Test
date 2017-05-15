//
//  YSDevSettingFile.h
//  YS_iOS_Other
//
//  Created by YJ on 16/11/23.
//  Copyright © 2016年 YJ. All rights reserved.
//


/**
 *  控制环境 、以及各种环境下 日志等的设置
 */

#ifndef YSDevSettingFile_h
#define YSDevSettingFile_h



#pragma mark - 开发环境枚举
typedef enum Project_Env_Mode
{
    Project_Env_Debug = 0x01        // 开发环境
    
}Project_Env_Mode;

//----------    环境设置    -----------//
#pragma mark - 环境设置

#ifndef Project_Env
#define Project_Env 0x01
#elif
#warning "Project_Env has setted."
#endif


#ifdef Project_Env
#if Project_Env == 0x01

#define YSDDFileLog_ON
#define YSDDTTYLog_ON
#define YSDDASLLog_ON

#endif
#endif


#endif /* YSDevSettingFile_h */
