//
//  YSHealthKitVC.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/7/3.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSHealthKitVC.h"
#import "AppDelegate.h"
#import "HKHealthStore+AAPLExtensions.h"
@import HealthKit;

static NSString * const dataTypeKey = @"dataTypeKey";
static NSString * const dataTypeName = @"dataTypeName";
static NSString * const dataValue = @"dataValue";

NSString * shengao = @"health_shengao";
NSString * tizhong  = @"health_tizhong";
NSString * huodongnengliang = @"health_huodongnengliang";
NSString * shengri = @"health_shengri";
NSString * xingbie = @"health_xingbie";
NSString * buxing = @"health_buxing";
NSString * paobu = @"health_paobu";

@interface YSHealthKitVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) HKHealthStore * healthStore;
@property (nonatomic, strong) UITableView * healthTableView;

@end

@implementation YSHealthKitVC
{
    NSMutableArray * _sectionTitleArr;
    NSMutableArray * _contentArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initUIAndData];
    [self createTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self requestHealthData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"健康";

    self.healthStore = [AppDelegate defaultAppDelegate].healthStore;

    _sectionTitleArr = [@[@"健康数据", @"膳食记录"] mutableCopy];

    NSArray * healthData = @[[self originDataDicType:@"身高" key:shengao],
                             [self originDataDicType:@"体重" key:tizhong],
                             [self originDataDicType:@"活动能量" key:huodongnengliang],
                             [self originDataDicType:@"生日" key:shengri],
                             [self originDataDicType:@"性别" key:xingbie],
                             [self originDataDicType:@"步行" key:buxing],
                             [self originDataDicType:@"步行+跑步" key:paobu]];
    NSArray * foodData = @[];
    [_contentArr addObjectsFromArray:@[healthData, foodData]];
}

- (NSDictionary *)originDataDicType:(NSString *)type key:(NSString *)key
{
    return [self getDataDicType:type key:key value:@""];
}

- (NSDictionary *)getDataDicType:(NSString *)type key:(NSString *)key value:(NSString *)value
{
    return @{dataTypeKey:key,
             dataTypeName:type,
             dataValue:value};
}

- (void)createTableView
{
    _healthTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _healthTableView.delegate = self;
    _healthTableView.dataSource = self;
    [self.view addSubview:_healthTableView];

    [_healthTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestHealthData
{
    if (![HKHealthStore isHealthDataAvailable] || !self.healthStore) {    // 判断设备是否可用（iPad 不可用）
        DDLogInfo(@"------- HealthData Unavailable");
        return;
    }

    NSSet * writeDataSet = [self dataTypesToWrite];
    NSSet * readDataSet = [self dataTypesToRead];

    [self.healthStore requestAuthorizationToShareTypes:writeDataSet
                                             readTypes:readDataSet
                                            completion:^(BOOL success, NSError * _Nullable error) {

                                            if (!success) {
                                                DDLogInfo(@"------ health error: %@", error);
                                            }

                                                [self updateTableViewHealthData];
                                            
                                        }];

}

// 写入
- (NSSet *)dataTypesToWrite {
    // 膳食能量
    HKQuantityType * dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];

    // 身高
    HKQuantityType * heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];

    // 体重
    HKQuantityType * weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];

    return [NSSet setWithObjects:dietaryCalorieEnergyType, heightType, weightType, nil];
}

// 可读取
- (NSSet *)dataTypesToRead {
    // 膳食能量
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];

    // 活动能量
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];

    // 身高
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];

    // 体重
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];

    // 步数
    HKQuantityType * stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

    // 步行+跑步距离
    HKQuantityType * walkingRuningType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];

    // 生日
    HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];

    // 性别
    HKCharacteristicType *biologicalSexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];

    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, stepType, walkingRuningType, birthdayType, biologicalSexType, nil];
}

