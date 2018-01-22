//
//  YSFileManager.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSFileManager : NSObject

#pragma mark - 目录管理
/**
 *  判断 文件夹 是否已存在
 */
+ (BOOL)directHasExist:(NSString *)diretPath;

/**
 *  创建目录到指定路径下
 */
+ (BOOL)createDirectToPath:(NSString *)path;

/**
 *  获取目标目录下所有的子文件/夹
 */
+ (NSArray *)allFileOrDirectInDirect:(NSString *)path;

/**
 *  删除目标目录下制定的文件
 */
+ (BOOL)deleteAppointFileType:(NSString *)type inDirect:(NSString *)path;

/**
 *  删除目标目录下所有的文件/文件夹
 */
+ (BOOL)deleteAllFileOrDirectInDirect:(NSString *)path;



#pragma mark - 文件管理
/**
 *  文件是否已存在（YES 存在，NO 不存在）
 */
+ (BOOL)fileHasExist:(NSString *)path;

/**
 *  创建文件到指定路径下
 */
+ (BOOL)createFiletoDes:(NSString *)path;

/**
 *  删除文件
 */
+ (BOOL)deleteFile:(NSString *)path;









/**
 *  移动文件到指定路径下
 */
+ (BOOL)moveFile:(NSString *)originPath toDes:(NSString *)desPath;

/**
 *  复制文件到指定路径下
 */
+ (BOOL)copyFile:(NSString *)originPath toDes:(NSString *)desPath;

/**
 *  获取文件大小
 */
+ (NSNumber *)getFileSize:(NSString *)path;

/**
 *  获取文件目录信息
 */
+ (NSDictionary *)getFileInfo:(NSString *)path;


#pragma mark - 文件内容管理
/**
 *  写入数据到文件（不存在则创建）
 */
+ (BOOL)writeData:(id)writeData toFile:(NSString *)path;

/**
 *  从文件中读取数据
 */
+ (id)readDataFromFile:(NSString *)path dataType:(Class)className;










/**
 *  比较2个文件的内容是否一样（YES 相同，NO 不同）
 */
+ (BOOL)contentsOfFile:(NSString *)oPath equalTo:(NSString *)tPath;


#pragma mark - 获取沙盒文件路径
+ (NSString *)getSandBoxHomePath;       // 沙盒根目录
+ (NSString *)getDocumentsPath;         // Documents
+ (NSString *)getLibraryPath;           // Library
+ (NSString *)getLibraryCachesPath;     // Library - Caches
+ (NSString *)getTmpPath;               // Tmp


@end
