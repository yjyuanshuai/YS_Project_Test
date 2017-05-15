//
//  YSCustemSearchBar.h
//  YS_iOS_Other
//
//  Created by YJ on 16/9/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSCustemSearchBar : UISearchBar

@property (nonatomic, strong) UIFont * defaultFont;
@property (nonatomic, strong) UIColor * defaultColor;

@property (nonatomic, strong) UIColor * defaultLineColor;
@property (nonatomic, assign) CGFloat defaultLineWidth;

- (instancetype)initWithFrame:(CGRect)frame
                         font:(UIFont *)textFont
                        color:(UIColor *)textColor;

@end
