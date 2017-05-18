//
//  YSBlueToothVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/5/18.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSBlueToothVC.h"
#import "YSBlueToothManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface YSBlueToothVC () <YSBluetoothManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL hasOpened;
@property (nonatomic, strong) UITableView * bluetoothTableView;

@property (nonatomic, strong) NSMutableArray * peripheralsArr;
@property (nonatomic, strong) NSMutableArray * vitualPeripheralsArr;

@end

@implementation YSBlueToothVC

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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[YSBlueToothManager sharedBlueToothManager] cbManagerStopScanAndDisconnectAllServices];
}

- (void)dealloc
{
    [YSBlueToothManager sharedBlueToothManager].delegate = nil;
}

- (void)initUIAndData
{
    self.title = @"蓝牙";

    _hasOpened = NO;
    _peripheralsArr = [NSMutableArray array];
    _peripheralsArr = [NSMutableArray array];

    [[YSBlueToothManager sharedBlueToothManager] setPeripheralContentStr:@"YJVirtualPeripheral" contentType:YSCBPeripheralConStrType_SubStr];
    [[YSBlueToothManager sharedBlueToothManager] cbManagerStartScan];
    [YSBlueToothManager sharedBlueToothManager].delegate = self;
}

- (void)createTableView
{
    _bluetoothTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _bluetoothTableView.delegate = self;
    _bluetoothTableView.dataSource = self;
    _bluetoothTableView.tableFooterView = [UIView new];
    _bluetoothTableView.rowHeight = 80;
    _bluetoothTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    _bluetoothTableView.sectionFooterHeight = 0.01;
    [self.view addSubview:_bluetoothTableView];

    [_bluetoothTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - YSBluetoothManagerDelegate
- (void)allDiscoverPeripherals:(NSMutableArray *)arr
{
    DDLogInfo(@"------ arr count: %d", [arr count]);
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_peripheralsArr count];     // 发现到的设备
    }
    return [_vitualPeripheralsArr count];   // 正在虚拟的设备
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cell_id = @"BLUETOOTH_CELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }

    if (indexPath.section == 0) {
        if (indexPath.row < [_peripheralsArr count]) {
            CBPeripheral * per = _peripheralsArr[indexPath.row];
            cell.textLabel.text = per.name;
        }
    }
    else {
        // 虚拟外设
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * senctionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel * label = [[UILabel alloc] initWithFrame:senctionView.bounds];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14.0];
    [senctionView addSubview:label];

    if (section == 0) {
        label.text = @"发现的设备";
    }
    else {
        label.text = @"虚拟的设备";
    }
    return senctionView;
}

@end
