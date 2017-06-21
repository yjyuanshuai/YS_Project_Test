//
//  YSBTCentralManager.h
//  YS_LightBlue
//
//  Created by YJ on 17/6/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSBTCallBack;
@class CBPeripheral;
@class CBCentralManager;
@class CBCharacteristic;

@interface YSBTCentralManager : NSObject

@property (nonatomic, strong) YSBTCallBack * cenManCallBack;
@property (nonatomic, strong) CBCentralManager * cbCenManager;
@property (nonatomic, strong) NSMutableArray * cbCenMan_discoverPers;
@property (nonatomic, strong) NSMutableArray * cbCenMan_connectPers;

//- (void)ysStartScanPeripheralsWithCBUUIDs:(NSArray *)cbuuids options:(NSDictionary *)options;
- (void)ysConnectPeripheral:(CBPeripheral *)peripheral options:(NSDictionary *)options;
- (void)ysCenManStopScan;

@end
