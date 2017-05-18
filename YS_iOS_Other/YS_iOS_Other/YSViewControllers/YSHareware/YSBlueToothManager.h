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



@protocol YSBluetoothManagerDelegate;

@interface YSBlueToothManager : NSObject

@property (nonatomic, weak) id<YSBluetoothManagerDelegate> delegate;

+ (instancetype)sharedBlueToothManager;

/**
 中心模式
 */
- (void)setPeripheralContentStr:(NSString *)contentStr
                    contentType:(YSCBPeripheralConStrType)contentType;
- (void)cbManagerStartScan;
- (void)cbManagerStopScanAndDisconnectAllServices;
- (CBManagerState)obtainCBManagerState;

@end


@protocol YSBluetoothManagerDelegate <NSObject>

- (void)allDiscoverPeripherals:(NSMutableArray *)arr;

@end
