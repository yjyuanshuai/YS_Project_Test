//
//  YSFileManager.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSFileManager.h"

@implementation YSFileManager

#pragma mark - 目录管理
+ (BOOL)directHasExist:(NSString *)diretPath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:diretPath isDirectory:&isDir];
    if (isExist && isDir) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)createDirectToPath:(NSString *)path
{
    if (![YSFileManager directHasExist:path]) {
        NSError * error = nil;
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        BOOL createSuccess = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogInfo(@"------------- 目标目录: %@ 创建失败！----- error: %@", path, error.localizedDescription);
        }
        return createSuccess;
    }
    else {
        DDLogInfo(@"---------- 目标目录: %@ 已存在！不需新建", path);
        return YES;
    }
}

+ (NSArray *)allFileOrDirectInDirect:(NSString *)path
{
    NSError * error = nil;
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * contentsArr = nil;
    contentsArr = [fileManager contentsOfDirectoryAtPath:path error:&error];
    
    if (error) {
        DDLogInfo(@"---------- 获取目标路径下: %@ 子文件/夹出错！error: %@", path, error.localizedDescription);
    }
    
    return contentsArr;
}

+ (BOOL)deleteAppointFileType:(NSString *)type inDirect:(NSString *)path
{
    BOOL deleteType = YES;
    
    NSArray * contentsArr = [YSFileManager allFileOrDirectInDirect:path];
    
    if ([contentsArr count] > 0) {
        NSEnumerator * enu = [contentsArr objectEnumerator];
        NSString * fileName;
        while (fileName = [enu nextObject]) {
            if ([[fileName pathExtension] isEqualToString:type]) {
                deleteType = [YSFileManager deleteFile:[path stringByAppendingPathComponent:fileName]];
                if (!deleteType) {
                    return deleteType;
                }
            }
        }
    }
    else {
        deleteType = NO;
        DDLogInfo(@"---------- 目标目录: %@ ，不存在扩展名为: %@ 的文件", path, type);
    }
    
    return deleteType;
}

+ (BOOL)deleteAllFileOrDirectInDirect:(NSString *)path
{
    BOOL deleteType = YES;
    
    NSArray * contentsArr = [YSFileManager allFileOrDirectInDirect:path];
    if ([contentsArr count] > 0) {
        NSEnumerator * enu = [contentsArr objectEnumerator];
        NSString * fileName;
        while (fileName = [enu nextObject]) {
            deleteType = [YSFileManager deleteFile:[path stringByAppendingPathComponent:fileName]];
            if (!deleteType) {
                return deleteType;
            }
        }
    }
    else {
        deleteType = NO;
        DDLogInfo(@"---------- 目标目录: %@ 下没有任何子文件或目录", path);
    }
    
    return deleteType;
}

#pragma mark - 文件管理

+ (BOOL)fileHasExist:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }
    return NO;
}

+ (BOOL)createFiletoDes:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![YSFileManager fileHasExist:path]) {
        BOOL createSuccess = [fileManager createFileAtPath:path contents:nil attributes:nil];
        return createSuccess;
    }
    else {
        DDLogInfo(@"----------- %@ 已存在！不需创建", path);
        return YES;
    }
}

+ (BOOL)deleteFile:(NSString *)path
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSError * error = nil;
    BOOL deleteSuccess = [fileManager removeItemAtPath:path error:&error];
    if (error) {
        DDLogInfo(@"------------ %@ 文件删除失败，error: %@", path, error.localizedDescription);
    }
    
    return deleteSuccess;
}



#pragma mark - 文件内容管理
+ (BOOL)writeData:(id)writeData toFile:(NSString *)path
{
    BOOL writeSuccess = NO;
    if ([writeData isKindOfClass:[NSString class]]) {
        
        // 字符串
        NSError * error = nil;
        
        NSString * writeStr = (NSString *)writeData;
        writeSuccess = [writeStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            DDLogInfo(@"----------- writeFile出错，error: %@", error.localizedDescription);
        }
        
    }
    else if ([writeData isKindOfClass:[NSData class]]) {
    
        NSData * writeDatas = (NSData *)writeData;
        writeSuccess = [writeDatas writeToFile:path atomically:YES];
        
    }
    else {
    
        DDLogInfo(@"------------- 写入数据非法！");
        
    }
    return writeSuccess;
}

+ (id)readDataFromFile:(NSString *)path dataType:(Class)className
{
    if ([className isSubclassOfClass:[NSArray class]]) {
        NSArray * retArr = [[NSArray alloc] initWithContentsOfFile:path];
        return retArr;
    }
    else if ([className isSubclassOfClass:[NSDictionary class]]) {
        NSDictionary * retDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        return retDict;
    }
    else if ([className isSubclassOfClass:[NSData class]]) {
        NSData * retData = [NSData dataWithContentsOfFile:path];
        return retData;
    }
    else if ([className isSubclassOfClass:[NSString class]]) {
        NSString * retStr = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding];
        return retStr;
    }
    
    return nil;
}


#pragma mark - 获取沙盒文件路径
+ (NSString *)getSandBoxHomePath
{
    return NSHomeDirectory();
}

+ (NSString *)getDocumentsPath
{
    // NSDocumentDirectory 表明我们正在查找 Documents 目录的路径
    // NSUserDomainMask 表示将搜索限制在引用程序的沙盒内
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [arr objectAtIndex:0];
    return documentsPath;
}

+ (NSString *)getLibraryPath
{
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [arr objectAtIndex:0];
    return documentsPath;
    
    // 另方法
    // [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)getLibraryCachesPath
{
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentsPath = [arr objectAtIndex:0];
    return documentsPath;
}

+ (NSString *)getTmpPath
{
    return NSTemporaryDirectory();
    
    // 另方法
    // return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

@end
