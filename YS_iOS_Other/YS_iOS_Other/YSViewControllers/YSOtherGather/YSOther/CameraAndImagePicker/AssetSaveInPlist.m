//
//  AssetSaveInPlist.m
//  YS_iOS_Other
//
//  Created by YJ on 17/3/16.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "AssetSaveInPlist.h"

@implementation AssetSaveInPlist

- (instancetype)initWithAsset:(id)imageAsset sort:(NSString *)sort
{
    if (self = [super init]) {
        self.imageAsset = imageAsset;
        self.imageSort = sort;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.imageAsset = [aDecoder valueForKey:@"imageAsset"];
        self.imageSort = [aDecoder valueForKey:@"imageSort"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder setValue:self.imageAsset forKey:@"imageAsset"];
    [aCoder setValue:self.imageSort forKey:@"imageSort"];
}

@end
