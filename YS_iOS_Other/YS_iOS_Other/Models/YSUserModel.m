//
//  YSUserModel.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSUserModel.h"

@implementation YSUserModel


// 当将一个自定义对象保存到文件的时候就会调用该方法
// 在该方法中说明如何存储自定义对象的属性
// 也就说在该方法中说清楚存储自定义对象的哪些属性
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userName forKey:@"nameStr"];
    [aCoder encodeObject:_age forKey:@"ageStr"];
    [aCoder encodeObject:_sex forKey:@"sexStr"];
}


// 当从文件中读取一个对象的时候就会调用该方法
// 在该方法中说明如何读取保存在文件中的对象
// 也就是说在该方法中说清楚怎么读取文件中的对象
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _userName = [aDecoder decodeObjectForKey:@"nameStr"];
        _age = [aDecoder decodeObjectForKey:@"ageStr"];
        _sex = [aDecoder decodeObjectForKey:@"sexStr"];
    }
    return self;
}

@end
