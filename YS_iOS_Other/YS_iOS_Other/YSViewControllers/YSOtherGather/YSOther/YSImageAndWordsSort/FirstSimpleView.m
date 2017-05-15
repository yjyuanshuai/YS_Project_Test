//
//  FirstSimpleView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "FirstSimpleView.h"
#import <CoreText/CoreText.h>

@implementation FirstSimpleView

- (void)drawRect:(CGRect)rect
{
    // 1、获取当前上下文
    CGContextRef currentRef = UIGraphicsGetCurrentContext();
    
    // 2、转换坐标系
    CGContextSetTextMatrix(currentRef, CGAffineTransformIdentity);      // 重置，设置字形的变换矩阵为不做图形变换
    CGContextTranslateCTM(currentRef, 0, self.bounds.size.height);      // y轴高度，将画布向上平移一个屏幕高
    CGContextScaleCTM(currentRef, 1.0, -1.0);                           // y轴翻转，缩放方法，x轴缩放系数为1，则不变，y轴缩放系数为-1，则相当于以x轴为轴旋转180度
    
    // 3、初始化路径
    CGPathRef initPath = CGPathCreateWithRect(self.bounds, nil);
    
    // 4、初始化字符串
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"CoreText 图文混排之简单的应用"];
    
    // 5、初始化 framesetter
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attrStr);
    
    // 6、绘制 frame
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter,
                                                CFRangeMake(0, attrStr.length),
                                                initPath,
                                                nil);
    [self drawByAllFrame:frame currentRef:currentRef];
    
}

- (void)drawByAllFrame:(CTFrameRef)frame currentRef:(CGContextRef)currentRef
{
    // 整个 frame 一起绘制
    CTFrameDraw(frame, currentRef);
}

- (void)drawByLines:(CTFrameRef)frame
{
    // 按行绘制
    
    // 1 获取 CTLines 数组
    CFArrayRef lines = CTFrameGetLines(frame);
    
    // 2 获得行数
    CFIndex linesNum = CFArrayGetCount(lines);
    
    // 3 获得每一行的 origin，coretext 的 origin 是在字形的 baseLine 处的
    
//    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0),);
    
    // 4 遍历每一行进行绘制
    
}

- (void)drawByRuns:(CFAttributedStringRef)afAttributStr
        currentRef:(CGContextRef)currentRef
{
    // 按 Run 绘制
    
    CTLineRef line = CTLineCreateWithAttributedString(afAttributStr);
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    
    
}


@end
