//
//  YSCharacterDetail.h
//  YS_LightBlue
//
//  Created by YJ on 2017/6/20.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSRootVC.h"
@class CBPeripheral;
@class CBCharacteristic;

@interface YSCharacterDetail : YSRootVC

- (instancetype)initWithPeripheral:(CBPeripheral *)per character:(CBCharacteristic *)character;

@end
