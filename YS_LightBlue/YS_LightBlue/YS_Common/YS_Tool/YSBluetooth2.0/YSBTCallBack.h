//
//  YSBTCallBack.h
//  YS_LightBlue
//
//  Created by YJ on 17/6/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

// ---------- block 定义 ---------- //
// 外设
typedef void(^YSBTCenMan_UpdateStateBlock)(CBCentralManager * central);
typedef void(^YSBTCenMan_DiscoverPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSDictionary * advertisementData, NSNumber * rssi);
typedef void(^YSBTCenMan_ConnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral);
typedef void(^YSBTCenMan_FailToConnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSError * error);
typedef void(^YSBTCenMan_DisconnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSError * error);
// 服务
typedef void(^YSBTCenMan_DiscoverServicesBlock)(CBPeripheral * peripheral, CBService * service, NSError * error);
//typedef void(^YSBTCenMan_DiscoverIncludedServicesBlock)(CBPeripheral * peripheral, CBService * service, NSError * error);
// 特征
typedef void(^YSBTCenMan_DiscoverCharacteristicsBlock)(CBPeripheral * peripheral, CBService * service, NSArray * charactersArr, NSError * error);
typedef void(^YSBTCenMan_UpdateValueForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
//typedef void(^YSBTCenMan_WriteValueForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
typedef void(^YSBTCenMan_DiscoverDescriptorsForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);











//typedef void(^YSBTCenMan_UpdateValueForDescriptorBlock)(CBPeripheral * peripheral, CBDescriptor * descriptor, NSError * error);
//typedef void(^YSBTCenMan_WriteValueForDescriptorBlock)(CBPeripheral * peripheral, CBDescriptor * descriptor, NSError * error);
typedef void(^YSBTCenMan_UpdateNotificationStateForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
//typedef void(^YSBTCenMan_)();


@interface YSBTCallBack : NSObject

#pragma mark - cen property
@property (nonatomic, assign) BOOL isDiscoverPeripherals;
@property (nonatomic, strong) NSArray * discoverPerCBUUIDs;
@property (nonatomic, strong) NSDictionary * scanOptions;

@property (nonatomic, assign) BOOL isConnectPeripheral;
@property (nonatomic, strong) NSDictionary * connectPeripheralOptions;

@property (nonatomic, assign) BOOL isDiscoverServices;
@property (nonatomic, strong) NSArray * discoverServicesCBUUIDs;

@property (nonatomic, assign) BOOL isDiscoverCharacters;
@property (nonatomic, strong) NSArray * discoverCharactersCBUUIDs;

#pragma mark - cen delegate block
@property (nonatomic, strong) YSBTCenMan_UpdateStateBlock               updateStateBlock;
@property (nonatomic, strong) YSBTCenMan_DiscoverPeripheralBlock        discoverPeripheralBlock;
@property (nonatomic, strong) YSBTCenMan_ConnectPeripheralBlock         connectPeripheralBlock;
@property (nonatomic, strong) YSBTCenMan_FailToConnectPeripheralBlock   failToConnectPeripheralBlock;
@property (nonatomic, strong) YSBTCenMan_DisconnectPeripheralBlock      disconnectPeripheralBlock;

@property (nonatomic, strong) YSBTCenMan_DiscoverServicesBlock          discoverServicesBlock;

@property (nonatomic, strong) YSBTCenMan_DiscoverCharacteristicsBlock   discoverCharacteristicsBlock;
@property (nonatomic, strong) YSBTCenMan_UpdateValueForCharacteristicBlock updateCharacteristicValueBlock;



@property (nonatomic, strong) YSBTCenMan_DiscoverDescriptorsForCharacteristicBlock discoverDescripitorsForCharacterBlock;
@property (nonatomic, strong) YSBTCenMan_UpdateNotificationStateForCharacteristicBlock updateNotificationStateBlock;




@end
