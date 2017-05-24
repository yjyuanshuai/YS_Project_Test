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

#pragma mark - Peripheral Model
@implementation YSPeripheralModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _perType = YSPeripheralType_Per;
        _perName = @"";
        _perSignStrength = @"0";
        _perServicesNum = @"0";
        _perWorking = NO;
        _per = nil;
        _perDataDic = nil;
    }
    return self;
}

// 中心者模式调用
- (instancetype)initWithCBPeripheral:(CBPeripheral *)per
                                rssi:(NSNumber *)rssi
                                data:(NSDictionary *)dictData
{
    self = [super init];
    if (self) {
        _per = per;
        _perType = YSPeripheralType_Per;
        _perName = [NSString stringWithFormat:@"%@", per.name];
        _perSignStrength = [NSString stringWithFormat:@"%@", rssi];
        _perServicesNum = [NSString stringWithFormat:@"%ld", (long)[per.services count]];
        _perDataDic = dictData;

        if (per.state == CBPeripheralStateConnected) {
            _perWorking = YES;
        }
        else {
            _perWorking = NO;
        }
    }
    return self;
}

@end


#pragma mark - Bluetooth Manager
@interface YSBlueToothManager() <CBCentralManagerDelegate, CBPeripheralDelegate, CBPeripheralManagerDelegate>

/**
 中心模式
 */
@property (nonatomic, strong) CBCentralManager * cbCenManager;         // 中心管理者
@property (nonatomic, strong) NSMutableArray * cbCenPeripheralArr;     // 连接到的外设组 <CBPeripheral *>
@property (nonatomic, assign) CBManagerState cbCenManagerState;        // 蓝牙状态
@property (nonatomic, copy) NSString * cbCenPerContentStr;
@property (nonatomic, assign) YSCBPeripheralConStrType cbCenContentStrType;


/**
 外设模式（暂无）
 */
@property (nonatomic, strong) CBPeripheralManager * cbPerManager;   // 外设模式
@property (nonatomic, strong) NSMutableArray * cbPerCentralArr;        // 被连接到的中心者 <CBCentral *>
@property (nonatomic, assign) CBPeripheralManagerState cbPerManagerState;

@end

@implementation YSBlueToothManager

+ (instancetype)sharedYSBlueToothManager
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
        _cbCenManager          = nil;
        _cbCenManagerState     = CBManagerStateUnknown;
        _cbCenPeripheralArr    = [NSMutableArray arrayWithCapacity:0];
        _cbCenContentStrType     = YSCBPeripheralConStrType_None;
        _cbCenPerContentStr = @"";

        _cbPerManager       = nil;
        _cbPerManagerState  = CBPeripheralManagerStateUnknown;
        _cbPerCentralArr    = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

#pragma mark - 中心者模式
/**
    检查蓝牙状态
 */
- (CBManagerState)obtainCBManagerState
{
    return _cbCenManagerState;
}


/**
    中心者
 */
