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
#import "YSBTCallBack.h"

@interface YSBluetooth : NSObject

@property (nonatomic, strong) YSBTCentralManager * ysBTCenManager;
@property (nonatomic, strong) YSBTPeripheralManager * ysBTPerManager;

+ (instancetype)sharesYSBluetooth;

#pragma mark - block
- (void)setYSBTCenMan_UpdateStateBlock:(YSBTCenMan_UpdateStateBlock)block;
- (void)ysBTCenManStartScanWithCBUUIDs:(NSArray <CBUUID *> *)cbuuids
                                option:(NSDictionary *)option
                   discoverPeripherals:(YSBTCenMan_DiscoverPeripheralBlock)block;
- (void)setYSBTCenMan_DisconnectPeripheralBlock:(YSBTCenMan_DisconnectPeripheralBlock)block;

#pragma mark - 
;

@end
