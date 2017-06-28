//
//  UIImage+UIImageMethodSwizzling.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/28.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "UIImage+UIImageMethodSwizzling.h"
#import <objc/runtime.h>

@implementation UIImage (UIImageMethodSwizzling)

+ (void)load{
    Method systemMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method extendMethod = class_getClassMethod(self, @selector(ys_imagedName:));
    method_exchangeImplementations(systemMethod, extendMethod);
}

+ (UIImage *)ys_imagedName:(NSString *)imageName
{
    UIImage * retImage = [UIImage ys_imagedName:imageName];
    if (retImage) {
        NSLog(@"___ Method Swizzling exchange method success!");
    }
    else {
        NSLog(@"___ Method Swizzling exchange method fail!");
    }
    return retImage;
}

@end