- (CBCentralManager *)cbCenManager
{
    if (!_cbCenManager) {
        _cbCenManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _cbCenManager;
}


/**
    开始扫描
 */
- (void)cbManagerStartScan
{
    // 搜索成功之后,会调用我们找到外设的代理方法
    // - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;

    if (!_cbCenManager) {
        _cbCenManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }

    switch (_cbCenManagerState) {
        case CBManagerStateUnknown:
        case CBManagerStateResetting:
        case CBManagerStateUnauthorized:
        {
            NSLog(@"------ Bluetooth State Unknow");
        }
            break;
        case CBManagerStateUnsupported:     // 不支持蓝牙
        {
            NSLog(@"------ Bluetooth State Unsupported");
        }
            break;
        case CBManagerStatePoweredOff:      // 蓝牙未开启
        {
            NSLog(@"------ Bluetooth State Off");
        }
            break;
        case CBManagerStatePoweredOn:       // 蓝牙已开启
        {
            NSLog(@"------ Bluetooth State On");
            [_cbCenManager scanForPeripheralsWithServices:nil
                                               options:nil];
        }
            break;
        default:
            break;
    }
}


/**
    连接外设
 */
- (void)cbManagerConnectWithPeripheral:(CBPeripheral *)per
{
    if (_cbCenManager) {
        [_cbCenManager connectPeripheral:per options:nil];
    }
}


/**
    停止扫描、断开所有连接
 */
- (void)cbManagerStopScanAndDisconnectAllServices
{
    if (_cbCenManager) {
        [_cbCenManager stopScan];
        if ([_cbCenPeripheralArr count] > 0) {
            for (CBPeripheral * per in _cbCenPeripheralArr) {
                [_cbCenManager cancelPeripheralConnection:per];
            }
        }
        [_cbCenPeripheralArr removeAllObjects];
    }
}


/**
    设置扫描条件

    @param contentStr   筛选条件字符串
    @param contentType  筛选类型
 */
- (void)setcbCenPerContentStr:(NSString *)contentStr
                    contentType:(YSCBPeripheralConStrType)contentType
{
    _cbCenContentStrType = contentType;
    _cbCenPerContentStr = contentStr;
}

#pragma mark - 外设模式
- (CBPeripheralManager *)cbPerManager
{
    if (!_cbPerManager) {
        _cbPerManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    return _cbPerManager;
}
/*
- (void)cbPerManagerSetCharacteristic
{
    // characteristic 字段描述
    CBUUID * CBUUIDCharacteristic = [CBUUID UUIDWithString:CBUUIDCharacteristicUserDescriptionString];

    // 可通知的 Characteristic
    CBMutableCharacteristic * notifyCharacteristc = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:notifyCharacteristcUUID] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];

    // 可读写
    CBMutableCharacteristic *readwriteCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readwriteCharacteristicUUID] properties:CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable | CBAttributePermissionsWriteable];

    // 设置description
    CBMutableDescriptor *readwriteCharacteristicDescription1 = [[CBMutableDescriptor alloc]initWithType: CBUUIDCharacteristic value:@"name"];
    [readwriteCharacteristic setDescriptors:@[readwriteCharacteristicDescription1]];

    // 只读
    CBMutableCharacteristic *readCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readCharacteristicUUID] properties:CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];

    //service1初始化并加入两个characteristics
    CBMutableService *service1 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID1] primary:YES];
    [service1 setCharacteristics:@[notiyCharacteristic,readwriteCharacteristic]];

    //service2初始化并加入一个characteristics
    CBMutableService *service2 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID2] primary:YES];
    [service2 setCharacteristics:@[readCharacteristic]];

    //添加后就会调用代理的- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
    [peripheralManager addService:service1];
    [peripheralManager addService:service2];
}
*/
#pragma mark - CBCentralManagerDelegate
/**
 判断蓝牙状态
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    _cbCenManagerState = central.state;
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
    NSLog(@"---------- 发现设备：%@ -------\t uuid：%@", peripheral.name, peripheral.identifier.UUIDString);

    if ([_cbCenPerContentStr isEqualToString:@""] ||
        _cbCenPerContentStr == nil ||
        _cbCenContentStrType == YSCBPeripheralConStrType_None) {

        [self checkHasAddedAndConnect:central peripheral:peripheral rssi:RSSI data:advertisementData];
    }
    else {
        switch (_cbCenContentStrType) {
            case YSCBPeripheralConStrType_Prefix:
            {
                if ([peripheral.name hasPrefix:_cbCenPerContentStr]) {
                    [self checkHasAddedAndConnect:central peripheral:peripheral rssi:RSSI data:advertisementData];
                }
            }
                break;
            case YSCBPeripheralConStrType_SufFix:
            {
                if ([peripheral.name hasSuffix:_cbCenPerContentStr]) {
                    [self checkHasAddedAndConnect:central peripheral:peripheral rssi:RSSI data:advertisementData];
                }
            }
                break;
            case YSCBPeripheralConStrType_SubStr:
            {
                if ([peripheral.name rangeOfString:_cbCenPerContentStr].location != NSNotFound) {
                    [self checkHasAddedAndConnect:central peripheral:peripheral rssi:RSSI data:advertisementData];
                }
            }
                break;

            default:
                break;
        }
    }
}

// 自定义
- (void)checkHasAddedAndConnect:(CBCentralManager *)central
                     peripheral:(CBPeripheral *)per
                           rssi:(NSNumber *)rssi
                           data:(NSDictionary *)data
{
    YSPeripheralModel * model = [[YSPeripheralModel alloc] initWithCBPeripheral:per rssi:rssi data:data];

    if (![_cbCenPeripheralArr containsObject:model]) {

        [_cbCenPeripheralArr addObject:model];

        if (_delegate && [_delegate respondsToSelector:@selector(discoverNewPeripheral:)]) {
            [_delegate discoverNewPeripheral:model];
        }
    }
}

/**
 连接外设
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"-----------%@ = 连接成功", peripheral.name);

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
    NSLog(@"-----------%@ = 连接失败", peripheral.name);
}

/**
 丢失连接
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@"-----------%@ = 断开连接", peripheral.name);
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



#pragma mark - CBPeripheralManagerDelegate

//peripheralManager状态改变
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    _cbPerManagerState = (CBPeripheralManagerState)peripheral.state;
}

// 添加 service
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (error) {
        NSLog(@"-------- bluetooth add service error!");
    }

    //添加服务后可以在此向外界发出通告 调用完这个方法后会调用代理的
    //(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
//    [peripheral startAdvertising:@{CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:ServiceUUID1],[CBUUID UUIDWithString:ServiceUUID2]],
//                                   CBAdvertisementDataLocalNameKey : LocalNameKey
//                                          }
//     ];
}

// 发动 adveristing
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{

}

// 订阅 characteristic
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"------ 订阅了 %@ 的数据", characteristic.UUID);

    // 可以在此发送数据
}

// 取消订阅 characteristic
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"------ 取消订阅 %@ 的数据", characteristic.UUID);

    // 再次取消发送
}

// 读 characteristics 请求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
    //判断是否有读数据的权限
    if (request.characteristic.properties & CBCharacteristicPropertyRead) {
        NSData *data = request.characteristic.value;
        [request setValue:data];
        //对请求作出成功响应
        [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
    }else{
        [peripheral respondToRequest:request withResult:CBATTErrorWriteNotPermitted];
    }
}

// 写 characteristics 请求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests
{
    CBATTRequest *request = requests[0];
    //判断是否有写数据的权限
    if (request.characteristic.properties & CBCharacteristicPropertyWrite) {
        //需要转换成CBMutableCharacteristic对象才能进行写值
        CBMutableCharacteristic * c =(CBMutableCharacteristic *)request.characteristic;
        c.value = request.value;
        [peripheral respondToRequest:request withResult:CBATTErrorSuccess];
    }else{
        [peripheral respondToRequest:request withResult:CBATTErrorWriteNotPermitted];
    }
}

#pragma mark -
//设置通知
-(void)notifyPeripheral:(CBPeripheral *)peripheral
         characteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"Notify %lu", (unsigned long)characteristic.properties);

    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
}

//取消通知
-(void)cancelNotifyPeripheral:(CBPeripheral *)peripheral
               characteristic:(CBCharacteristic *)characteristic
{

    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value
{
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

@end
