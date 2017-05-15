//
//  docModel.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "docModel.h"
#import "NSString+YSStringDo.h"

@implementation sectionDetailModel

- (instancetype)initDeatiltWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _title = dic[@"title"];
        NSMutableString * tempMutStr = [NSMutableString string];
        NSArray * tempArr = [dic[@"detail"] componentsSeparatedByString:@"@@@@"];
        for (NSString * subStr in tempArr) {
            if ([subStr isEqualToString:[tempArr lastObject]]) {
                [tempMutStr appendString:subStr];
            } else {
                [tempMutStr appendFormat:@"%@\n", subStr];
            }
        }
        _detail = [tempMutStr analyseBreakLine];
    }
    return self;
}

@end





@implementation docModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _sectionTitle = dic[@"sectiontitle"];
        _sectionDetailArr = [NSMutableArray array];
        
        for (NSDictionary * subDic in dic[@"sectiondetail"]) {
            sectionDetailModel * model = [[sectionDetailModel alloc] initDeatiltWithDic:subDic];
            [_sectionDetailArr addObject:model];
        }
    }
    return self;
}

@end
