//
//  YSBluetoothTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 17/5/19.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBPeripheral;

@interface YSBluetoothTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * infoLabel;

- (void)setPeripheralInfo:(CBPeripheral *)per;

@end
