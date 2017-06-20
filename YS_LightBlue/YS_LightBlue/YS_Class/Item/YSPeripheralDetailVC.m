//
//  YSPeripheralDetailVC.m
//  YS_LightBlue
//
//  Created by YJ on 17/6/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSPeripheralDetailVC.h"
#import "YSBluetoothModel.h"

@interface YSPeripheralDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YSPeripheralModel * model;
@property (nonatomic, strong) UITableView * deviceDetailTableView;

@end

@implementation YSPeripheralDetailVC

- (instancetype)initWithPerModel:(YSPeripheralModel *)perModel
{
    self = [super init];
    if (self) {
        _model = perModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initUIAndData];
    [self createTableView];
}

- (void)initUIAndData
{
    self.title = _model.pname;
}

- (void)createTableView
{
    _deviceDetailTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _deviceDetailTableView.delegate = self;
    _deviceDetailTableView.dataSource = self;
    [self.view addSubview:_deviceDetailTableView];

    [_deviceDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)obtainBluetoothServices
{
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource


@end
