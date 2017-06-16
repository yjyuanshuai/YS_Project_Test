//
//  YSBluetoothModel.h
//  YS_LightBlue
//
//  Created by YJ on 17/6/7.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBCharacteristic;
@class CBService;
@class CBPeripheral;

/**
    特征 model
*/
@interface YSCharacteristicModel : NSObject

@property (nonatomic, strong) NSString * cuuid;

@property (nonatomic, strong) CBCharacteristic * cbCharacteristic;

@end


/**
    服务 model
*/
@interface YSServiceModel : NSObject

@property (nonatomic, strong) NSString * suuid;
@property (nonatomic, strong) NSMutableArray <YSCharacteristicModel *> * characteristics;

@property (nonatomic, strong) CBService * cbService;

@end


/**
    外设 model
*/
@interface YSPeripheralModel : NSObject

@property (nonatomic, strong) NSString * pname;     // 外设名
@property (nonatomic, strong) NSString * puuid;     // uuidString
@property (nonatomic, strong) NSString * prssi;     // 信号量
@property (nonatomic, strong) NSString * pServicesNum;      // 服务

@property (nonatomic, strong) CBPeripheral * cbPeripheral;

@end



