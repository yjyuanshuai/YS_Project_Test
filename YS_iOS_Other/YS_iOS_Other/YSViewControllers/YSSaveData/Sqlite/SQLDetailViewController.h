//
//  SQLDetailViewController.h
//  YS_iOS_Other
//
//  Created by YJ on 16/7/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

@interface SQLDetailModel : NSObject

@property (nonatomic, strong) NSArray * strArr;

- (instancetype)initWithData:(NSIndexPath *)indexPath;

@end

@interface SQLDetailViewController : YSRootViewController

- (instancetype)initWithIndex:(NSIndexPath *)indexPath titleStr:(NSString *)titleStr;

@end
