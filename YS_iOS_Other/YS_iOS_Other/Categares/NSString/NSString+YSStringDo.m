//
//  NSString+YSStringDo.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "NSString+YSStringDo.h"

@implementation NSString (YSStringDo)

- (instancetype)analyseBreakLine
{
    NSString * retStr = self;
    return [retStr stringByReplacingOccurrencesOfString:@"\\n" withString:retStr];
}

/**
 *  判空
 */
- (BOOL)isBlank
{
    if ([self isEqual:@"NULL"] ||
        [self isKindOfClass:[NSNull class]] ||
        [self isEqual:[NSNull null]] ||
        [self isEqual:NULL] ||
        [[self class] isSubclassOfClass:[NSNull class]] ||
        self == nil ||
        self == NULL ||
        [self isKindOfClass:[NSNull class]] ||
        [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 ||
        [self isEqualToString:@"<null>"] ||
        [self isEqualToString:@"(null)"])
    {
        return YES;
    }
    
    return NO;
}

/**
 *  去除空格
 */
- (instancetype)removeSpace
{
    return self;
}

/**
 *  去除空格 + 无效值（如：null，nil等）
 */
- (instancetype)removeSpaceAndInvalid
{
    return self;
}

- (CGFloat)calculateHeightWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font miniHeight:(CGFloat)miniHeight
{
    UIFont * curFont = font;
    if (font == nil) {
        curFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    CGSize rect = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:curFont}
                                     context:nil].size;
    if (rect.height < miniHeight) {
        return miniHeight;
    }
    return rect.height;
}


- (CGFloat)calculateWidthWithMaxHeight:(CGFloat)maxHeight font:(UIFont *)font miniWidth:(CGFloat)miniWidth
{
    UIFont * curFont = font;
    if (font == nil) {
        curFont = [UIFont systemFontOfSize:16.0];
    }
    CGSize rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:curFont}
                                     context:nil].size;
    if (rect.width < miniWidth) {
        return miniWidth;
    }
    return rect.width;
}


@end
