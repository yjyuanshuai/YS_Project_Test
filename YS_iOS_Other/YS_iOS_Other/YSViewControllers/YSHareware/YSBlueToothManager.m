//
//  YSBlueToothManager.m
//  YS_iOS_Other
//
//  Created by YJ on 17/5/18.
//  Copyright © 2017年 YJ. All rights reserved.
//

/***
 
 蓝牙开发分为中心者模式和管理者模式：
 
 1.常用的（其实99.99%）就是使用中心者模式作为开发，就是我们手机作为主机，连接蓝牙外设；
 2.管理者模式，这个基本用到的比较少，我们手机自己作为外设，自己创建服务和特征，然后有其他的设备连接我们的手机。
 
 NSLog(@"%s, line = %d, %@=连接成功", __FUNCTION__, __LINE__, peripheral.name);

 **/

#import "YSBlueToothManager.h"
#import "YSHudView.h"

@interface YSBlueToothManager() <CBCentralManagerDelegate, CBPeripheralDelegate>

/**
 中心模式
 */
@property (nonatomic, strong) CBCentralManager * cbManager;         // 中心管理者
@property (nonatomic, strong) NSMutableArray * cbPeripheralArr;     // 连接到的外设组 <CBPeripheral *>
@property (nonatomic, assign) CBManagerState cbManagerState;        // 蓝牙状态
@property (nonatomic, copy) NSString * peripheralContentStr;
@property (nonatomic, assign) YSCBPeripheralConStrType contentStrType;


/**
 外设模式（暂无）
 */

@end

@implementation YSBlueToothManager 

+ (instancetype)sharedBlueToothManager
{
    static YSBlueToothManager * instance = nil;
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
        _cbManager          = nil;
        _cbManagerState     = CBManagerStateUnknown;
        _cbPeripheralArr    = [NSMutableArray arrayWithCapacity:0];
        _contentStrType     = YSCBPeripheralConStrType_None;
        _peripheralContentStr = @"";
    }
    return self;
}

#pragma mark - init 中心者模式
- (CBCentralManager *)obtainCBManager
{
    if (!_cbManager) {
        _cbManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _cbManager;
}

- (void)cbManagerStartScan
{
    // 搜索成功之后,会调用我们找到外设的代理方法
    // - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;

    if (!_cbManager) {
        _cbManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }

    switch (_cbManagerState) {
        case CBManagerStateUnknown:
        case CBManagerStateResetting:
        case CBManagerStateUnauthorized:
        {

        }
            break;
        case CBManagerStateUnsupported:     // 不支持蓝牙
        {
            [YSHudView yiBaoHUDStopOrShowWithMsg:@"该设备不支持蓝牙" finsh:nil];
        }
            break;
        case CBManagerStatePoweredOff:      // 蓝牙未开启
        {
            [YSHudView yiBaoHUDStopOrShowWithMsg:@"蓝牙未开启" finsh:nil];
        }
            break;
        case CBManagerStatePoweredOn:       // 蓝牙已开启
        {
            [_cbManager scanForPeripheralsWithServices:nil
                                               options:nil];
        }
            break;
        default:
            break;
    }
}

- (void)cbManagerStopScanAndDisconnectAllServices
{
    if (_cbManager) {
        [_cbManager stopScan];
        if ([_cbPeripheralArr count] > 0) {
            for (CBPeripheral * per in _cbPeripheralArr) {
                [_cbManager cancelPeripheralConnection:per];
            }
        }
    }
}

- (CBManagerState)obtainCBManagerState
{
    return _cbManagerState;
}

//停止扫描并断开连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager
                 peripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}

//设置通知
-(void)notifyPeripheral:(CBPeripheral *)peripheral
         characteristic:(CBCharacteristic *)characteristic{
    NSLog(@"Notify %lu", (unsigned long)characteristic.properties);

    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
}

