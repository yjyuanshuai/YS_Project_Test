//
//  YSUserModel.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSUserModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * age;

@end
