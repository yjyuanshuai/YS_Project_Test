//
//  YSBTCentralManager.m
//  YS_LightBlue
//
//  Created by YJ on 17/6/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSBTCentralManager.h"
#import "YSBTDefine.h"
#import "YSBTCallBack.h"

@interface YSBTCentralManager() <CBCentralManagerDelegate, CBPeripheralDelegate>

@end

@implementation YSBTCentralManager

- (instancetype)init
{
    self = [super init];
    if (self) {

        NSDictionary * options = nil;

#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_6_0
        options = @{CBCentralManagerOptionShowPowerAlertKey:@(YES),     //蓝牙power没打开时alert提示框
                    CBCentralManagerOptionRestoreIdentifierKey:YSBluetoothRestore};     // 重设centralManager恢复的IdentifierKey
#else
        options = nil;
#endif

        NSArray * backgroundModes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UIBackgroundModes"];
        if ([backgroundModes containsObject:@"bluetooth-central"]) {
            // 后台模式
            _cbCenManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];
        }
        else {
            // 非后台
            _cbCenManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        }

        _cenManCallBack = [[YSBTCallBack alloc] init];
        _cbCenMan_discoverPers = [NSMutableArray array];
        _cbCenMan_connectPers = [NSMutableArray array];
    }
    return self;
}
#pragma mark - private
- (void)ysStartScanPeripheralsWithCBUUIDs:(NSArray *)cbuuids options:(NSDictionary *)options
{
    if (_cenManCallBack.isStartScan) {
        [_cbCenManager scanForPeripheralsWithServices:cbuuids options:options];
    }
}

- (void)ysConnectPeripheral:(CBPeripheral *)peripheral options:(NSDictionary *)options
{
    if (_cenManCallBack.isConnectPeripheral) {
        [_cbCenManager connectPeripheral:peripheral options:options];
    }
}



#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBManagerStatePoweredOff:
        {
            NSLog(@">>>>>> Bluetooth PowerOff");
        }
            break;

        case CBManagerStatePoweredOn:
        {
            NSLog(@">>>>>> Bluetooth PowerOn.");
            if (_cenManCallBack.isStartScan) {
                [self ysStartScanPeripheralsWithCBUUIDs:_cenManCallBack.CBUUIDS options:_cenManCallBack.scanOptions];
            }
        }
            break;
            
        default:
            NSLog(@">>>>>> Bluetooth State Is not On/Off.");
            break;
    }

    if (_cenManCallBack.updateStateBlock) {
        _cenManCallBack.updateStateBlock(central);
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *,id> *)dict
{
    // [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options] 必需
}

/**
 发现外设

 @param advertisementData 数据
 @param RSSI 信号量
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    [_cbCenMan_discoverPers addObject:peripheral];

    if (_cenManCallBack.discoverPeripheralBlock) {
        _cenManCallBack.discoverPeripheralBlock(central, peripheral, advertisementData, RSSI);
    }


}

/**
 连接外设
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [_cbCenMan_connectPers addObject:peripheral];

    if (_cenManCallBack.connectPeripheralBlock) {
        _cenManCallBack.connectPeripheralBlock(central, peripheral);
    }

    peripheral.delegate = self;
}


/**
 连接失败
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    if (_cenManCallBack.failToConnectPeripheralBlock) {
        _cenManCallBack.failToConnectPeripheralBlock(central, peripheral, error);
    }
}


/**
 断开连接
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    if (_cenManCallBack.disconnectPeripheralBlock) {
        _cenManCallBack.disconnectPeripheralBlock(central, peripheral, error);
    }
}

#pragma mark - CBPeripheralDelegate
/**
 发现 Services
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{

}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error
{

}

/**
 发现 Characteristics
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{

}


/**
 读取 Characteristic 值
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{

}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{

}

/**
 发现 Characteristic Descriptors
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{

}

/**
 读取 Characteristic Descriptors
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error
{

}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error
{

}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{

}

- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{

}

@end
