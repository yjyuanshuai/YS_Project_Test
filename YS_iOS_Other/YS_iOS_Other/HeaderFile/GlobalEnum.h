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
    AudioListTypeLocalPlay_SystemSound,     // 本地播放音效
    AudioListTypeLocalPlay_Music,           // 本地音乐
    AudioListTypeLocalPlay_SystemMusic,     // 本地系统音频
    AudioListTypeLoaclMake,                 // 本地录制音频
    AudioListTypeWeb                        // 网络音乐播放
};

// 音频类型
typedef NS_ENUM(NSInteger, YSAudioType)
{
    AudioType_SystemSound,
    AudioType_CustemSound,
    AudioType_Music
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
