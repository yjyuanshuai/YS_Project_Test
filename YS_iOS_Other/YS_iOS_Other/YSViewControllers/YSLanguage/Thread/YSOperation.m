//
//  YSOperation.m
//  YS_iOS_Other
//
//  Created by YJ on 17/3/9.
//  Copyright © 2017年 YJ. All rights reserved.
//



/*
 *自定义并发的NSOperation需要以下步骤：
 1.start方法：该方法必须实现，注意：任何时候都不能调用父类的start方法。
 2.main:该方法可选，如果你在start方法中定义了你的任务，则这个方法就可以不实现，但通常为了代码逻辑清晰，通常会在该方法中定义自己的任务
 3.isExecuting  isFinished 主要作用是在线程状态改变时，产生适当的KVO通知
 4.isConcurrent: 该方法现在已经由isAsynchronous方法代替，并且 NSOperationQueue 也已经忽略这个方法的值。
 5.isAsynchronous: 该方法默认返回 NO ，表示非并发执行。并发执行需要自定义并且返回 YES。后面会根据这个返回值来决定是否并发。
 */


#import "YSOperation.h"

static NSString * const CanceledKey = @"isCancelled";
static NSString * const FinishedKey = @"isFinished";
static NSString * const ExecutingKey = @"isExecuting";

@interface YSOperation()
{
    NSString * _urlStr;
    CallBackBlock _complementBlock;
    CallBackBlock _successBlock;
    CallBackBlock _failBlock;
}

@end

@implementation YSOperation

- (instancetype)initWithUrl:(NSString *)urlStr
               successBlock:(CallBackBlock)successBlock
                  failBlock:(CallBackBlock)failBlock
{
    self = [super init];
    if (self) {
        
        _urlStr = urlStr;
        _successBlock = successBlock;
        _failBlock = failBlock;
        
        self.ys_cancelled = NO;
        self.ys_finished = NO;
        self.ys_executing = NO;
    }
    return self;
}

- (void)start
{
    if ([self isCancelled]) {
        self.ys_cancelled = YES;
        self.ys_executing = NO;
        self.ys_finished = YES;
        return;
    }
    else {
        self.ys_cancelled = NO;
        self.ys_executing = YES;
        self.ys_finished = NO;
        [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    }
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return self.ys_executing;
}

- (BOOL)isCancelled
{
    return self.ys_cancelled;
}

- (BOOL)isFinished
{
    return self.ys_finished;
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:FinishedKey];
    self.ys_finished = finished;
    [self didChangeValueForKey:FinishedKey];
}

- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:ExecutingKey];
    self.ys_executing = executing;
    [self didChangeValueForKey:ExecutingKey];
}

- (void)setCancelled:(BOOL)cancelled
{
    [self willChangeValueForKey:CanceledKey];
    self.ys_cancelled = cancelled;
    [self didChangeValueForKey:CanceledKey];
}



/*  一般使用 main 作为自定义非并发  */
- (void)main
{
    // 捕获异常
    @try {
        // 新建一个自动释放池，如果是异步执行操作，那么将无法访问到主线程的自动释放池
        @autoreleasepool {
            
            // 如果这个 Operation 是在异步线程中执行操作，也就是说main方法在异步线程调用，那么将无法访问主线程的自动释放池，所以要创建了一个属于当前线程的自动释放池
            
            BOOL taskIsFinished = NO;
            if (!taskIsFinished && ![self isCancelled]) {
                
                // 自定义操作
                [self getSession];
                
                // 操作完成
                taskIsFinished = YES;
            }
            
            self.ys_finished = YES;
            self.ys_executing = NO;
        }
    } @catch (NSException *exception) {
        
        DDLogInfo(@"-------------- ysoperation exception: %@", exception.debugDescription);
        
    } @finally {
        
    }
}
 
- (void)getSession
{
    NSURL * url = [NSURL URLWithString:_urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        DDLogInfo(@"------------- current thread: %@", [NSThread currentThread]);
        
        if ([data length] > 0) {
            if (error) {
                if (_failBlock) {
                    _failBlock(@"300000", nil, @"图片下载失败", nil);
                }
            }
            else {
                if (_successBlock) {
                    _successBlock(@"000000", data, @"图片下载成功", error);
                }
            }
        }
    }];

    [task resume];
}

@end
