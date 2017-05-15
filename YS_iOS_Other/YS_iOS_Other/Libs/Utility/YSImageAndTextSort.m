//
//  YSImageAndTextSort.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSImageAndTextSort.h"

#pragma mark -
@implementation EmotionModel



@end


#pragma mark - EmotionFileAnalysis

static EmotionFileAnalysis * instance = nil;

@implementation EmotionFileAnalysis

+ (instancetype)sharedEmotionFile
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSMutableArray *)analysisEmoData:(NSString *)fileName type:(NSString *)fileType
{
    NSString * path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (!_emoArr) {
        _emoArr = [@[] mutableCopy];
    }
    
    // 枚举
    NSString * key;
    NSEnumerator * enumerator = [[dict allKeys] objectEnumerator];
    while (key = [enumerator nextObject]) {
        EmotionModel * model = [[EmotionModel alloc] init];
        model.cht = key;
        model.emo = dict[key];
        
        [_emoArr addObject:model];
    }
    
    return _emoArr;
}
@end


#pragma mark - YSImageAndTextSort

@implementation YSImageAndTextSort

/**
    图文混排 - 表情
 */

+ (NSMutableAttributedString *)textAttach:(NSString *)text attributDic:(NSDictionary *)dict emoArr:(NSArray *)emoArr originY:(CGFloat)originY
{
    // 1 创建可变字符串
    NSMutableAttributedString * mulAttrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:dict];
    
    // 2 通过正则表达式匹配表情
    NSString * reg_emo = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";
    
    NSError * error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:reg_emo options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        DDLogInfo(@"-------- error:%@", [error localizedDescription]);
        return mulAttrStr;
    }
    
    // 3 获取所有表情及位置
    NSArray * retArr = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    // 3-1 字典存放图片和图片对应位置
    NSMutableArray * imageArray = [NSMutableArray arrayWithCapacity:retArr.count];
    
    // 3-2 根据位置进行相应的替换
    for (NSTextCheckingResult * match in retArr) {
        
        // 3-2-1 获取数组元素中得到range
        NSRange range = [match range];
        
        // 3-2-2 获取原字符串中的对应值
        NSString * subStr = [text substringWithRange:range];
        for (int i = 0; i < [emoArr count]; i++) {
            EmotionModel * model = emoArr[i];
            if ([model.cht isEqualToString:subStr]) {
                
                // 3-2-2-1 新建文字附件来存放图片
                NSTextAttachment * textAttachment = [[NSTextAttachment alloc] init];
                
                // 3-2-2-2 给附件添加图片
                textAttachment.image = [UIImage imageNamed:model.emo];
                
                // 3-2-2-3 调整图片位置
                textAttachment.bounds = CGRectMake(0, originY, textAttachment.image.size.width, textAttachment.image.size.height);
                
                // 3-2-2-4 将附件转换为属性字符串，用于替换源字符串中的表情文字
                NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                
                // 3-2-2-5 将图片和图片对应位置存入字典
                NSMutableDictionary * imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                
                // 3-2-2-6 将字典存入数组
                [imageArray addObject:imageDic];
            }
        }
    }
    
    // 4 从后往前替换，否则会引起位子问题
    for (int i = (int)[imageArray count] - 1; i >= 0; i--) {
        NSRange range = [imageArray[i][@"range"] rangeValue];
        [mulAttrStr replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return mulAttrStr;
}

/**
    图片
 */
+ (NSMutableAttributedString *)textAttach:(NSString *)text attributDic:(NSDictionary *)dict exchangeStr:(NSString *)str image:(NSString *)image
{
    // 1 创建可变字符串
    NSMutableAttributedString * mulAttrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:dict];
    
    // 2 匹配字符串
    NSError * error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:str options:0 error:&error];
    if (error) {
        DDLogInfo(@"-------- error:%@", [error localizedDescription]);
        return mulAttrStr;
    }
    
    // 3 获取所有图片的位置
    NSArray * retArr = [re matchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
    
    NSMutableArray * rangeArr = [NSMutableArray arrayWithCapacity:retArr.count];
    for (NSTextCheckingResult * match in retArr) {
        NSRange range = [match range];
        [rangeArr addObject:[NSValue valueWithRange:range]];
    }
    
    // 4 从后往前替换，否则会引起位子问题
    for (int i = (int)rangeArr.count-1; i>=0; i--) {
        NSRange range = [rangeArr[i] rangeValue];
        NSTextAttachment * textAttch = [[NSTextAttachment alloc] init];
        textAttch.image = [UIImage imageNamed:image];
        textAttch.bounds = CGRectMake(0, 0, textAttch.image.size.width, textAttch.image.size.height);
        NSAttributedString * attrStr = [NSAttributedString attributedStringWithAttachment:textAttch];
        [mulAttrStr replaceCharactersInRange:range withAttributedString:attrStr];
    }
    
    return mulAttrStr;
}

@end

