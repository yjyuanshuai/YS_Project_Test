//
//  YSBluetooth.m
//  YS_LightBlue
//
//  Created by YJ on 17/6/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSBluetooth.h"
#import "YSBTCallBack.h"
#import "YSBTCentralManager.h"
#import "YSBTPeripheralManager.h"

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
        _ysBTCallBack = [[YSBTCallBack alloc] init];
    }
    return self;
}

#pragma mark - set block
- (void)setYSBTCenMana_UpdateStateBlock:(YSBTCenMan_UpdateStateBlock)block
{
    if (block) {
        _ysBTCallBack.updateStateBlock = block;
    }
}

- (void)setYSBTCenMan_DiscoverPeripheralBlock:(YSBTCenMan_DiscoverPeripheralBlock)block
{
    if (block) {
        _ysBTCallBack.discoverPeripheralBlock = block;
    }
}

- (void)setYSBTCenMan_DisconnectPeripheralBlock:(YSBTCenMan_DisconnectPeripheralBlock)block
{
    if (block) {
        _ysBTCallBack.disconnectPeripheralBlock = block;
    }
}

@end
