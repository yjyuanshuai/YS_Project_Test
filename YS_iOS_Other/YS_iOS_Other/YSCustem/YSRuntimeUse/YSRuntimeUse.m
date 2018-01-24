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

#pragma mark - 动态添加方法
// 隐式调用方法
- (void)ysPerformSelector
{
    [self performSelector:@selector(tempMethod:)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if ([NSStringFromSelector(sel) isEqualToString:@"tempMethod:"]) {
        // 第4个参数，v->void;   @->对象，self;   :->SEL，_cmd
        class_addMethod(self, sel, (IMP)runtimeAddMethod, "v@:");
    }
    return YES;
}

// 实际的方法
void runtimeAddMethod(id self, SEL sel)
{
    NSLog(@"---- Runtime 动态添加方法，%@ ---- %@", self, NSStringFromSelector(sel));
}

#pragma mark - 动态增加类
- (void)runtimeAddClassWithName:(NSString *)name
{
    const char * className = [name cStringUsingEncoding:NSASCIIStringEncoding];
    // 从类名得到一个类
    Class newClass = objc_getClass(className);
    if (!newClass) {
        // 1. 创建一个类
        /**
         参数3：size_t extraBytes，该参数是分配给类和元类对象尾部的索引ivars的字节数，通常指定为 0.
         */
        newClass = objc_allocateClassPair([NSObject class], className, 0);
        
        // 2. 添加 ivar
        class_addIvar(newClass, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
        class_addIvar(newClass, "_age", sizeof(NSUInteger), log2(sizeof(NSUInteger)), @encode(NSUInteger));
        
        // 3. 注册类
        objc_registerClassPair(newClass);
    }
    
    // 创建实例
    id newClassInstance = [[newClass alloc] init];
    // 设置 ivar
    [newClassInstance setValue:@"Nancey" forKey:@"name"];
    Ivar ageIvar = class_getInstanceVariable(newClass, "_age");
    object_setIvar(newClassInstance, ageIvar, @18);
    // 打印对象的属性值
    NSLog(@"class: %@, name = %@, age = %@", newClassInstance, [newClassInstance valueForKey:@"name"], object_getIvar(newClassInstance, ageIvar));
    // 当类或者它的子类的实例还存在，则不能调用objc_disposeClassPair方法
    newClassInstance = nil;
    // 销毁类
    objc_disposeClassPair(newClass);
}

#pragma mark - class 列表
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
    free(propertyList);
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
    free(methodList);
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
    free(ivarList);
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
    free(protocolList);
    return retArr;
}

@end
