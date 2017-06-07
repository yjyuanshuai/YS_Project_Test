//
//  YSBluetooth.m
//  YS_LightBlue
//
//  Created by YJ on 17/6/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSBluetooth.h"

@implementation YSBluetooth

+ (instancetype)sharesYSBluetooth
{
    static YSBluetooth * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

@end
