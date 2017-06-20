//
//  YSPeripheralDetailVC.m
//  YS_LightBlue
//
//  Created by YJ on 17/6/6.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSPeripheralDetailVC.h"
#import "YSBluetoothModel.h"
#import "YSBluetooth.h"

static NSString * const PerDetailInfoCellID = @"PerDetailInfoCellID";

@interface YSPeripheralDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YSPeripheralModel * model;
@property (nonatomic, strong) UITableView * deviceDetailTableView;
@property (nonatomic, strong) NSMutableArray * sectionTitlesArr;
@property (nonatomic, strong) NSMutableArray * contentsArr;

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
    [self obtainBluetoothServices];
}

- (void)initUIAndData
{
    self.title = _model.pname;

    _sectionTitlesArr = [@[] mutableCopy];
    _contentsArr = [@[] mutableCopy];
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

    [_deviceDetailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PerDetailInfoCellID];
}

- (void)obtainBluetoothServices
{
    __weak typeof(self) weakSelf = self;

    [YSBluetooth ysBTCenMan_DiscoverServicesWithCBUUIDs:nil
                                  discoverServicesBlock:^(CBPeripheral *peripheral, CBService *service, NSError *error) {

//                                      [weakSelf.sectionTitlesArr addObject:service];
//                                      [weakSelf.deviceDetailTableView reloadData];
                                  }];

    [YSBluetooth ysBTCenMan_DiscoverCharactersWithCBUUIDs:nil
                                  discoverCharactersBlock:^(CBService *service, NSArray *charactersArr, NSError *error) {

                                      [weakSelf.sectionTitlesArr addObject:service];
                                      [weakSelf.contentsArr addObject:charactersArr];
                                      [weakSelf.deviceDetailTableView reloadData];
                                  }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitlesArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray * sectionContentArr = [_contentsArr objectAtIndex:section];
    return [sectionContentArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PerDetailInfoCellID];
    if (indexPath.section < [_contentsArr count]) {
        NSArray * charactersArr = _contentsArr[indexPath.section];
        if (indexPath.row < [charactersArr count]) {
            CBCharacteristic * character = charactersArr[indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", character.UUID];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    sectionView.backgroundColor = YS_Default_BlueColor;

    UILabel * serviceUUID = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 30)];
    [sectionView addSubview:serviceUUID];

    CBService * service = _sectionTitlesArr[section];
    serviceUUID.text = [NSString stringWithFormat:@"%@", service.UUID];

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

@end
