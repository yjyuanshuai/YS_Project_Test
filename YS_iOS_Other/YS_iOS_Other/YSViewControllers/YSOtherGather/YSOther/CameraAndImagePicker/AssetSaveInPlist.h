//
//  AssetSaveInPlist.h
//  YS_iOS_Other
//
//  Created by YJ on 17/3/16.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetSaveInPlist : NSObject <NSCoding>

@property (nonatomic, strong) id imageAsset;
@property (nonatomic, strong) NSString * imageSort;

- (instancetype)initWithAsset:(id)imageAsset sort:(NSString *)sort;

@end
