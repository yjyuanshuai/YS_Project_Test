//
//  YSAttributeStrView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AttributeBaseView.h"
#import <CoreText/CoreText.h>

@implementation AttributeBaseView

- (void)drawRect:(CGRect)rect
{
    [self coreTextWithBase];
}

- (void)coreTextWithBase
{
    //-------   设置样式    ---------------------------//
    NSString * originStr = @"字体和颜色 斜体 下划线和颜色 字体间隔 连字ffi 空心字";
    NSMutableAttributedString * mutAttributeStr = [[NSMutableAttributedString alloc] initWithString:originStr];

    // 1、字体和颜色
    NSRange rangeFontAndColor = [originStr rangeOfString:@"字体和颜色"];
    CTFontRef font = CTFontCreateWithName(CFSTR("Georgia"), 40, NULL);
    [mutAttributeStr addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:rangeFontAndColor];
    [mutAttributeStr addAttribute:(id)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:rangeFontAndColor];
    
    // 2、斜体
    NSRange rangeI = [originStr rangeOfString:@"斜体"];
    CTFontRef iFont = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:15.0].fontName, 20.0, NULL);
    [mutAttributeStr addAttribute:(id)kCTFontAttributeName value:(__bridge id)iFont range:rangeI];
    
    // 3、下划线和颜色
    NSRange rangeUnderLine = [originStr rangeOfString:@"下划线和颜色"];
    [mutAttributeStr addAttribute:(id)kCTUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble] range:rangeUnderLine];
    [mutAttributeStr addAttribute:(id)kCTUnderlineColorAttributeName value:(id)[UIColor redColor].CGColor range:rangeUnderLine];
    
    // 4、字体间隔
    NSRange rangeJG = [originStr rangeOfString:@"字体间隔"];
    long num = 10;
    CFNumberRef cfNum = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &num);
    [mutAttributeStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)cfNum range:rangeJG];
    
    // 5、连字
    NSRange rangeLZ = [originStr rangeOfString:@"连字ffi"];
    long num2 = 2;
    CFNumberRef cfNum2 = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &num2);
    [mutAttributeStr addAttribute:(id)kCTLigatureAttributeName value:(__bridge id)cfNum2 range:rangeLZ];
    
    // 6、空心字和颜色
    NSRange rangeKXZ = [originStr rangeOfString:@"空心字"];
    long num3 = 2;
    CFNumberRef cfNum3 = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &num3);
    [mutAttributeStr addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)cfNum3 range:rangeKXZ];
    [mutAttributeStr addAttribute:(id)kCTForegroundColorAttributeName value:(__bridge id)cfNum3 range:rangeKXZ];
    
    
    
    
    
    
    
    
    
    //-------   开始画    ---------------------------//
    // 1、生成 CTFramesetter
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mutAttributeStr);
    
    // 2、路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    // 3、得到 CTFrame
    CTFrameRef framRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, mutAttributeStr.length), path, NULL);
    
    // 4、获取上下文 context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
    CGContextSaveGState(context);
    
    //x，y轴方向移动
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    CTFrameDraw(framRef, context);
    
    CGPathRelease(path);
    CFRelease(frameSetter);
    
}

@end
