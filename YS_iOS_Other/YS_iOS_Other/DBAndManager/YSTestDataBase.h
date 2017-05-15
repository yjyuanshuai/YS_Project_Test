//
//  YSTestDataBase.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/19.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "FMDBMigrationManager.h"

@interface YSTestDataBase : NSObject

+ (void)initDB;
+ (NSString *)dbPath;
+ (FMDatabaseQueue *)getDBQueue;
+ (void)closeDB;
+ (FMDBMigrationManager *)initDBMigrationManager;

@end
