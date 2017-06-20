//
//  YSFirstPageVC.m
//  YS_LightBlue
//
//  Created by YJ on 17/5/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSFirstPageVC.h"
#import "YSFirstPageTableViewCell.h"
#import "YSFirstPageAddVirtualCell.h"
#import "YSFirstPageVirtualCell.h"
#import "YSBluetoothModel.h"
#import "YSPeripheralDetailVC.h"

#import "YSBluetooth.h"

static NSString * const PeripheralCellID = @"PeripheralCellID";
static NSString * const VirtualPeripheralCellID = @"VirtualPeripheralCellID";
static NSString * const AddVirtualPeripheralCellID = @"AddVirtualPeripheralCellID";

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
    [self scanBlueToothPeripherals];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 135, 30)];
    UIImageView * titleImageView = [[UIImageView alloc] initWithFrame:titleView.bounds];
    titleImageView.image = [UIImage imageNamed:@"NavTitleImage"];
    [titleView addSubview:titleImageView];
    self.navigationItem.titleView = titleView;

    UIBarButtonItem * sortBarItem = [[UIBarButtonItem alloc] initWithTitle:[YSLocalizableTool ys_localizedStringWithKey:@"sortbaritem_title"] style:UIBarButtonItemStylePlain target:self action:@selector(clickSort:)];
    UIBarButtonItem * filterBarItem = [[UIBarButtonItem alloc] initWithTitle:[YSLocalizableTool ys_localizedStringWithKey:@"filterbaritem_title"] style:UIBarButtonItemStylePlain target:self action:@selector(clickFilter:)];
    self.navigationItem.leftBarButtonItem = sortBarItem;
    self.navigationItem.rightBarButtonItem = filterBarItem;

    _peripheralsArr = [NSMutableArray array];
    _virturalPersArr = [NSMutableArray array];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.estimatedRowHeight = 80;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];

    [_tableView registerClass:[YSFirstPageTableViewCell class] forCellReuseIdentifier:PeripheralCellID];
    [_tableView registerClass:[YSFirstPageVirtualCell class] forCellReuseIdentifier:VirtualPeripheralCellID];
    [_tableView registerClass:[YSFirstPageAddVirtualCell class] forCellReuseIdentifier:AddVirtualPeripheralCellID];
}

- (void)scanBlueToothPeripherals
{
    __weak typeof(self) weakSelf = self;

    [[YSBluetooth sharesYSBluetooth] setYSBTCenMan_UpdateStateBlock:^(CBCentralManager *central) {

    }];

    [[YSBluetooth sharesYSBluetooth] setYSBTCenMan_StartScanWithCBUUIDs:nil options:nil discoverPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *rssi) {

        YSPeripheralModel * model = [[YSPeripheralModel alloc] init];
        model.cbPeripheral = peripheral;
        model.pname = peripheral.name;
        model.puuid = peripheral.identifier.UUIDString;
        model.pServicesNum = [NSString stringWithFormat:@"%ld", [peripheral.services count]];

        if ([weakSelf updateCBManPeropheral:model]) {
            [weakSelf.peripheralsArr addObject:model];
            [weakSelf.tableView reloadData];
        }
    }];
}

// NO：已存在
- (BOOL)updateCBManPeropheral:(YSPeripheralModel *)model
{
    __weak typeof(self) weakSelf = self;

    for (int i = 0; i < [weakSelf.peripheralsArr count]; i++) {
        YSPeripheralModel * inModel = [weakSelf.peripheralsArr objectAtIndex:i];
        if ([inModel.puuid isEqualToString:model.puuid]) {
            [weakSelf.peripheralsArr replaceObjectAtIndex:i withObject:inModel];
            return NO;
        }
    }
    return YES;
}

- (void)clickSort:(UIBarButtonItem *)sort
{

}

- (void)clickFilter:(UIBarButtonItem *)filter
{

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
        return [_virturalPersArr count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YSFirstPageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PeripheralCellID];
        if (indexPath.row < [_peripheralsArr count]) {
            [cell setFirstPageCell:_peripheralsArr[indexPath.row]];
        }
        return cell;
    }
    else {
        if (indexPath.row == [_virturalPersArr count]) {
            YSFirstPageAddVirtualCell * cell = [tableView dequeueReusableCellWithIdentifier:AddVirtualPeripheralCellID];

            return cell;
        }
        else {
            YSFirstPageVirtualCell * cell = [tableView dequeueReusableCellWithIdentifier:VirtualPeripheralCellID];
            if (indexPath.row < [_virturalPersArr count]) {
                [cell setFirstPageVirtualCell:_virturalPersArr[indexPath.row] indexPath:indexPath];
            }
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    sectionView.backgroundColor = YS_Default_BlueColor;
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30)];
    titleLabel.font = YS_Font(15.0);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    [sectionView addSubview:titleLabel];

    if (section == 0) {
        titleLabel.text = [YSLocalizableTool ys_localizedStringWithKey:@"firstpage_section_per"];
    }
    else {
        titleLabel.text = [YSLocalizableTool ys_localizedStringWithKey:@"firstpage_section_vir"];
    }
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        if (indexPath.row < [_peripheralsArr count]) {

            YSPeripheralModel * model = _peripheralsArr[indexPath.row];
            [[YSBluetooth sharesYSBluetooth] setYSBTCenMan_ConnectPeripheral:model options:nil successBlock:^(CBCentralManager *central, CBPeripheral *peripheral) {

                YSPeripheralDetailVC * detailVC = [[YSPeripheralDetailVC alloc] initWithPerModel:model];
                [self.navigationController pushViewController:detailVC animated:YES];

            } failBlock:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {

            }];
        }
    }
    else {
        if (indexPath.row == [_virturalPersArr count]) {
            // 添加新的虚拟外设
        }
        else {
            // 设置虚拟外设的服务
        }
    }
}

@end
