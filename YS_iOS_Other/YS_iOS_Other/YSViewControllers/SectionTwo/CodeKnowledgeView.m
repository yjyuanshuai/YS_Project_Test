//
//  CodeKnowledgeView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "CodeKnowledgeView.h"

@implementation CodeKnowledgeView

- (instancetype)init
{
    if (self = [super init]) {
        
        _codeTableView = [UITableView new];
        _codeTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _codeTableView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_codeTableView];
        
        NSString * vfl1 = @"H:|-0-[_codeTableView]-0-|";
        NSString * vfl2 = @"V:|-0-[_codeTableView]-0-|";
        
        NSArray * c1 = [NSLayoutConstraint constraintsWithVisualFormat:vfl1
                                                               options:0
                                                               metrics:nil
                                                                 views:@{@"_codeTableView":_codeTableView}];
        NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:vfl2
                                                               options:0
                                                               metrics:nil
                                                                 views:@{@"_codeTableView":_codeTableView}];
        [self addConstraints:c1];
        [self addConstraints:c2];
        
    }
    return self;
}

@end
