//
//  UIImage+YSImageCategare.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/12.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "UIImage+YSImageCategare.h"

@implementation UIImage (YSImageCategare)

/**
 *  颜色转图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  对话气泡
 */
+ (UIImage *)chatImageWithOriginImage:(NSString *)image
{
    UIImage * originImage = [UIImage imageNamed:image];
    // 获取原有图片的宽高的一半
    CGFloat w = originImage.size.width * 0.5;
    CGFloat top = originImage.size.height * 0.5;
    CGFloat bottom = originImage.size.height-top;
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [originImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, w, bottom, w) resizingMode:UIImageResizingModeStretch];
    return newImage;
}

@end
