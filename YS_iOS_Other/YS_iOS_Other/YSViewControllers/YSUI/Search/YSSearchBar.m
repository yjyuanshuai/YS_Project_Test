//
//  YSSearchBar.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSSearchBar.h"

@implementation YSSearchBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView * subView in self.subviews) {
        for (UIView * subSubView in subView.subviews) {
            if ([NSStringFromClass([subSubView class]) isEqualToString:@"UISearchBarTextField"]) {
                
                if (self.textFeildContentInset.top == 0 &&
                    self.textFeildContentInset.left == 0 &&
                    self.textFeildContentInset.bottom == 0 &&
                    self.textFeildContentInset.right == 0) {
                    
                    self.textFeildContentInset = UIEdgeInsetsMake((self.bounds.size.height - 28.0)/2, 6.0, (self.bounds.size.height - 28.0)/2, 6.0);
                }
                else {
                    CGFloat width = self.bounds.size.width - self.textFeildContentInset.left - self.textFeildContentInset.right;
                    CGFloat height = self.bounds.size.height - self.textFeildContentInset.top - self.textFeildContentInset.bottom;
                    subSubView.frame = CGRectMake(self.textFeildContentInset.left,
                                              self.textFeildContentInset.top,
                                              width,
                                              height);
                    
                }
            }
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self registKVO];
        
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"textFeildContentInset"];
}

#pragma mark - KVO
- (void)registKVO
{
    [self addObserver:self forKeyPath:@"textFeildContentInset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIWithKeyPath:) withObject:keyPath waitUntilDone:NO];
    }else {
        [self updateUIWithKeyPath:keyPath];
    }
}

- (void)updateUIWithKeyPath:(NSString *)keyPath
{
    if ([keyPath isEqualToString:@"textFeildContentInset"]) {
        
    }
}

@end
