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
@class YSBTCallBack;

@interface YSBluetooth : NSObject

@property (nonatomic, strong) YSBTCentralManager * ysBTCenManager;
@property (nonatomic, strong) YSBTPeripheralManager * ysBTPerManager;
@property (nonatomic, strong) YSBTCallBack * ysBTCallBack;


@end
