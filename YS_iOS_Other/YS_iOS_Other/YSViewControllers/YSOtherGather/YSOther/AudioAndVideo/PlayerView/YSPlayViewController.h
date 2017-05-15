//
//  YSPlayViewController.h
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"
@class YSSongModel;

typedef NS_ENUM(NSInteger, AudioType)
{
    AudioTypeWeb,       //
    AudioTypeLocal      //
};

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

@interface YSPlayViewController : YSRootViewController

- (instancetype)initWithAudioType:(AudioType)type
                             list:(NSMutableArray *)listArr
                     currentIndex:(NSInteger)currentIndex;

@end
