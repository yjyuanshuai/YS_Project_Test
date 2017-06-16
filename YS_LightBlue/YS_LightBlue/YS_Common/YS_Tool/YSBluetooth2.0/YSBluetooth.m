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
        
    }
    return self;
}

- (YSBTCentralManager *)getYSBTCenManager
{
    if (!_ysBTCenManager) {
        _ysBTCenManager = [[YSBTCentralManager alloc] init];
    }
    return _ysBTCenManager;
}

#pragma mark - set block
- (void)setYSBTCenMan_UpdateStateBlock:(YSBTCenMan_UpdateStateBlock)block
{
    [self getYSBTCenManager];
    if (block) {
        _ysBTCenManager.cenManCallBack.updateStateBlock = block;
    }
}

- (void)ysBTCenManStartScanWithCBUUIDs:(NSArray <CBUUID *> *)cbuuids
                                option:(NSDictionary *)option
                   discoverPeripherals:(YSBTCenMan_DiscoverPeripheralBlock)block
{
    [self getYSBTCenManager];
    _ysBTCenManager.cenManCallBack.isStartScan = YES;
    if (!cbuuids) {
        _ysBTCenManager.cenManCallBack.CBUUIDS = cbuuids;
    }
    if (!option) {
        _ysBTCenManager.cenManCallBack.option = option;
    }
    if (block) {
        _ysBTCenManager.cenManCallBack.discoverPeripheralBlock = block;
    }
}

- (void)setYSBTCenMan_DisconnectPeripheralBlock:(YSBTCenMan_DisconnectPeripheralBlock)block
{
    [self getYSBTCenManager];
    if (block) {
        _ysBTCenManager.cenManCallBack.disconnectPeripheralBlock = block;
    }
}

#pragma mark - set



@end
