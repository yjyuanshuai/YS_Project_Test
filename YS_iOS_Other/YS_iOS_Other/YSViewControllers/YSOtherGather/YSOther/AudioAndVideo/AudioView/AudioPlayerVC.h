//
//  AudioPlayerVC.h
//  YS_iOS_Other
//
//  Created by YJ on 16/11/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

/**
 *  音频播放
 */

#import "YSRootViewController.h"
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, AudioPlaySetting)
{
    AudioPlaySettingList,   // 按序播放
    AudioPlaySettingAny,    // 随机播放
    AudioPlaySettingOne     // 单首循环
};

typedef NS_ENUM(NSInteger, AudioPlayStatus)
{
    AudioPlayStatusPlaying,     // 正在播放
    AudioPlayStatusPause        // 暂停
};

@interface AudioPlayerVC : YSRootViewController

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) AVAudioPlayer * ysAudioPlayer;

+ (AudioPlayerVC *)defaultAudioVC;

@end
