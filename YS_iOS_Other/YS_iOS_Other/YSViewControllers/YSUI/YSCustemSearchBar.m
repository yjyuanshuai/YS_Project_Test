//
//  YSCustemSearchBar.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCustemSearchBar.h"

@implementation YSCustemSearchBar

- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)textFont color:(UIColor *)textColor
{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        
        if (textFont == nil) {
            _defaultFont = [UIFont systemFontOfSize:14.0];
        }
        else {
            _defaultFont = textFont;
        }
        
        if (textColor == nil) {
            _defaultColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        }
        else {
            _defaultColor = textColor;
        }
        
        self.searchBarStyle = UISearchBarStyleProminent;
        self.translucent = NO;
        
        _defaultLineColor = _defaultColor;
        _defaultLineWidth = 1.0;
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)setDefaultLineColor:(UIColor *)defaultLineColor
{
    _defaultLineColor = defaultLineColor;
}

- (void)setDefaultLineWidth:(CGFloat)defaultLineWidth
{
    _defaultLineWidth = defaultLineWidth;
}

- (void)drawRect:(CGRect)rect
{
    NSInteger textFeildIndex = [self getSearchBarTextView];
    if (textFeildIndex >= 0) {
        UIView * subView = [self.subviews firstObject];
        UITextField * searchTextFeild = (UITextField *)subView.subviews[textFeildIndex];
        
        searchTextFeild.frame = CGRectMake(5.0, 5.0, self.frame.size.width - 10.0, self.frame.size.height - 10.0);
        searchTextFeild.font = _defaultFont;
        searchTextFeild.textColor = _defaultColor;
        searchTextFeild.backgroundColor = self.barTintColor;
    }
    
    // 下边框颜色
    CGPoint startPoint = CGPointMake(0, self.frame.size.height);
    CGPoint endPoint = CGPointMake(self.frame.size.width, self.frame.size.height);
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:startPoint];
    [bezierPath addLineToPoint:endPoint];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeColor = _defaultLineColor.CGColor;
    shapeLayer.lineWidth = _defaultLineWidth;
    [self.layer addSublayer:shapeLayer];
    
    [super drawRect:rect];
}

#pragma mark - private
- (NSInteger)getSearchBarTextView
{
    UIView * subView = [self.subviews firstObject];
    
    for (int i = 0; i < [subView.subviews count]; i++) {
        
        UIView * subSubView = subView.subviews[i];
        
        if ([NSStringFromClass([subSubView class]) isEqualToString:@"UISearchBarTextField"]) {
            return i;
        }
    }
    return -1;
}


@end
