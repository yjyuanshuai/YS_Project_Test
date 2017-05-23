//
//  YSFirstPageVC.m
//  YS_LightBlue
//
//  Created by YJ on 17/5/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSFirstPageVC.h"
#import "YSFirstPageTableViewCell.h"

static NSString * const PeripheralCellID = @"PeripheralCellID";

@interface YSFirstPageVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * peripheralsArr;
@property (nonatomic, strong) NSMutableArray * virturalPersArr;

@end

@implementation YSFirstPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initUIAndData];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    UIImageView * titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleImageView.image = [UIImage imageNamed:@"NavTitleImage"];
    self.navigationItem.titleView = titleImageView;

    _peripheralsArr = [NSMutableArray array];
    _virturalPersArr = [NSMutableArray array];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];

    [_tableView registerClass:[YSFirstPageTableViewCell class] forCellReuseIdentifier:PeripheralCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_peripheralsArr count];
    }
    else {
        return [_virturalPersArr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSFirstPageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PeripheralCellID];

    return cell;
}


@end
