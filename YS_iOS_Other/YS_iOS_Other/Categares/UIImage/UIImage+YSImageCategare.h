//
//  UIImage+YSImageCategare.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/12.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YSImageCategare)

/**
 *  颜色转图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  图片压缩
 */


/**
 *  对话气泡
 */
+ (UIImage *)chatImageWithOriginImage:(NSString *)image;

@end
