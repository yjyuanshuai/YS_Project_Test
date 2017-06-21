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
    if (_cenManCallBack.isDiscoverPeripherals) {
        [_cbCenManager scanForPeripheralsWithServices:cbuuids options:options];
    }
}

//- (void)ysConnectPeripheral:(CBPeripheral *)peripheral options:(NSDictionary *)options
//{
//    if (_cenManCallBack.isConnectPeripheral) {
//        NSLog(@">>>>>> ______ _cbCenManager connectPeripheral");
//        [_cbCenManager connectPeripheral:peripheral options:options];
//    }
//}

- (void)ysCenManStopScan
{
    if (_cbCenManager.isScanning) {
        [_cbCenManager stopScan];
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

            // 调用 scanForPeripheralsWithServices，扫描外设
            if (_cenManCallBack.isDiscoverPeripherals) {
                [self ysStartScanPeripheralsWithCBUUIDs:_cenManCallBack.discoverPerCBUUIDs options:_cenManCallBack.scanOptions];
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
//    NSLog(@">>>>>> ____ Bluetooth didDiscoverPeripheral");
    [_cbCenMan_discoverPers addObject:peripheral];

    if (_cenManCallBack.discoverPeripheralBlock) {
        _cenManCallBack.discoverPeripheralBlock(central, peripheral, advertisementData, RSSI);
    }

    // 调用 connectPeripheral，连接外设
    
}

/**
 连接外设
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>>>> ____ Bluetooth didConnectPeripheral");
    [_cbCenMan_connectPers addObject:peripheral];

    if (_cenManCallBack.connectPeripheralBlock) {
        NSLog(@">>>>>> ____ _cenManCallBack connectPeripheralBlock");
        _cenManCallBack.connectPeripheralBlock(central, peripheral);
    }

    if (_cenManCallBack.isDiscoverServices) {
        NSArray * cbuuids = nil;
        if ([_cenManCallBack.discoverServicesCBUUIDs count] > 0) {
            cbuuids = _cenManCallBack.discoverServicesCBUUIDs;
        }

        // 调用 discoverServices，扫描外设包含的服务
        [peripheral discoverServices:cbuuids];
        peripheral.delegate = self;
    }
}

/**
 连接失败
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@">>>>>> ____ Bluetooth didFailToConnectPeripheral");
    if (_cenManCallBack.failToConnectPeripheralBlock) {
        _cenManCallBack.failToConnectPeripheralBlock(central, peripheral, error);
    }
}

/**
 断开连接
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@">>>>>> ____ Bluetooth didDisconnectPeripheral");
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
    NSLog(@">>>>>> ____ Bluetooth didDiscoverServices");
    if (error) {
        NSLog(@">>>>>> Bluetooth discover service error!\n peripheral: %@ \n error: %@", peripheral.identifier.UUIDString, error.localizedDescription);
        return;
    }

    for (CBService * service in peripheral.services) {
        if (_cenManCallBack.discoverServicesBlock) {
            _cenManCallBack.discoverServicesBlock(peripheral, service, error);

            // 调用 discoverCharacteristics，扫描某个服务包含的特征
            if (_cenManCallBack.isDiscoverCharacters) {
                [peripheral discoverCharacteristics:_cenManCallBack.discoverCharactersCBUUIDs forService:service];
            }
        }
    }
}


/**
 发现子服务
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error
{

}

/**
 发现 Characteristics
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@">>>>>> ____ Bluetooth didDiscoverCharacteristicsForService");
    if (error) {
        NSLog(@">>>>>> Bluetooth discover character error!\n service: %@ \n error: %@", service.UUID, error.localizedDescription);
        return;
    }

    if (_cenManCallBack.discoverCharacteristicsBlock) {
        _cenManCallBack.discoverCharacteristicsBlock(peripheral, service, service.characteristics, error);
    }

    // 调用 readValueForCharacteristic，获取 / 更新特征

    // 调用 discoverDescriptorsForCharacteristic，扫描特征描述
}


/**
 读取 Characteristic 值
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    NSLog(@">>>>>> ____ Bluetooth didUpdateValueForCharacteristic");
    if (error) {
        NSLog(@">>>>>> Bluetooth update character error!\n peripheral: %@ \n error: %@", peripheral.identifier.UUIDString, error.localizedDescription);
        return;
    }

    if (_cenManCallBack.updateCharacteristicValueBlock) {
        _cenManCallBack.updateCharacteristicValueBlock(peripheral, characteristic, error);
    }
}


/**

 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{

}

/**
 发现 Characteristic Descriptors
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if (_cenManCallBack.discoverDescripitorsForCharacterBlock) {
        _cenManCallBack.discoverDescripitorsForCharacterBlock(peripheral, characteristic, error);
    }

    for (CBDescriptor * des in characteristic.descriptors) {
        // 调用 readValueForDescriptor，扫描特征的描述
        [peripheral readValueForDescriptor:des];
    }
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
