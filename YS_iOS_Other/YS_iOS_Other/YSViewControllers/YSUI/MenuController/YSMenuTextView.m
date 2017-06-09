//
//  YSMenuTextView.m
//  YS_iOS_Other
//
//  Created by YJ on 17/6/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSMenuTextView.h"

@implementation YSMenuTextView


- (UIResponder *)nextResponder
{
    if (_overrideNext != nil) {
        return _overrideNext;
    }
    return [super nextResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (_overrideNext != nil) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

@end
