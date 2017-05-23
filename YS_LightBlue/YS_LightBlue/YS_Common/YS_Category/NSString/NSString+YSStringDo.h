//
//  NSString+YSStringDo.h
//  YS_iOS_Other
//
//  Created by YJ on 16/11/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YSStringDo)

/**
 *  将 “\n”解析为转行
 */
- (instancetype)analyseBreakLine;

/**
 *  判空
 */
- (BOOL)isBlank;

/**
 *  去除空格
 */
- (instancetype)removeSpace;

/**
 *  去除空格 + 无效值（如：null，nil等）
 */
- (instancetype)removeSpaceAndInvalid;

/**
 *  返回高度
 */
- (CGFloat)calculateHeightWithMaxWidth:(CGFloat)maxWidth
                                  font:(UIFont *)font
                            miniHeight:(CGFloat)miniHeight;

/**
 *  返回宽度
 */
- (CGFloat)calculateWidthWithMaxHeight:(CGFloat)maxHeight
                                  font:(UIFont *)font
                             miniWidth:(CGFloat)miniWidth;



@end
