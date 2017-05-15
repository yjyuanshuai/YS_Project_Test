//
//  GlobalString.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSFileManager.h"

#ifndef GlobalString_h
#define GlobalString_h


/*-------------------------------------------*/
#pragma mark - 设备信息

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenHeightNo20       [UIScreen mainScreen].bounds.size.height - 20
#define kScreenHeightNo64       [UIScreen mainScreen].bounds.size.height - 64
#define kScreenHeightNo113      [UIScreen mainScreen].bounds.size.height - 64 - 49

#define kAPPKeyWindow   [UIApplication sharedApplication].keyWindow

#define kSystemVersion  [[[UIDevice currentDevice] systemVersion] floatValue]


/*-------------------------------------------*/
#pragma mark - 颜色

#define YSColorRGB(red, green, blue) [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0]

#define YSColorRGBAlpha(red, green, blue, alpha) [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] 


#define YSColorDefault [UIColor colorWithRed:153.0/255.0 green:230.0/255.0 blue:240.0/255.0 alpha:1.0]

#define YSFontValidColor [UIColor colorWithRed:231.0/255.0 green:236.0/255.0 blue:218.0/255.0 alpha:1.0]

#define YSDefaultGrayColor [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]

/*-------------------------------------------*/
#pragma mark - 字体

#define YSFont_Sys(font) [UIFont systemFontOfSize:font]





/*-------------------------------------------*/
#pragma mark - 用户偏好设置有关

#define UserRememberPassWord    @"UserRememberPassWord"
#define UserNameKey             @"UserNameKey"
#define UserPassWordKey         @"UserPassWordKey"

#define UserAudioPlayList       @"UserAudioPlayList"


// 暂时固定死密码和用户名
#define CurrentAccout           @"1771234"
#define CurrentPassword         @"123"

#define HasLogin                @"CurrentLoginStatus_HasLogin"      // 是否已登录
#define HasKickOut              @"CurrentLoginStatus_HasKickOut"    // 是否被踢出



/*-------------------------------------------*/
#pragma mark - keychain

#define KeyChainUserAccount     @"KeyChainUserAccount"
#define KeyChainUserPassword    @"KeyChainUserPassword"



/*-------------------------------------------*/
#pragma mark - 第三方有关
/*********  百度地图 *******************/
#define kBaiduMapAK     @"0o1W98wXRSCK6dgQoxl2T6XMEnGQIK2L"





/*-------------------------------------------*/
#pragma mark - 沙盒目录有关

#define sbMedia_AudioDir [[YSFileManager getDocumentsPath] stringByAppendingPathComponent:@"YS_iOS_Media"]          // 音频文件夹
#define sbMedia_AudioGroupPlist [sbMedia_AudioDir stringByAppendingPathComponent:@"GroupAudio.plist"]      // 音频分组
#define sbMedia_AudioCurrentPlist [sbMedia_AudioDir stringByAppendingPathComponent:@"CurrentAudio.plist"]    // 当前音频文件




/*-------------------------------------------*/
#pragma mark - 通知名

#define BackgroundOperation     @"BackgroundOperation"





/*-------------------------------------------*/
#pragma mark - 数据库

#define DB_PATH_NAME        @"YSTestDB.sqlite"
#define DB_SQL_BUNDLE       @"DBManagerSql"

#define TABLE_CHATMSG       @"Chat_Msg_Table"



#endif /* GlobalString_h */
