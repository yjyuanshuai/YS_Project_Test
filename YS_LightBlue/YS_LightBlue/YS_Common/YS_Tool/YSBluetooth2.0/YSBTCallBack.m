//
//  YSBTCallBack.m
//  YS_LightBlue
//
//  Created by YJ on 17/6/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSBTCallBack.h"

static NSString * YSBTPerManCallBackKey = @"YSBTPerManCallBackKey";
static NSString * YSBTCenManCallBackKey = @"YSBTCenManCallBackKey";

@implementation YSBTCallBack

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isStartScan = NO;
        _CBUUIDS = nil;
        _scanOptions = nil;
        _connectPeripheralOptions = nil;
    }
    return self;
}



@end
