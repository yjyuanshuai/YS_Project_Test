//
//  YSFirstPageTableViewCell.m
//  YS_LightBlue
//
//  Created by YJ on 17/5/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSFirstPageTableViewCell.h"
#import "NSString+YSStringDo.h"
#import "YSBlueToothManager.h"

@implementation YSFirstPageTableViewCell
{
    CAShapeLayer * _bottemLayer;    // 底部layer
    CAShapeLayer * _updateLayer;    // 更新的layer
    CAShapeLayer * _colorLayer;     // 控制颜色的layer
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        _signStrengthView = [UIView new];
        [self.contentView addSubview:_signStrengthView];

        _signStrengthLabel = [UILabel new];
        _signStrengthLabel.textColor = [UIColor blackColor];
        _signStrengthLabel.font = YS_Font(12.0);
        _signStrengthLabel.textAlignment = NSTextAlignmentCenter;
        _signStrengthLabel.text = @"---";
        [self.contentView addSubview:_signStrengthLabel];

        _nameLabel = [UILabel new];
        _nameLabel.text = [YSLocalizableTool ys_localizedStringWithKey:@"noname"];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = YS_Font(16.0);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];

        _servicesLabel = [UILabel new];
        _servicesLabel.text = [NSString stringWithFormat:[YSLocalizableTool ys_localizedStringWithKey:@"services"], [YSLocalizableTool ys_localizedStringWithKey:@"service_num"]];
        _servicesLabel.textColor = YS_Default_GrayColor;
        _servicesLabel.textAlignment = NSTextAlignmentLeft;
        _servicesLabel.font = YS_Font(14.0);
        [self.contentView addSubview:_servicesLabel];

        [_signStrengthView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];

        [_signStrengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_signStrengthView.mas_bottom).offset(10);
            make.left.equalTo(_signStrengthView);
            make.right.equalTo(_signStrengthView);
        }];

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(_signStrengthView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-15);
        }];

        [_servicesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
            make.left.equalTo(_nameLabel);
            make.right.equalTo(_nameLabel);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
    }
    return self;
}

- (void)setFirstPageCell:(YSPeripheralModel *)model
{

    if (![model.perName isBlank]) {
        _nameLabel.text = model.perName;
    }
    else {
        _nameLabel.text = [YSLocalizableTool ys_localizedStringWithKey:@"noname"];
    }
    
    if ([model.perServicesNum integerValue] > 0) {
        _servicesLabel.text = [NSString stringWithFormat:[YSLocalizableTool ys_localizedStringWithKey:@"services"], model.perServicesNum];
    }
    else {
        _servicesLabel.text = [NSString stringWithFormat:[YSLocalizableTool ys_localizedStringWithKey:@"services"], [YSLocalizableTool ys_localizedStringWithKey:@"service_num"]];
    }
}

- (void)drawSignStrength
{


}

// 底部
- (CAShapeLayer *)setBottemLayer
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:_signStrengthView.bounds];

    _bottemLayer = [[CAShapeLayer alloc] init];
    _bottemLayer.frame = _signStrengthView.bounds;
    _bottemLayer.path = path.CGPath;
    _bottemLayer.lineCap = kCALineCapButt;
    _bottemLayer.lineDashPattern = @[@(5), @(10)];
    _bottemLayer.lineWidth = 15;
    _bottemLayer.strokeColor = YS_Default_GrayColor.CGColor;
    _bottemLayer.fillColor = [UIColor redColor].CGColor;
    return _bottemLayer;
}

- (CAShapeLayer *)setUpdateLayer
{
    return _updateLayer;
}

@end
