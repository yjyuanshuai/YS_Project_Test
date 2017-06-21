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

+ (YSBluetooth *)ysBTCenMan_ConnectPeripheralSuccessBlock:(YSBTCenMan_ConnectPeripheralBlock)successblock
                           failBlock:(YSBTCenMan_FailToConnectPeripheralBlock)failBlock
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.isConnectPeripheral = YES;
    cenMan.cenManCallBack.connectPeripheralBlock = successblock;
    cenMan.cenManCallBack.failToConnectPeripheralBlock = failBlock;
    return [YSBluetooth sharesYSBluetooth];
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

// 发现特征
+ (void)ysBTCenMan_DiscoverCharactersWithCBUUIDs:(NSArray *)cbuuids
                         discoverCharactersBlock:(YSBTCenMan_DiscoverCharacteristicsBlock)block
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.isDiscoverCharacters = YES;
    cenMan.cenManCallBack.discoverCharactersCBUUIDs = cbuuids;
    cenMan.cenManCallBack.discoverCharacteristicsBlock = block;
}

// 读取特征
+ (YSBluetooth *)ysBRCenMan_ReadCharactersBlock:(YSBTCenMan_UpdateValueForCharacteristicBlock)block
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.isUpdateCharacterValue = YES;
    cenMan.cenManCallBack.updateCharacteristicValueBlock = block;
    return [YSBluetooth sharesYSBluetooth];
}

// 特征描述
+ (YSBluetooth *)ysBTCenMan_DiscoverDescriptForCharacterBlock:(YSBTCenMan_DiscoverDescriptorsForCharacteristicBlock)block
{
    YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
    cenMan.cenManCallBack.isDiscoverDescreptionForCharacter = YES;
    return [YSBluetooth sharesYSBluetooth];
}

#pragma mark - 链式函数
- (YSBluetooth * (^)(NSDictionary * options, YSPeripheralModel * peripheral))beginConnnected
{
    YSBluetooth * (^beginConnect)(NSDictionary * options, YSPeripheralModel * peripheral) = ^(NSDictionary * options, YSPeripheralModel * peripheral){

        YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
        if (cenMan.cenManCallBack.isConnectPeripheral && peripheral && peripheral.cbPeripheral) {
            [cenMan ysCenManStopScan];
            [cenMan ysConnectPeripheral:peripheral.cbPeripheral options:options];
        }
        else {
            NSLog(@"------ %s connect peripheral error!", __func__);
        }
        return self;
    };
    return beginConnect;
}

- (YSBluetooth * (^)(CBPeripheral * per, CBCharacteristic * character))updateCharacterValue
{
    YSBluetooth * (^updateCharacterBlock)() = ^(CBPeripheral * per, CBCharacteristic * character){
        YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
        if (cenMan.cenManCallBack.isUpdateCharacterValue) {
            [cenMan ysUpdateCharacterValue:per character:character];
        }
        else {
            NSLog(@"------ %s update characteristic error!", __func__);
        }
        return self;
    };
    return updateCharacterBlock;
}

- (YSBluetooth * (^)(CBPeripheral * per, CBCharacteristic * character))discoverDescriptForCharacter
{
    YSBluetooth * (^discoverCharaterBlock)() = ^(CBPeripheral * per, CBCharacteristic * character){
        YSBTCentralManager * cenMan = [[YSBluetooth sharesYSBluetooth] getYSBTCenManager];
        if (cenMan.cenManCallBack.isDiscoverDescreptionForCharacter && per) {
            [cenMan ysDiscoverDesciptForCharacteristic:character peripheral:per];
        }
        else {
            NSLog(@"------ %s discover characteristic descript error!", __func__);
        }
        return self;
    };
    return discoverCharaterBlock;
}



@end
