//
//  YSImageAndTextSort.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    表情 Model
 */
@interface EmotionModel : NSObject

@property (nonatomic, copy) NSString * cht;     // 中文字符
@property (nonatomic, copy) NSString * emo;     // 对应图片

@end


/**
    解析
 */
@interface EmotionFileAnalysis : NSObject

@property (nonatomic, strong) NSMutableArray * emoArr;
+ (instancetype)sharedEmotionFile;
- (NSMutableArray *)analysisEmoData:(NSString *)fileName type:(NSString *)fileType;

@end


/**
    图文混排
 */

@interface YSImageAndTextSort : NSObject

+ (NSMutableAttributedString *)textAttach:(NSString *)text attributDic:(NSDictionary *)dict emoArr:(NSArray *)emoArr originY:(CGFloat)originY;

+ (NSMutableAttributedString *)textAttach:(NSString *)text attributDic:(NSDictionary *)dict exchangeStr:(NSString *)str image:(NSString *)image;

@end



