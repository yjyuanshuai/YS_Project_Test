//
//  YSPeripheralModel.h
//  YS_LightBlue
//
//  Created by YJ on 17/5/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YSPeripheralType)
{
    YSPeripheralType_Per,
    YSPeripheralType_VirtualAdd,    // 新建
    YSPeripheralType_VirtualSel     // 选中
};

@interface YSPeripheralModel : NSObject

@property (nonatomic, assign) YSPeripheralType perType;
@property (nonatomic, copy) NSString * perName;
@property (nonatomic, copy) NSString * perServicesNum;
@property (nonatomic, copy) NSString * perSignStrength;

@end
