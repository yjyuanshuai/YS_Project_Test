//
//  YSBluetoothTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 17/5/19.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSBluetoothTableViewCell.h"
#import "NSString+YSStringDo.h"
#import <CoreBluetooth/CoreBluetooth.h>

@implementation YSBluetoothTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [UILabel new];
        _nameLabel.font = YSFont_Sys(16);
        [self.contentView addSubview:_nameLabel];

        _infoLabel = [UILabel new];
        _infoLabel.font = YSFont_Sys(13);
        _infoLabel.textColor = YSColorRGB(200, 200, 200);
        [self.contentView addSubview:_infoLabel];

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(10);
        }];

        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
            make.left.equalTo(_nameLabel);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

- (void)setPeripheralInfo:(CBPeripheral *)per
{
    NSString * perName = [NSString stringWithFormat:@"%@", per.name];
    _nameLabel.textColor = [UIColor blackColor];
    if ([perName isBlank]) {
        _nameLabel.textColor = YSColorRGB(200, 200, 200);
        perName = @"未知名";
    }

    NSString * uuid = [NSString stringWithFormat:@"%@", per.identifier.UUIDString];
    if ([uuid isBlank]) {
        uuid = @"UUID未知";
    }

    _nameLabel.text = perName;
    _infoLabel.text = uuid;
}

@end
