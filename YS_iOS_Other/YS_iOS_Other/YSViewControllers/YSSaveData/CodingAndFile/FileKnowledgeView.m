//
//  FileKnowledgeView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "FileKnowledgeView.h"

@implementation FileKnowledgeView

- (instancetype)init
{
    if (self = [super init]) {
        
        _fileTableView = [UITableView new];
        _fileTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _fileTableView.delegate = self;
        _fileTableView.dataSource = self;
        [self addSubview:_fileTableView];
        
        NSString * vfl1 = @"H:|-0-[_fileTableView]-0-|";
        NSString * vfl2 = @"V:|-0-[_fileTableView]-0-|";
        
        NSArray * c1 = [NSLayoutConstraint constraintsWithVisualFormat:vfl1
                                                               options:0
                                                               metrics:nil
                                                                 views:@{@"_fileTableView":_fileTableView}];
        NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:vfl2
                                                               options:0
                                                               metrics:nil
                                                                 views:@{@"_fileTableView":_fileTableView}];
        [self addConstraints:c1];
        [self addConstraints:c2];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    cell.textLabel.text = @"测试测试测试";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
