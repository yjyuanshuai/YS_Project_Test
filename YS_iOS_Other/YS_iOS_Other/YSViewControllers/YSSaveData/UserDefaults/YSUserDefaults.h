//
//  YSUserDefaults.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSUserDefaults : NSObject

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * passWord;
@property (nonatomic, assign) BOOL isRememberPassWord;

+ (instancetype)shareUserDefualts;

- (void)saveUserDefaults;
- (void)readUserDefaults;

@end
