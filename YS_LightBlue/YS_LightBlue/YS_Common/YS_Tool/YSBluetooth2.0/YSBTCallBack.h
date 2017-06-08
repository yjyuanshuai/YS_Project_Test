//
//  YSBTCallBack.h
//  YS_LightBlue
//
//  Created by YJ on 17/6/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSBTDefine.h"

// ---------- block 定义 ---------- //
typedef void(^YSBTCenMan_UpdateStateBlock)(CBCentralManager * central);
typedef void(^YSBTCenMan_DiscoverPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSDictionary * advertisementData, NSNumber * rssi);
typedef void(^YSBTCenMan_ConnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral);
typedef void(^YSBTCenMan_FailToConnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSError * error);
typedef void(^YSBTCenMan_DisconnectPeripheralBlock)(CBCentralManager * central, CBPeripheral * peripheral, NSError * error);


typedef void(^YSBTCenMan_DiscoverServicesBlock)(CBPeripheral * peripheral, NSError * error);
typedef void(^YSBTCenMan_DiscoverIncludedServicesBlock)(CBPeripheral * peripheral, CBService * service, NSError * error);
typedef void(^YSBTCenMan_DiscoverCharacteristicsBlock)(CBPeripheral * peripheral, CBService * service, NSError * error);
typedef void(^YSBTCenMan_UpdateValueForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
typedef void(^YSBTCenMan_WriteValueForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
typedef void(^YSBTCenMan_DiscoverDescriptorsForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
typedef void(^YSBTCenMan_UpdateValueForDescriptorBlock)(CBPeripheral * peripheral, CBDescriptor * descriptor, NSError * error);
typedef void(^YSBTCenMan_WriteValueForDescriptorBlock)(CBPeripheral * peripheral, CBDescriptor * descriptor, NSError * error);
typedef void(^YSBTCenMan_UpdateNotificationStateForCharacteristicBlock)(CBPeripheral * peripheral, CBCharacteristic * characteristic, NSError * error);
//typedef void(^YSBTCenMan_)();


@interface YSBTCallBack : NSObject

@property (nonatomic, strong) YSBTCenMan_UpdateStateBlock updateState;

@end
