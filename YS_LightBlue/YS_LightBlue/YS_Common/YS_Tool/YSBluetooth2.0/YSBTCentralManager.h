//
//  YSBTCentralManager.h
//  YS_LightBlue
//
//  Created by YJ on 17/6/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YSBTCallBack;
@class CBCentralManager;

@interface YSBTCentralManager : NSObject

@property (nonatomic, strong) YSBTCallBack * cenManCallBack;
@property (nonatomic, strong) CBCentralManager * cbCenManager;
@property (nonatomic, strong) NSMutableArray * cbCenPersArr;



@end
