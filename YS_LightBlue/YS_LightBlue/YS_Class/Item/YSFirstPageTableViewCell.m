//
//  YSFirstPageTableViewCell.m
//  YS_LightBlue
//
//  Created by YJ on 17/5/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSFirstPageTableViewCell.h"
#import "NSString+YSStringDo.h"
#import "YSBluetoothModel.h"

@implementation YSFirstPageTableViewCell
{
    CAShapeLayer * _bottemLayer;    // 底部layer
    CAShapeLayer * _updateLayer;    // 更新的layer
    CAGradientLayer * _colorLayer;     // 控制颜色的layer
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
            make.size.mas_equalTo(CGSizeMake(35, 35));
        }];

        [_signStrengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_signStrengthView.mas_bottom);
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

        [self drawSignStrength];
    }
    return self;
}

- (void)setFirstPageCell:(YSPeripheralModel *)model
{
    if ([model.prssi integerValue] >= 40) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        _signStrengthLabel.text = model.prssi;
    }
    else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _signStrengthLabel.text = model.prssi;
    }
    [self resetTransaction:model.prssi];

    if (![model.pname isBlank]) {
        _nameLabel.text = model.pname;
    }
    else {
        _nameLabel.text = [YSLocalizableTool ys_localizedStringWithKey:@"noname"];
    }
    
    if ([model.pServicesNum integerValue] > 0) {
        _servicesLabel.text = [NSString stringWithFormat:[YSLocalizableTool ys_localizedStringWithKey:@"services"], model.pServicesNum];
    }
    else {
        _servicesLabel.text = [NSString stringWithFormat:[YSLocalizableTool ys_localizedStringWithKey:@"services"], [YSLocalizableTool ys_localizedStringWithKey:@"service_num"]];
    }
}

#pragma mark - 动画
- (void)drawSignStrength
{
    [self setBottemLayer];
    [self setUpdateLayer];
    [self setColorLayer];

    [_bottemLayer addSublayer:_updateLayer];
    [_updateLayer setMask:_colorLayer];
    [_signStrengthView.layer addSublayer:_bottemLayer];

    _signStrengthView.backgroundColor = [UIColor redColor];
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
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:_signStrengthView.bounds];

    _updateLayer = [[CAShapeLayer alloc] init];
    _updateLayer.frame = _signStrengthView.bounds;
    _updateLayer.path = path.CGPath;
    _updateLayer.strokeStart = 0;
    _updateLayer.strokeEnd = 0;
    _updateLayer.lineWidth = 15;
    _updateLayer.lineCap = kCALineCapButt;
    _updateLayer.lineDashPattern = @[@(5), @(10)];
    _updateLayer.strokeColor = [UIColor redColor].CGColor;
    _updateLayer.fillColor = [UIColor clearColor].CGColor;

    return _updateLayer;
}

- (CAGradientLayer *)setColorLayer
{
    NSArray * colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor, (id)[UIColor purpleColor].CGColor];

    UIBezierPath * path = [UIBezierPath bezierPathWithRect:_signStrengthView.bounds];

    _colorLayer = [CAGradientLayer layer];
    _colorLayer.shadowPath = path.CGPath;
    _colorLayer.frame = _signStrengthView.bounds;
    _colorLayer.startPoint = CGPointMake(0, 1);
    _colorLayer.endPoint = CGPointMake(1, 0);
    [_colorLayer setColors:colors];
    return _colorLayer;
}

- (void)resetTransaction:(NSString *)signStrength
{
    NSInteger signStrengthInt = [signStrength integerValue];
    NSInteger percent = signStrengthInt / 100.0;
    if (percent >= 0 && percent <= 1) {

        // 复原
        [CATransaction begin];
        [CATransaction setDisableActions:NO];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [CATransaction setAnimationDuration:0];
        _updateLayer.strokeEnd = 0;
        [CATransaction commit];



        [CATransaction begin];
        [CATransaction setDisableActions:NO];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [CATransaction setAnimationDuration:2.f];
        _updateLayer.strokeEnd = percent;
        [CATransaction commit];

    }
}

@end
