//
//  OneCollectionReusableView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/13.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneCollectionReusableView.h"

@implementation OneCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        self.headerLabel.textColor = [UIColor blackColor];
        [self addSubview:self.headerLabel];
    }
    return self;
}

@end
