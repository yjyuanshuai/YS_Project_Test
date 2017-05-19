//
//  YSBlueToothVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/5/18.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSBlueToothVC.h"
#import "YSBlueToothManager.h"
#import "YSBluetoothTableViewCell.h"
#import <CoreBluetooth/CoreBluetooth.h>

static NSString * const discover_cell_id = @"BLUETOOTH_DISCOVER_CELLID";
static NSString * const vitural_cell_id = @"BLUETOOTH_VIRTUAL_CELLID";

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

    [_peripheralsArr removeAllObjects];
    _peripheralsArr = nil;
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

//    [[YSBlueToothManager sharedBlueToothManager] setPeripheralContentStr:@"YJ" contentType:YSCBPeripheralConStrType_Prefix];
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

    [_bluetoothTableView registerClass:[YSBluetoothTableViewCell class] forCellReuseIdentifier:discover_cell_id];
    [_bluetoothTableView registerClass:[YSBluetoothTableViewCell class] forCellReuseIdentifier:vitural_cell_id];
}

#pragma mark - YSBluetoothManagerDelegate
- (void)discoverNewPeripheral:(CBPeripheral *)per
{
    if (![_peripheralsArr containsObject:per]) {
        [_peripheralsArr addObject:per];
        [_bluetoothTableView reloadData];
    }
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSBluetoothTableViewCell * bluetoothCell = (YSBluetoothTableViewCell *)cell;
    if (indexPath.section == 0 && indexPath.row < [_peripheralsArr count]) {
        CBPeripheral * per = _peripheralsArr[indexPath.row];
        [bluetoothCell setPeripheralInfo:per];
    }
    else if (indexPath.section == 1 && indexPath.row < [_vitualPeripheralsArr count]) {
        // 虚拟外设
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YSBluetoothTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:discover_cell_id];
        return cell;
    }
    else {
        YSBluetoothTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:vitural_cell_id];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * senctionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UILabel * label = [[UILabel alloc] initWithFrame:senctionView.bounds];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = YSFont_Sys(16.0);
    [senctionView addSubview:label];

    if (section == 0) {
        label.text = @"   发现的设备";
    }
    else {
        label.text = @"   虚拟的设备";
    }
    return senctionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row < [_peripheralsArr count]) {
        CBPeripheral * per = _peripheralsArr[indexPath.row];
        [[YSBlueToothManager sharedBlueToothManager] cbManagerConnectWithPeripheral:per];
    }
    else {

    }
}

@end