//取消通知
-(void)cancelNotifyPeripheral:(CBPeripheral *)peripheral
               characteristic:(CBCharacteristic *)characteristic{

    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{

    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知知道这几个基本就够用了，前连个是读写权限，后两个都是通知，两种不同的通知方式。
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast                                              = 0x01,
     CBCharacteristicPropertyRead                                                   = 0x02,
     CBCharacteristicPropertyWriteWithoutResponse                                   = 0x04,
     CBCharacteristicPropertyWrite                                                  = 0x08,
     CBCharacteristicPropertyNotify                                                 = 0x10,
     CBCharacteristicPropertyIndicate                                               = 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites                              = 0x40,
     CBCharacteristicPropertyExtendedProperties                                     = 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)    = 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)  = 0x200
     };
     */

    NSLog(@"write %lu", (unsigned long)characteristic.properties);

    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }else{
        NSLog(@"该字段不可写！");
    }
}

- (void)setPeripheralContentStr:(NSString *)contentStr
                    contentType:(YSCBPeripheralConStrType)contentType
{
    _contentStrType = contentType;
    _peripheralContentStr = contentStr;
}

#pragma mark - 外设模式（暂无）

#pragma mark - CBCentralManagerDelegate
/**
 判断蓝牙状态
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    _cbManagerState = central.state;
}


/**
 搜索外围设备

 @param central 中心管理者
 @param peripheral 外设
 @param advertisementData 外设携带的数据
 @param RSSI 外设发出的蓝牙信号强度
 */
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *, id> *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    DDLogInfo(@"---------- 发现设备：%@ -------\t uuid：%@", peripheral.name, peripheral.identifier.UUIDString);
    [_cbPeripheralArr addObject:peripheral];


    if ([_peripheralContentStr isEqualToString:@""] ||
        _peripheralContentStr == nil ||
        _contentStrType == YSCBPeripheralConStrType_None) {

        [central connectPeripheral:peripheral options:nil];
    }
    else {
        switch (_contentStrType) {
            case YSCBPeripheralConStrType_Prefix:
            {
                if ([peripheral.name hasPrefix:_peripheralContentStr]) {
                    [central connectPeripheral:peripheral options:nil];
                }
            }
                break;
            case YSCBPeripheralConStrType_SufFix:
            {
                if ([peripheral.name hasSuffix:_peripheralContentStr]) {
                    [central connectPeripheral:peripheral options:nil];
                }
            }
                break;
            case YSCBPeripheralConStrType_SubStr:
            {
                if ([peripheral.name containsString:_peripheralContentStr]) {
                    [central connectPeripheral:peripheral options:nil];
                }
            }
                break;

            default:
                break;
        }
    }

}

/**
 连接外设
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    DDLogInfo(@"-----------%@ = 连接成功", peripheral.name);

    peripheral.delegate = self;

    // 外设发现服务,传nil代表不过滤
    // 这里会触发外设的代理方法 - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
    [peripheral discoverServices:nil];
}


/**
 连接外设失败
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    DDLogInfo(@"-----------%@ = 连接失败", peripheral.name);
}


/**
 丢失连接
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    DDLogInfo(@"-----------%@ = 断开连接", peripheral.name);
}

#pragma mark - CBPeripheralDelegate
/**
 获取外设服务
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"peropheral name: %@ error: %@", peripheral.name, error.localizedDescription);
        return;
    }

    for (CBService * service in peripheral.services) {
//        NSLog(@"%@",service.UUID);
//        if ([service.UUID.UUIDString isEqualToString:@"1000"]) {
            //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
            [peripheral discoverCharacteristics:nil forService:service];
//        }
    }
}

/**
 获取服务的特征

 发现外设服务里的特征的时候调用的代理方法(这个是比较重要的方法，你在这里可以通过事先知道UUID找到你需要的特征，订阅特征，或者这里写入数据给特征也可以)
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic * cha in service.characteristics) {
//        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID, cha.UUID);
//        NSLog(@"%s, line = %d, char = %@", __FUNCTION__, __LINE__, cha);
    }

    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        [peripheral readValueForCharacteristic:characteristic];
    }

    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//    for (CBCharacteristic *characteristic in service.characteristics){
//        [peripheral discoverDescriptorsForCharacteristic:characteristic];
//    }
}

/**
 从外围设备读取数据
 更新特征的value的时候会调用 （凡是从蓝牙传过来的数据都要经过这个回调，简单的说这个方法就是你拿数据的唯一方法） 你可以判断是否
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{

//    if (characteristic == @"你要的特征的UUID或者是你已经找到的特征") {
        //characteristic.value就是你要的数据
//    }
}

//搜索到Characteristic的Descriptors
//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//{
//
//}

@end
