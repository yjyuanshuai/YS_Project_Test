//
//  YSOperation.h
//  YS_iOS_Other
//
//  Created by YJ on 17/3/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBackBlock)(NSString * retCode, id response, NSString * retMessage, NSError * error);

@interface YSOperation : NSOperation

@property (nonatomic, assign) BOOL ys_cancelled;
@property (nonatomic, assign) BOOL ys_finished;
@property (nonatomic, assign) BOOL ys_executing;

- (instancetype)initWithUrl:(NSString *)urlStr              //@"https://httpbin.org/image/png"
               successBlock:(CallBackBlock)successBlock
                  failBlock:(CallBackBlock)failBlock;

@end
