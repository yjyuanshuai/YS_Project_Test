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
        UILongPressGestureRecognizer * longGesure = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickLongGesure)];
        [self addGestureRecognizer:longGesure];
    }
    return self;
}

- (void)clickLongGesure
{
    [self becomeFirstResponder];

    if (_delegate && [_delegate respondsToSelector:@selector(showMenu)]) {
        [_delegate showMenu];
    }

    UIMenuItem * menuItem1 = [[UIMenuItem alloc] initWithTitle:@"cus复制" action:@selector(custemCopy:)];
    UIMenuItem * menuItem2 = [[UIMenuItem alloc] initWithTitle:@"cus粘贴" action:@selector(custemPaste:)];
    UIMenuItem * menuItem3 = [[UIMenuItem alloc] initWithTitle:@"cus剪切" action:@selector(custemCut:)];

    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:@[menuItem1]];
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES animated:YES];
}

- (void)custemCopy:(UIMenuController *)menu
{
    NSLog(@"click label menu item  ------- %s", __func__);

    [UIPasteboard generalPasteboard].string = self.text;
}

- (void)custemPaste:(UIMenuController *)menu
{
    NSLog(@"click label menu item  ------- %s", __func__);

    self.text = [UIPasteboard generalPasteboard].string;
}

- (void)custemCut:(UIMenuController *)menu
{
    NSLog(@"click label menu item  ------- %s", __func__);

    [UIPasteboard generalPasteboard].string = self.text;
    self.text = @"";
}

#pragma mark -

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(custemPaste:) ||
        (action == @selector(custemCopy:) && self.text) ||
        (action == @selector(custemCut:) && self.text)) {

        return YES;
    }
    return NO;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//}

@end
