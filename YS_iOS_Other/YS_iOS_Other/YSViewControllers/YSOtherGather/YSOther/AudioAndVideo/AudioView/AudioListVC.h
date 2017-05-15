//
//  LocalAudioPlayerVC.h
//  YS_iOS_Other
//
//  Created by YJ on 16/11/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

typedef NS_ENUM(NSInteger, AudioListType)
{
    AudioListTypeLocalPlay_SystemSound,     // 本地播放音效
    AudioListTypeLocalPlay_Music,           // 本地音乐
    AudioListTypeLocalPlay_SystemMusic,     // 本地系统音乐
    AudioListTypeLoaclMake,                 // 本地录制音频
    AudioListTypeWeb                        // 网络音乐播放
};

@interface AudioListVC : YSRootViewController

- (instancetype)initWithTitle:(NSString *)title audioListType:(AudioListType)type;

@end
