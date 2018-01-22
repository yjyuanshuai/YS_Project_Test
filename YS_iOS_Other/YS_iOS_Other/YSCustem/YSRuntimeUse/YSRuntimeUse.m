//
//  YSRuntimeUse.m
//  YS_iOS_Other
//
//  Created by YJ on 2018/1/22.
//  Copyright © 2018年 YJ. All rights reserved.
//

#import "YSRuntimeUse.h"
#import <objc/runtime.h>

@implementation YSRuntimeUse


#pragma mark - class
/** 获取属性列表 */
+ (NSMutableArray *)getPropertyListForClass:(Class)currentClass
{
    NSMutableArray *retArr = [NSMutableArray array];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(currentClass, &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        NSString *propertyNameUTF8 = [NSString stringWithUTF8String:propertyName];
        [retArr addObject:propertyNameUTF8];
    }
    return retArr;
}

/** 方法列表 */
+ (NSMutableArray *)getMethodListForClass:(Class)currentClass
{
    NSMutableArray *retArr = [NSMutableArray array];
    unsigned int count;
    Method *methodList = class_copyMethodList(currentClass, &count);
    for (unsigned int i=0; i<count; i++) {
        Method method = methodList[i];
        SEL methodSEL = method_getName(method);
        [retArr addObject:NSStringFromSelector(methodSEL)];
    }
    return retArr;
}

/** 变量 */
+ (NSMutableArray *)getIvarListForClass:(Class)currentClass
{
    NSMutableArray *retArr = [NSMutableArray array];
    unsigned int count;
    Ivar * ivarList = class_copyIvarList(currentClass, &count);
    for (unsigned int i=0; i<count; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *ivarNameUTF8 = [NSString stringWithUTF8String:ivarName];
        [retArr addObject:ivarNameUTF8];
    }
    return retArr;
}

/** 协议 */
+ (NSMutableArray *)getProtocolListForClass:(Class)currentClass
{
    NSMutableArray *retArr = [NSMutableArray array];
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(currentClass, &count);
    for (unsigned int i=0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSString * protocolNameUTF8 = [NSString stringWithUTF8String:protocolName];
        [retArr addObject:protocolNameUTF8];
    }
    
    return retArr;
}

@end
