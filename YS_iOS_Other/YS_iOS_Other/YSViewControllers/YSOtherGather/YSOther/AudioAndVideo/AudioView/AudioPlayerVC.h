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
#import "GlobalEnum.h"

@interface AudioPlayerVC : YSRootViewController

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray * audioListArr;
@property (nonatomic, assign) YSAudioType audioType;
@property (nonatomic, strong) AVAudioPlayer * ysAudioPlayer;    // AudioPlayer

+ (AudioPlayerVC *)defaultAudioVC;
- (void)setAudioType:(YSAudioType)audioType
           audioList:(NSMutableArray *)audioList
        currentIndex:(NSInteger)currentIndex;

@end
