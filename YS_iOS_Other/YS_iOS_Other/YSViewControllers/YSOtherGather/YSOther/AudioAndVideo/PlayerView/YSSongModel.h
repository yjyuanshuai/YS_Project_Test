//
//  YSSongModel.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalEnum.h"

@interface YSSongModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString * name;              //
@property (nonatomic, copy) NSString * expandType;        // 文件扩展名
@property (nonatomic, copy) NSString * url;
@property (nonatomic, assign) BOOL hasDownload;           // 本地是否缓存
@property (nonatomic, copy) NSString * songerName;
@property (nonatomic, assign) YSAudioType audioType;        // 文件类型（系统音效、自定义音效）

- (instancetype)initWithWebSongDic:(NSDictionary *)dic;

@end
