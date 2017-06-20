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
#import "YSBluetoothModel.h"

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
// 外设
+ (void)ysBTCenMan_UpdateStateBlock:(YSBTCenMan_UpdateStateBlock)block
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.updateStateBlock = block;
}

+ (void)ysBTCenMan_StartScanWithCBUUIDs:(NSArray <CBUUID *> *)cbuuids
                                   options:(NSDictionary *)options
                       discoverPeripherals:(YSBTCenMan_DiscoverPeripheralBlock)block
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.isDiscoverPeripherals = YES;
    cenMan.cenManCallBack.discoverPerCBUUIDs = cbuuids;
    cenMan.cenManCallBack.scanOptions = options;
    cenMan.cenManCallBack.discoverPeripheralBlock = block;
}

+ (void)ysBTCenMan_ConnectPeripheral:(YSPeripheralModel *)peripheral
                             options:(NSDictionary *)options
                        successBlock:(YSBTCenMan_ConnectPeripheralBlock)successblock
                           failBlock:(YSBTCenMan_FailToConnectPeripheralBlock)failBlock
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];

    if (peripheral && peripheral.cbPeripheral) {
        cenMan.cenManCallBack.isConnectPeripheral = YES;
        [cenMan ysConnectPeripheral:peripheral.cbPeripheral options:options];
    }
    
    cenMan.cenManCallBack.connectPeripheralBlock = successblock;
    cenMan.cenManCallBack.failToConnectPeripheralBlock = failBlock;
}

+ (void)ysBTCenMan_DisconnectPeripheralBlock:(YSBTCenMan_DisconnectPeripheralBlock)block
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.disconnectPeripheralBlock = block;
}

// 服务
+ (void)ysBTCenMan_DiscoverServicesWithCBUUIDs:(NSArray *)cbuuids
                         discoverServicesBlock:(YSBTCenMan_DiscoverServicesBlock)block
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.isDiscoverServices = YES;
    cenMan.cenManCallBack.discoverServicesCBUUIDs = cbuuids;
    cenMan.cenManCallBack.discoverServicesBlock = block;
}

// 特征
+ (void)ysBTCenMan_DiscoverCharactersWithCBUUIDs:(NSArray *)cbuuids
                         discoverCharactersBlock:(YSBTCenMan_DiscoverCharacteristicsBlock)block
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.isDiscoverCharacters = YES;
    cenMan.cenManCallBack.discoverCharactersCBUUIDs = cbuuids;
    cenMan.cenManCallBack.discoverCharacteristicsBlock = block;
}

#pragma mark - set



@end
