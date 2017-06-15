//
//  NSAttributedString+YSAttrStrCategory.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "NSAttributedString+YSAttrStrCategory.h"

@implementation NSAttributedString (YSAttrStrCategory)

- (CGFloat)calculateHeightWithWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight minHeight:(CGFloat)minHeight
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                       context:nil].size;

    CGFloat retHeight = ceil(size.height);
    if (retHeight > maxHeight) {
        retHeight = maxHeight;
    }
    if (retHeight < minHeight) {
        retHeight = minHeight;
    }

    return retHeight;
}

- (CGSize)calculateSizeWithMaxSize:(CGSize)maxSize minSize:(CGSize)minSize
{
    CGSize rect = [self boundingRectWithSize:CGSizeMake(maxSize.width, maxSize.height)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     context:nil].size;
    CGFloat width = ceil(rect.width);
    CGFloat height = ceil(rect.height);

    

    return CGSizeMake(width, height);
}

@end
