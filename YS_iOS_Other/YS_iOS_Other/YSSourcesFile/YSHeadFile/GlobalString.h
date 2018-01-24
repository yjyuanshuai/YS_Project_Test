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


#pragma mark - 全局宏
/*------------------ Runtime 归解档 -------------------------*/
#define encodeRuntime(A) \
\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [self valueForKey:key];\
[encoder encodeObject:value forKey:key];\
}\
free(ivars);\
\

#define initCoderRuntime(A) \
\
if (self = [super init]) {\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
Ivar ivar = ivars[i];\
const char *name = ivar_getName(ivar);\
NSString *key = [NSString stringWithUTF8String:name];\
id value = [decoder decodeObjectForKey:key];\
[self setValue:value forKey:key];\
}\
free(ivars);\
}\
return self;\
\



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

#define YSColorRGB(redValue, greenValue, blueValue) [UIColor colorWithRed:redValue/255.0 green:greenValue/255.0 blue:blueValue/255.0 alpha:1.0]

#define YSColorRGBAlpha(redValue, greenValue, blueValue, alphaValue) [UIColor colorWithRed:redValue/255.0 green:greenValue/255.0 blue:blueValue/255.0 alpha:alphaValue]

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
// 百度地图
#define kBaiduMapAK             @"0o1W98wXRSCK6dgQoxl2T6XMEnGQIK2L"
// shareSDK
#define kShareSDKAppKey         @"1f020d843f1f4"
#define kShareSDKAppSecret      @"fbd5c00ac3315835351166cd693ee087"
#define kWeiboAppKey            @"922723031"
#define kWeiboAppSecret         @"3d84f98ad23cb80d2b25199772aa5bb6"



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



/*-------------------------------------------*/
#pragma mark - 链接
#define YSURL_MethodSwizzling   @"http://www.cocoachina.com/ios/20170627/19628.html"      // 黑魔法
#define YSURL_GCD               @"https://objccn.io/issue-2-1/"

#endif /* GlobalString_h */
