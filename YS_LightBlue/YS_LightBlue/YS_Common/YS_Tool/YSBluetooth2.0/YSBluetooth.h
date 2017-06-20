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
- (void)ysBTCenMan_UpdateStateBlock:(YSBTCenMan_UpdateStateBlock)block;

- (void)ysBTCenMan_StartScanWithCBUUIDs:(NSArray <CBUUID *> *)cbuuids
                                   options:(NSDictionary *)options
                       discoverPeripherals:(YSBTCenMan_DiscoverPeripheralBlock)block;

- (void)ysBTCenMan_ConnectPeripheral:(YSPeripheralModel *)peripheral
                                options:(NSDictionary *)options
                           successBlock:(YSBTCenMan_ConnectPeripheralBlock)successblock
                              failBlock:(YSBTCenMan_FailToConnectPeripheralBlock)failBlock;

- (void)ysBTCenMan_DisconnectPeripheralBlock:(YSBTCenMan_DisconnectPeripheralBlock)block;

#pragma mark - 
;

@end
