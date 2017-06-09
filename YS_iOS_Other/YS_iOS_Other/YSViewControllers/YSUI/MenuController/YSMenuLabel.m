//
//  YSMenuLabel.m
//  YS_iOS_Other
//
//  Created by YJ on 17/6/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSMenuLabel.h"

@implementation YSMenuLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;

//        UILongPressGestureRecognizer * longGesure = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickLongGesure:)];
//        [longGesure setMinimumPressDuration:0.4];
//        [self addGestureRecognizer:longGesure];
    }
    return self;
}

/*
- (void)clickLongGesure:(UILongPressGestureRecognizer *)gesure
{
    if (_delegate && [_delegate respondsToSelector:@selector(showMenu)]) {
        [_delegate showMenu];

        UIMenuController * menu = [UIMenuController sharedMenuController];
        UIMenuItem * menuItem = [[UIMenuItem alloc] initWithTitle:@"自定义" action:@selector(custemItem:)];
        [menu setMenuItems:@[menuItem]];
        [menu setTargetRect:self.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        [menu update];
    }
}
 */

#pragma mark -

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(custemItem:));
}

@end
