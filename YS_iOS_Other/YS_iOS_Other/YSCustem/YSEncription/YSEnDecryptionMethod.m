//
//  YSEnDecryptionMethod.m
//  EncryptionTest
//
//  Created by YJ on 16/8/10.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSEnDecryptionMethod.h"
#import <CommonCrypto/CommonCrypto.h>       

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation YSEnDecryptionMethod

#pragma mark - 加密
// MD5
+ (NSString *)encryptMD5StrForString:(NSString *)str
{
    /*
     1、导入头文件  <CommonCrypto/CommonDigest.h>
     2、CC_MD5 函数
     */
    if ([str isEqualToString:@""] ||
        str == nil ||
        [str isKindOfClass:[NSNull class]]) {
        
        return nil;
    }
    
    const char * cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%X%X%X%X%X%X%X%X%X%X%X%X%X%X%X%X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

// base64
+ (NSString *)encryptBase64StrForString:(NSString *)str
{
    if (str && ![str isEqualToString:@""]) {
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        return [self encryptbase64StrforData:data];
    }
    else {
        return @"";
    }
}

/******************************************************************************
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 ******************************************************************************/
+ (NSString *)encryptbase64StrforData:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

// AES128
+ (NSData *)encryptAES128DataForData:(NSData *)data
                                 Key:(NSString *)key
                                  iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    char ivPtr[kCCKeySizeAES128+1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    if(diff > 0)
    {
        newSize = (int)(dataLength + diff);
    }
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x00, //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if(cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    return nil;
}

+ (NSString *)encryptAES128StrForString:(NSString *)str
                                    Key:(NSString *)key
                                     iv:(NSString *)iv
{
    NSData * encryptionData = [YSEnDecryptionMethod encryptAES128DataForData:[str dataUsingEncoding:NSUTF8StringEncoding] Key:key iv:iv];
    
    NSString * encryptionStr = [YSEnDecryptionMethod encryptbase64StrforData:encryptionData];
    
    return encryptionStr;
}

// DES
+ (NSString *)encryptDESStrForSting:(NSString *)sText
                             key:(NSString *)key
                        andDesiv:(NSString *)ivDes
{
    if ((sText == nil || sText.length == 0)
        || (sText == nil || sText.length == 0)
        || (ivDes == nil || ivDes.length == 0)) {
        return @"";
    }
    //gb2312 编码
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* encryptData = [sText dataUsingEncoding:encoding];
    size_t  dataInLength = [encryptData length];
    const void *   dataIn = (const void *)[encryptData bytes];
    CCCryptorStatus ccStatus = nil;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutMoved = 0;
    size_t    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);  dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    const void *iv = (const void *) [ivDes cStringUsingEncoding:NSASCIIStringEncoding];
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(kCCEncrypt,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       [key UTF8String],  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    //编码 base64
    NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    free(dataOut);
    return hexStr;
}

#pragma mark - 解密
+ (NSString *)decryptBase64StrForString:(NSString *)base64Str
{
    if (base64Str && ![base64Str isEqualToString:@""]) {
        NSData *data = [self decryptBase64DataForString:base64Str];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return @"";
    }
}

/******************************************************************************
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 ******************************************************************************/
+ (NSData *)decryptBase64DataForString:(NSString *)base64Str
{
    if (base64Str == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([base64Str length] == 0)
        return [NSData data];
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    const char *characters = [base64Str cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([base64Str length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

// AES128
+ (NSData *)decryptAES128DataForData:(NSData *)data
                                 Key:(NSString *)key
                                  iv:(NSString *)iv
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    char ivPtr[kCCKeySizeAES128+1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x00, //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if(cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    return nil;
}

+ (NSString *)decryptAES128StrForString:(NSString *)str
                                    Key:(NSString *)key
                                     iv:(NSString *)iv
{
    NSData * base64Data = [YSEnDecryptionMethod decryptBase64DataForString:str];
    NSData * decryptionData = [YSEnDecryptionMethod decryptAES128DataForData:base64Data Key:key iv:iv];
    NSString * decrytionStr = [YSEnDecryptionMethod  encryptbase64StrforData:decryptionData];
    NSString * result = [YSEnDecryptionMethod decryptBase64StrForString:decrytionStr];
    return result;
}

// DES
+ (NSString *)decryptDESStrForString:(NSString *)sText
                                 key:(NSString *)key
                               andiV:(NSString *)iv
{
    if ((sText == nil || sText.length == 0)
        || (sText == nil || sText.length == 0)
        || (iv == nil || iv.length == 0)) {
        return @"";
    }
    const void *dataIn;
    size_t dataInLength;
    char *myBuffer = (char *)malloc((int)[sText length] / 2 + 1);
    bzero(myBuffer, [sText length] / 2 + 1);
    for (int i = 0; i < [sText length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [sText substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSData *decryptData =[NSData dataWithBytes:myBuffer length:[sText length] / 2 ];//转成utf-8并decode
    dataInLength = [decryptData length];
    dataIn = [decryptData bytes];
    free(myBuffer);
    CCCryptorStatus ccStatus = nil;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    const void *ivDes = (const void *) [iv cStringUsingEncoding:NSASCIIStringEncoding];
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(kCCDecrypt,//  加密/解密
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       [key UTF8String],  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       ivDes, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *result  = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:encoding];
    free(dataOut);
    return result;
}



@end
