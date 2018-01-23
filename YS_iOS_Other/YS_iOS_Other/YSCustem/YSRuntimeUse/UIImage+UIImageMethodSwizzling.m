//
//  UIImage+UIImageMethodSwizzling.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/28.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "UIImage+UIImageMethodSwizzling.h"
#import <objc/runtime.h>

char nameKey;

@implementation UIImage (UIImageMethodSwizzling)

#pragma mark - 替换系统方法（Method Swizzing）
+ (void)load{
    // 获取两个类的类方法
    Method systemMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method extendMethod = class_getClassMethod(self, @selector(ys_imagedName:));
    // 交换方法实现
    method_exchangeImplementations(systemMethod, extendMethod);
}

+ (UIImage *)ys_imagedName:(NSString *)imageName
{
    UIImage * retImage = [UIImage ys_imagedName:imageName];
    if (retImage) {
        NSLog(@"___ Method Swizzling exchange method success!");
    }
    else {
//        NSLog(@"___ Method Swizzling exchange method fail!");
    }
    return retImage;
}

#pragma mark - 添加属性
- (void)setName:(NSString *)name
{
    // 将某个值跟某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, &nameKey);
}

@end
