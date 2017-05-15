//
//  CollectionTestModel.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/13.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollectionTestModel : NSObject

@property (nonatomic, strong) UIImage * collectionImage;
@property (nonatomic, strong) NSString * itemTitle;
@property (nonatomic, strong) NSString * itemDesc;

- (instancetype)initWithImageName:(NSString *)imageName
                            title:(NSString *)title
                             desc:(NSString *)desc;

@end
