//
//  NSAttributedString+YSAttrStrCategory.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (YSAttrStrCategory)

- (CGFloat)calculateHeightWithWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight minHeight:(CGFloat)minHeight;
- (CGSize)calculateSizeWithMaxSize:(CGSize)maxSize minSize:(CGSize)minSize;

@end
