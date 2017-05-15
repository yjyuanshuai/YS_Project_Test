//
//  YSScrollView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSScrollView.h"

@implementation YSScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
       
        
    }
    return self;
}

- (void)createSubView:(CGRect)frame
{
    self.ysScrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.ysScrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    self.ysScrollView.contentOffset = CGPointZero;
    [self addSubview:self.ysScrollView];
    
    self.ysPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
    self.ysPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.ysPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:self.ysPageControl];
}

#pragma mark - set
- (void)setYsContentSize:(CGSize)ysContentSize
{
    _ysContentSize = ysContentSize;
}

- (void)setYsContentOffSet:(CGPoint)ysContentOffSet
{
    _ysContentOffSet = ysContentOffSet;
}



@end
