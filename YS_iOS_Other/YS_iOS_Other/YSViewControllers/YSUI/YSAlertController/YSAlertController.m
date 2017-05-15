//
//  YSAlertController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/11/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSAlertController.h"
#import "AlertControllerTableViewCell.h"

static NSString * const AlertConCellID = @"AlertConCellID";

@interface YSAlertController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * alertConTableView;

@end

@implementation YSAlertController
{
    NSMutableArray * _alertConArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    _alertConArr = [@[] mutableCopy];
}

- (void)createAlertConTableView
{
    _alertConTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _alertConTableView.delegate = self;
    _alertConTableView.dataSource = self;
    [self.view addSubview:_alertConTableView];
    
    [_alertConTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_alertConTableView registerClass:[AlertControllerTableViewCell class] forCellReuseIdentifier:AlertConCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_alertConArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlertControllerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AlertConCellID];
    [cell setAlertConCellContent:_alertConArr[indexPath.row]];
    return cell;
}

//- (void)tableView

@end
