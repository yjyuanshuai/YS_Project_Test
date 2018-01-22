//
//  YSRuntimeUse.h
//  YS_iOS_Other
//
//  Created by YJ on 2018/1/22.
//  Copyright © 2018年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSRuntimeUse : NSObject

#pragma mark - class
/** 获取属性列表 */
+ (NSMutableArray *)getPropertyListForClass:(Class)currentClass;

/** 方法列表 */
+ (NSMutableArray *)getMethodListForClass:(Class)currentClass;

/** 变量 */
+ (NSMutableArray *)getIvarListForClass:(Class)currentClass;

/** 协议 */
+ (NSMutableArray *)getProtocolListForClass:(Class)currentClass;

@end
