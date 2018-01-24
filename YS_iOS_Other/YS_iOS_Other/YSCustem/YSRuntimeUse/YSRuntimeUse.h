//
//  YSRuntimeUse.h
//  YS_iOS_Other
//
//  Created by YJ on 2018/1/22.
//  Copyright © 2018年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSRuntimeUse : NSObject

#pragma mark - 替换系统方法（Method Swizzing）/ 动态加属性
// UIImage+UIImageMethodSwizzling.h

#pragma mark - 动态添加方法
- (void)ysPerformSelector;

#pragma mark - 动态增加类
- (void)runtimeAddClassWithName:(NSString *)name;

#pragma mark - class 列表
/** 获取属性列表 */
+ (NSMutableArray *)getPropertyListForClass:(Class)currentClass;

/** 方法列表 */
+ (NSMutableArray *)getMethodListForClass:(Class)currentClass;

/** 变量 */
+ (NSMutableArray *)getIvarListForClass:(Class)currentClass;

/** 协议 */
+ (NSMutableArray *)getProtocolListForClass:(Class)currentClass;

@end
