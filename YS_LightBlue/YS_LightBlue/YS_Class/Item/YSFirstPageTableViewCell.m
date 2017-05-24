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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        _leftBtn = [UIButton new];
        [_leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_leftBtn];

        _nameLabel = [UILabel new];
        _nameLabel.text = [YSLocalizableTool ys_localizedStringWithKey:@"noname"];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = YS_Font(16.0);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];

        _servicesLabel = [UILabel new];
        _servicesLabel.text = [NSString stringWithFormat:[YSLocalizableTool ys_localizedStringWithKey:@"services"], @"NO"];
        _nameLabel.textColor = YS_Default_GrayColor;
        _servicesLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_servicesLabel];

        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(self.contentView);
        }];

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(_leftBtn.mas_right).offset(10);
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

- (void)setFirstPageCell:(YSPeripheralModel *)model indexPath:(NSIndexPath *)indexPath
{
    if (model.perType == YSPeripheralType_Per) {
        _leftBtn.userInteractionEnabled = NO;
        [_leftBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    else if (model.perType == YSPeripheralType_Virtual) {
        _leftBtn.userInteractionEnabled = YES;
        _indexPath = indexPath;
        [_leftBtn setImage:[UIImage imageNamed:@"virtual_unselected"] forState:UIControlStateNormal];
    }

    if (![model.perName isBlank]) {
        _nameLabel.text = model.perName;
    }
    
    if ([model.perServicesNum integerValue] > 0) {
        _servicesLabel.text = [NSString stringWithFormat:[YSLocalizableTool ys_localizedStringWithKey:@"services"], model.perServicesNum];
    }
}

- (void)clickLeftBtn:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(openOrCloseVirtualPer:)]) {
        [_delegate openOrCloseVirtualPer:_indexPath];
    }
}

@end
