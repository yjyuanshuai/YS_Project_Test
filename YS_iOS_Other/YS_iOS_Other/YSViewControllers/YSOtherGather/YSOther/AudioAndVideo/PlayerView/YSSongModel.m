//
//  YSSongModel.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSongModel.h"

@implementation YSSongModel

- (instancetype)initWithWebSongDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _name           = dic[@"name"];
        _expandType     = dic[@"expand"];
        _url            = dic[@"url"];
        _hasDownload    = dic[@"hasdownlaod"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.expandType forKey:@"expand"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:@(self.hasDownload) forKey:@"hasdownlaod"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.name           = [aDecoder decodeObjectForKey:@"name"];
        self.expandType     = [aDecoder decodeObjectForKey:@"expand"];
        self.url            = [aDecoder decodeObjectForKey:@"url"];
        self.hasDownload    = [[aDecoder decodeObjectForKey:@"hasdownlaod"] boolValue];
    }
    return self;
}

@end
