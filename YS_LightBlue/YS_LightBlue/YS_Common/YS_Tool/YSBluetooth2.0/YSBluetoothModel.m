//
//  YSBluetoothModel.m
//  YS_LightBlue
//
//  Created by YJ on 17/6/7.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSBluetoothModel.h"

@implementation YSCharacteristicModel



@end

@implementation YSServiceModel



@end

@implementation YSPeripheralModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pname = @"";
        _prssi = @"";
        _puuid = @"";
        _pServicesNum = @"0";
        _cbPeripheral = nil;
    }
    return self;
}

@end
