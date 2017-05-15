//
//  YSCustemGesture.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCustemGesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

static CGFloat kMinSpace = 10.0;
static CGFloat kMaxTouchCount = 3;

@implementation YSCustemGesture

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    _startPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * currentTouch = [touches anyObject];
    CGPoint currentPoint = [currentTouch locationInView:self.view];
    
    CGFloat xSpace = currentPoint.x - _startPoint.x;
    CGFloat ySpace = currentPoint.y - _startPoint.y;
    YSDirection currentDirection = [self returnDirection:currentPoint];
    
    
    // 移动的 X/Y 轴间距离值是否符合要求，足够大
    if (ABS(xSpace) >= kMinSpace || ABS(ySpace) >= kMinSpace) {
        
        // 判断是否有三次不同方向的动作，如果有则手势结束，将执行回调方法
        if ([self currentDirectionDifferentlast:currentDirection]) {
            
            _tickleCount++;
            _direction = currentDirection;
            _startPoint = currentPoint;
            
            if (_tickleCount >= kMaxTouchCount && self.state == UIGestureRecognizerStatePossible) {
                self.state = UIGestureRecognizerStateEnded;
            }
        }
    }
    else {
        
        NSLog(@"----------------- move end");
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self reset];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self reset];
}

- (void)reset
{
    _startPoint = CGPointZero;
    _direction = YSDirectionUnknow;
    _endPoint = CGPointZero;
    _tickleCount = 0;
}



#pragma mark - private
- (BOOL)currentDirectionDifferentlast:(YSDirection)currentDirection
{
    if (currentDirection == YSDirectionUnknow) {
        
        return YES;
        
    }
    else if ((currentDirection == YSDirectionUp ||
              currentDirection == YSDirectionLeftAndUp ||
              currentDirection == YSDirectionRightAndUp) &&
             (_direction == YSDirectionDown ||
              _direction == YSDirectionLeftAndDown ||
              _direction == YSDirectionRightAndDown)) {
                 
                 return YES;
    
    }
    else if ((currentDirection == YSDirectionDown ||
              currentDirection == YSDirectionLeftAndDown ||
              currentDirection == YSDirectionRightAndDown) &&
             (_direction == YSDirectionUp ||
              _direction == YSDirectionLeftAndUp ||
              _direction == YSDirectionRightAndUp)) {
                 
                 return YES;
                 
             }
    else if ((currentDirection == YSDirectionLeft ||
              currentDirection == YSDirectionLeftAndUp ||
              currentDirection == YSDirectionLeftAndDown) &&
             (_direction == YSDirectionRight ||
              _direction == YSDirectionRightAndUp ||
              _direction == YSDirectionRightAndDown)) {
                 
                 return YES;
    
    }
    else if ((currentDirection == YSDirectionRight ||
              currentDirection == YSDirectionRightAndUp ||
              currentDirection == YSDirectionRightAndDown) &&
             (_direction == YSDirectionLeft ||
              _direction == YSDirectionLeftAndUp ||
              _direction == YSDirectionLeftAndDown)) {
                 
                 return YES;
                 
             }
    else {
        
        return NO;
        
    }
}

- (YSDirection)returnDirection:(CGPoint)currentPoint
{
    CGFloat xSpace = currentPoint.x - _startPoint.x;
    CGFloat ySpace = currentPoint.y - _startPoint.y;
    
    if (xSpace > 0 && ySpace==0) {
        return YSDirectionRight;
    }
    else if (xSpace < 0 && ySpace == 0) {
        return YSDirectionLeft;
    }
    else if (xSpace == 0 && ySpace > 0) {
        return YSDirectionDown;
    }
    else if (xSpace == 0 && ySpace < 0) {
        return YSDirectionUp;
    }
    else if (xSpace < 0 && ySpace < 0) {
        return YSDirectionLeftAndUp;
    }
    else if (xSpace < 0 && ySpace > 0) {
        return YSDirectionLeftAndDown;
    }
    else if (xSpace > 0 && ySpace > 0 ) {
        return YSDirectionRightAndDown;
    }
    else if (xSpace > 0 && ySpace < 0) {
        return YSDirectionRightAndUp;
    }
    else {
        return YSDirectionUnknow;
    }
}

@end
