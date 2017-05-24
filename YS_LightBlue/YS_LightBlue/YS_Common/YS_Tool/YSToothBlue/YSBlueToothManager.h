//
//  YSBlueToothManager.h
//  YS_iOS_Other
//
//  Created by YJ on 17/5/18.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef NS_ENUM(NSInteger, YSCBPeripheralConStrType)
{
    YSCBPeripheralConStrType_None,
    YSCBPeripheralConStrType_Prefix,    // 前缀
    YSCBPeripheralConStrType_SufFix,    // 后缀
    YSCBPeripheralConStrType_SubStr     // 包含
};

typedef NS_ENUM(NSInteger, YSPeripheralType)
{
    YSPeripheralType_Per,       // 真实外设
    YSPeripheralType_Virtual    // 虚拟的外设
};

#pragma mark - Peripheral Model
@interface YSPeripheralModel : NSObject

@property (nonatomic, assign) YSPeripheralType perType;     //
@property (nonatomic, copy) NSString * perName;             // 外设名
@property (nonatomic, copy) NSString * perServicesNum;      // 外设服务数
@property (nonatomic, copy) NSString * perSignStrength;     // 信号强度
@property (nonatomic, assign) BOOL perWorking;              // 真实外设（YES-已连接）；虚拟外设（YES-已开启）

@property (nonatomic, strong) CBPeripheral * per;           // 外设
@property (nonatomic, strong) NSDictionary * perDataDic;

@end


#pragma mark - Bluetooth Manager

@protocol YSBluetoothManagerDelegate;

@interface YSBlueToothManager : NSObject

@property (nonatomic, weak) id<YSBluetoothManagerDelegate> delegate;

+ (instancetype)sharedYSBlueToothManager;

#pragma mark - central（中心者模式）

- (void)setcbCenPerContentStr:(NSString *)contentStr
                  contentType:(YSCBPeripheralConStrType)contentType;
- (void)cbManagerStartScan;
- (void)cbManagerConnectWithPeripheral:(CBPeripheral *)per;
- (void)cbManagerStopScanAndDisconnectAllServices;
- (CBCentralManager *)cbCenManager;
- (CBManagerState)obtainCBManagerState;

#pragma mark - peripheral（外设模式）

@end

#pragma mark - delegate
@protocol YSBluetoothManagerDelegate <NSObject>

@optional
- (void)discoverNewPeripheral:(YSPeripheralModel *)perModel;

@end