- (void)updateTableViewHealthData
{
    // 获取只读数据
    // 生日
    NSString * birthday = @"";
    NSError * birthdayError = nil;
    NSDate * birthdayDate = [_healthStore dateOfBirthWithError:&birthdayError];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    birthday = [dateFormatter stringFromDate:birthdayDate];

    // 性别
    NSString * sex = @"";
    NSError * sexError = nil;
    HKBiologicalSex ysBiologicalSex = [_healthStore biologicalSexWithError:&sexError].biologicalSex;
    if (ysBiologicalSex == HKBiologicalSexFemale) {
        sex = @"女";
    }
    else if (ysBiologicalSex == HKBiologicalSexMale) {
        sex = @"男";
    }
    else {
        sex = @"未知";
    }

    // 获取其他数据
    // 身高
    __block NSString * height = @"";
    NSLengthFormatter * lengthFormatter = [[NSLengthFormatter alloc] init];
    lengthFormatter.unitStyle = NSFormattingUnitStyleLong;

    NSLengthFormatterUnit lengthFormatterUnit = NSLengthFormatterUnitInch;
    NSString * heightUnitStr = [lengthFormatter unitStringFromValue:10 unit:lengthFormatterUnit];

    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];

    [self.healthStore aapl_mostRecentQuantitySampleOfType:heightType
                                                predicate:nil
                                               completion:^(HKQuantity *mostRecentQuantity, NSError *error) {

                                                   if (!mostRecentQuantity) {
                                                       DDLogInfo(@"------- update error");
                                                   }
                                                   else {
                                                       HKUnit *heightUnit = [HKUnit inchUnit];
                                                       double usersHeight = [mostRecentQuantity doubleValueForUnit:heightUnit];

                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           NSString * heightNum = [NSNumberFormatter localizedStringFromNumber:@(usersHeight) numberStyle:NSNumberFormatterNoStyle];

                                                           height = [NSString stringWithFormat:@"%@(%@)", heightNum, heightUnitStr];
                                                       });
                                                   }
                                               }];

    // 体重
    __block NSString * weight = @"";
    NSMassFormatter *massFormatter = [[NSMassFormatter alloc] init];
    massFormatter.unitStyle = NSFormattingUnitStyleLong;

    NSMassFormatterUnit weightFormatterUnit = NSMassFormatterUnitPound;
    NSString *weightUnitString = [massFormatter unitStringFromValue:10 unit:weightFormatterUnit];

    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    [self.healthStore aapl_mostRecentQuantitySampleOfType:weightType
                                                predicate:nil
                                               completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
                                                   if (!mostRecentQuantity) {

                                                   }
                                                   else {
                                                       HKUnit *weightUnit = [HKUnit poundUnit];
                                                       double usersWeight = [mostRecentQuantity doubleValueForUnit:weightUnit];

                                                       // Update the user interface.
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           NSString * weightNum = [NSNumberFormatter localizedStringFromNumber:@(usersWeight) numberStyle:NSNumberFormatterNoStyle];
                                                           weight = [NSString stringWithFormat:@"%@(%@)", weightNum, weightUnitString];
                                                       });

                                                   }
                                                }];

    NSArray * sectionContentArr = _contentArr[0];
    for (NSDictionary * dic in sectionContentArr) {
        NSString * key = dic[dataTypeKey];
        if ([key isEqualToString:shengri]) {

        }
        else if ([key isEqualToString:shengao]) {

        }
        else if ([key isEqualToString:tizhong]) {

        }
        else if ([key isEqualToString:xingbie]) {

        }
    }
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionTitleArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_contentArr count] > 0) {
        NSArray * content = _contentArr[section];
        return [content count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const HealthKitCellID = @"HealthKitCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:HealthKitCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HealthKitCellID];
    }
    if (indexPath.section < [_contentArr count]) {
        NSArray * content = _contentArr[indexPath.section];
        if (indexPath.row < [content count]) {
            NSDictionary * dic = content[indexPath.row];
            cell.textLabel.text = dic[dataTypeKey];
            cell.detailTextLabel.text = dic[dataValue];
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 55, 45)];
    label.text = _sectionTitleArr[section];
    [sectionView addSubview:label];

    if (section == 1) {
        UIButton * addFoodBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        addFoodBtn.frame = CGRectMake(CGRectGetMaxX(label.frame), 0, 45, 45);
        [addFoodBtn addTarget:sectionView action:@selector(clickToAddFoodData:) forControlEvents:UIControlEventTouchUpInside];
        [sectionView addSubview:addFoodBtn];
    }

    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -
- (void)clickToAddFoodData:(UIButton *)btn
{
    // 增加膳食能量

}

@end
