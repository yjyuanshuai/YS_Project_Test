//
//  MyKeyChainHelper.h
//  YS_iOS_Other
//
//  Created by YJ on 16/7/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyKeyChainHelper : NSObject

+ (void) saveUserName:(NSString*)userName
      userNameService:(NSString*)userNameService
             psaaword:(NSString*)pwd
      psaawordService:(NSString*)pwdService;

+ (void) deleteWithUserNameService:(NSString*)userNameService
                   psaawordService:(NSString*)pwdService;

+ (NSString*) getUserNameWithService:(NSString*)userNameService;

+ (NSString*) getPasswordWithService:(NSString*)pwdService;

@end