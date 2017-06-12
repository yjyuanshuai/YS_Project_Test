//
//  YSMenuTextView.m
//  YS_iOS_Other
//
//  Created by YJ on 17/6/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSMenuTextView.h"

@implementation YSMenuTextView
@synthesize overrideNext;

- (UIResponder *)nextResponder
{
    if (overrideNext != nil) {
        return overrideNext;
    }
    return [super nextResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (overrideNext != nil) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

@end
