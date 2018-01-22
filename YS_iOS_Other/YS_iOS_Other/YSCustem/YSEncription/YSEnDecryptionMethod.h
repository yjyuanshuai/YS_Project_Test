//
//  YSEnDecryptionMethod.h
//  EncryptionTest
//
//  Created by YJ on 16/8/10.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSEnDecryptionMethod : NSObject

#pragma mark - 加密
// MD5
+ (NSString *)encryptMD5StrForString:(NSString *)str;


// Base64
+ (NSString *)encryptbase64StrforData:(NSData *)data;
+ (NSString *)encryptBase64StrForString:(NSString *)str;


// AES128
+ (NSData *)encryptAES128DataForData:(NSData *)data
                                 Key:(NSString *)key
                                  iv:(NSString *)iv;
+ (NSString *)encryptAES128StrForString:(NSString *)str
                                    Key:(NSString *)key
                                     iv:(NSString *)iv;


// DES
+ (NSString *)encryptDESStrForSting:(NSString *)sText
                             key:(NSString *)key
                        andDesiv:(NSString *)ivDes;


#pragma mark - 解密
// Base64
+ (NSData *)decryptBase64DataForString:(NSString *)base64Str;
+ (NSString *)decryptBase64StrForString:(NSString *)base64Str;


// AES128
+ (NSData *)decryptAES128DataForData:(NSData *)data
                             Key:(NSString *)key
                              iv:(NSString *)iv;
+ (NSString *)decryptAES128StrForString:(NSString *)str
                                    Key:(NSString *)key
                                     iv:(NSString *)iv;


// DES
+ (NSString *)decryptDESStrForString:(NSString *)sText
                                 key:(NSString *)key
                               andiV:(NSString *)iv;

@end
