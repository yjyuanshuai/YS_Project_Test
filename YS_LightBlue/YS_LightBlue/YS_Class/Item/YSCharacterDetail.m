//
//  YSCharacterDetail.m
//  YS_LightBlue
//
//  Created by YJ on 2017/6/20.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCharacterDetail.h"
#import "YSBluetooth.h"

@interface YSCharacterDetail ()

@property (nonatomic, strong) CBPeripheral * currentPer;
@property (nonatomic, strong) CBCharacteristic * currentCharacter;

@end

@implementation YSCharacterDetail

- (instancetype)initWithPeripheral:(CBPeripheral *)per character:(CBCharacteristic *)character
{
    self = [super init];
    if (self) {
        _currentPer = per;
        _currentCharacter = character;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initUIAndData];
    [self readCharacter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = [NSString stringWithFormat:@"%@", _currentCharacter.UUID];
}

- (void)readCharacter
{
//    __weak typeof(self) weakSelf = self;

    [YSBluetooth ysBRCenMan_ReadCharactersBlock:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {

        NSLog(@"++++++ %@", characteristic.value);

    }].updateCharacterValue(_currentPer, _currentCharacter);

    [YSBluetooth ysBTCenMan_DiscoverDescriptForCharacterBlock:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {

        NSLog(@"------ %@", characteristic.descriptors);

    }].discoverDescriptForCharacter(_currentPer, _currentCharacter);
}


@end
