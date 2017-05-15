//
//  SearchResultViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()<UITableViewDataSource>

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_resultArr == nil) {
        _resultArr = [@[] mutableCopy];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_resultArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ResultCellID"];
    }
    if (indexPath.row < [_resultArr count]) {
        cell.textLabel.text = _resultArr[indexPath.row];
    }
    return cell;
}

@end
