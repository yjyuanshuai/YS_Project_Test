//
//  GlobalEnum.h
//  YS_iOS_Other
//
//  Created by YJ on 17/5/17.
//  Copyright © 2017年 YJ. All rights reserved.
//

#ifndef GlobalEnum_h
#define GlobalEnum_h


#pragma mark - 音频类型
//
typedef NS_ENUM(NSInteger, AudioListType)
{
    AudioListTypeLocalPlay_SystemSound,     // 系统音效
    AudioListTypeLocalPlay_CustemSound,     // 本地自定义音效
    AudioListTypeLocalPlay_Music,           // 本地音乐
    AudioListTypeLocalPlay_LibraryMusic,    // 本地音乐库音频
    AudioListTypeLoaclMake,                 // 本地录制音频
    AudioListTypeWeb                        // 网络音乐播放
};

// 播放设置
typedef NS_ENUM(NSInteger, AudioPlaySetting)
{
    AudioPlaySettingList,   // 按序播放
    AudioPlaySettingAny,    // 随机播放
    AudioPlaySettingOne     // 单首循环
};

// 播放状态
typedef NS_ENUM(NSInteger, AudioPlayStatus)
{
    AudioPlayStatusPlaying,     // 正在播放
    AudioPlayStatusPause        // 暂停
};

#endif /* GlobalEnum_h */
