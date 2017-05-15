//
//  YSTestDataBase.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSTestDataBase.h"
#import "YSFileManager.h"

@implementation YSTestDataBase

static FMDatabaseQueue * dbQueue = nil;

+ (void)initDB
{
    [self closeDB];
    [self getDBQueue];
    [self initDBMigrationManager];
}

+ (NSString *)dbPath
{
    NSString * path = [YSFileManager getDocumentsPath];
    return [path stringByAppendingPathComponent:DB_PATH_NAME];
}

+ (FMDatabaseQueue *)getDBQueue
{
    if (dbQueue) {
        return dbQueue;
    }
    
    @synchronized (self) {
        dbQueue = [FMDatabaseQueue databaseQueueWithPath:[YSTestDataBase dbPath]];
    }
    return dbQueue;
}

+ (void)closeDB
{
    if (dbQueue) {
        [dbQueue close];
    }
}

+ (FMDBMigrationManager *)initDBMigrationManager
{
    // 1 创建数据库
    NSBundle * dbSqlBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:DB_SQL_BUNDLE ofType:@"bundle"]];
    FMDBMigrationManager * manager = [FMDBMigrationManager managerWithDatabaseAtPath:[YSTestDataBase dbPath] migrationsBundle:dbSqlBundle];
    
    // 2 创建迁移表 (表名 schema_migrations)
    NSError * error = nil;
    BOOL resultState = NO;
    if (!manager.hasMigrationsTable) {
        resultState = [manager createMigrationsTable:&error];
    }
    
    // UINT64_MAX 表示把数据库迁移到最大的版本
    resultState = [manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:&error];
    
    return manager;
}

@end
