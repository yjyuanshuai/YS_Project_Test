//
//  YSiQiYiPlayBtn.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/9/20.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YSiQiYiPlayBtnStatus)
{
    YSiQiYiPlayBtnStatusPlay,
    YSiQiYiPlayBtnStatusPause
};

@interface YSiQiYiPlayBtn : UIButton

@property (nonatomic, assign) YSiQiYiPlayBtnStatus status;

@end
