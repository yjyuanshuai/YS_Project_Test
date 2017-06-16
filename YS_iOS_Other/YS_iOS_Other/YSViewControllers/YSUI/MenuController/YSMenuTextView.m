//
//  YSMenuTextView.m
//  YS_iOS_Other
//
//  Created by YJ on 17/6/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSMenuTextView.h"

@implementation YSMenuTextView

/*
- (UIResponder *)nextResponder
{
    if (overrideNext != nil) {
        return overrideNext;
    }
    return [super nextResponder];
}

 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self resetMenuForTextView];
    }
    return self;
}

- (void)resetMenuForTextView
{
    UIMenuItem * cusMenu1 = [[UIMenuItem alloc] initWithTitle:@"tex复制" action:@selector(cusMenuItemSelector:)];
    [[UIMenuController sharedMenuController] setMenuItems:@[cusMenu1]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MenuWillHidden) name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)cusMenuItemSelector:(UIMenuController *)menu
{
    DDLogInfo(@"------- text view custem menu item.");
}

- (void)MenuWillHidden
{
    [self resetMenuForTextView];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cusMenuItemSelector:)) {
        return YES;
    }
    return NO;
}

@end
