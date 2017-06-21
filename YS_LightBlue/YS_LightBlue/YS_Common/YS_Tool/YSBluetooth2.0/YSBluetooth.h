//
//  YSBluetooth.h
//  YS_LightBlue
//
//  Created by YJ on 17/6/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSBTCentralManager;
@class YSBTPeripheralManager;
@class YSPeripheralModel;
#import "YSBTCallBack.h"

@interface YSBluetooth : NSObject

@property (nonatomic, strong) YSBTCentralManager * ysBTCenManager;
@property (nonatomic, strong) YSBTPeripheralManager * ysBTPerManager;

+ (instancetype)sharesYSBluetooth;

#pragma mark - block
// 外设
+ (void)ysBTCenMan_UpdateStateBlock:(YSBTCenMan_UpdateStateBlock)block;

+ (void)ysBTCenMan_StartScanWithCBUUIDs:(NSArray <CBUUID *> *)cbuuids
                                   options:(NSDictionary *)options
                       discoverPeripherals:(YSBTCenMan_DiscoverPeripheralBlock)block;

+ (YSBluetooth *)ysBTCenMan_ConnectPeripheralSuccessBlock:(YSBTCenMan_ConnectPeripheralBlock)successblock
                                                failBlock:(YSBTCenMan_FailToConnectPeripheralBlock)failBlock;

+ (void)ysBTCenMan_DisconnectPeripheralBlock:(YSBTCenMan_DisconnectPeripheralBlock)block;

// 服务
+ (void)ysBTCenMan_DiscoverServicesWithCBUUIDs:(NSArray *)cbuuids
                         discoverServicesBlock:(YSBTCenMan_DiscoverServicesBlock)block;

// 特征
+ (void)ysBTCenMan_DiscoverCharactersWithCBUUIDs:(NSArray *)cbuuids
                         discoverCharactersBlock:(YSBTCenMan_DiscoverCharacteristicsBlock)block;
// 读取特征
+ (YSBluetooth *)ysBRCenMan_ReadCharactersBlock:(YSBTCenMan_UpdateValueForCharacteristicBlock)block;

// 特征描述
+ (YSBluetooth *)ysBTCenMan_DiscoverDescriptForCharacterBlock:(YSBTCenMan_DiscoverDescriptorsForCharacteristicBlock)block;

#pragma mark - 
- (YSBluetooth * (^)(NSDictionary * options, YSPeripheralModel * peripheral))beginConnnected;
- (YSBluetooth * (^)(CBPeripheral * per, CBCharacteristic * character))updateCharacterValue;
- (YSBluetooth * (^)(CBPeripheral * per, CBCharacteristic * character))discoverDescriptForCharacter;

@end
