//
//  CollectionTestModel.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/13.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CollectionTestModel.h"

@implementation CollectionTestModel

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title desc:(NSString *)desc
{
    if (self = [self init]) {
        
        NSString * imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];

        self.collectionImage = [UIImage imageNamed:imagePath];
        self.itemTitle = title;
        self.itemDesc = desc;
    }
    return self;
}



@end
