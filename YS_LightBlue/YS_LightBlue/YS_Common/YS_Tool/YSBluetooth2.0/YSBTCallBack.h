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
typedef void(^YSBTCenMan_UpdateStateBlock)(CBCentralManager * central);
typedef void(^YSBTCenMan_DiscoverPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSDictionary * advertisementData, NSNumber * rssi);
typedef void(^YSBTCenMan_ConnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral);
typedef void(^YSBTCenMan_FailToConnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSError * error);
typedef void(^YSBTCenMan_DisconnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSError * error);


typedef void(^YSBTCenMan_DiscoverServicesBlock)(CBPeripheral * peripheral, NSError * error);
//typedef void(^YSBTCenMan_DiscoverIncludedServicesBlock)(CBPeripheral * peripheral, CBService * service, NSError * error);
typedef void(^YSBTCenMan_DiscoverCharacteristicsBlock)(CBPeripheral * peripheral, CBService * service, NSError * error);
//typedef void(^YSBTCenMan_UpdateValueForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
//typedef void(^YSBTCenMan_WriteValueForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
typedef void(^YSBTCenMan_DiscoverDescriptorsForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
//typedef void(^YSBTCenMan_UpdateValueForDescriptorBlock)(CBPeripheral * peripheral, CBDescriptor * descriptor, NSError * error);
//typedef void(^YSBTCenMan_WriteValueForDescriptorBlock)(CBPeripheral * peripheral, CBDescriptor * descriptor, NSError * error);
typedef void(^YSBTCenMan_UpdateNotificationStateForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
//typedef void(^YSBTCenMan_)();


@interface YSBTCallBack : NSObject

#pragma mark - cen property
@property (nonatomic, assign) BOOL isStartScan;
@property (nonatomic, strong) NSArray * CBUUIDS;
@property (nonatomic, strong) NSDictionary * scanOptions;

@property (nonatomic, assign) BOOL isConnectPeripheral;
@property (nonatomic, strong) NSDictionary * connectPeripheralOptions;

//@property (nonatomic, assign) BOOL is


#pragma mark - cen delegate block
@property (nonatomic, strong) YSBTCenMan_UpdateStateBlock               updateStateBlock;
@property (nonatomic, strong) YSBTCenMan_DiscoverPeripheralBlock        discoverPeripheralBlock;
@property (nonatomic, strong) YSBTCenMan_ConnectPeripheralBlock         connectPeripheralBlock;
@property (nonatomic, strong) YSBTCenMan_FailToConnectPeripheralBlock   failToConnectPeripheralBlock;
@property (nonatomic, strong) YSBTCenMan_DisconnectPeripheralBlock      disconnectPeripheralBlock;

@property (nonatomic, strong) YSBTCenMan_DiscoverServicesBlock          discoverServicesBlock;
@property (nonatomic, strong) YSBTCenMan_DiscoverCharacteristicsBlock   discoverCharacteristicsBlock;
@property (nonatomic, strong) YSBTCenMan_DiscoverDescriptorsForCharacteristicBlock discoverDescripitorsForCharacterBlock;
@property (nonatomic, strong) YSBTCenMan_UpdateNotificationStateForCharacteristicBlock updateNotificationStateBlock;




@end
