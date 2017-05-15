//
//  docModel.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sectionDetailModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * detail;

- (instancetype)initDeatiltWithDic:(NSDictionary *)dic;

@end



@interface docModel : NSObject

@property (nonatomic, copy) NSString * sectionTitle;
@property (nonatomic, strong) NSMutableArray * sectionDetailArr;   //sectionDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
