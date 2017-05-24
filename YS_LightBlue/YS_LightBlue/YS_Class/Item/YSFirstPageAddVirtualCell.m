//
//  YSFirstPageAddVirtualCell.m
//  YS_LightBlue
//
//  Created by YJ on 17/5/24.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSFirstPageAddVirtualCell.h"

@implementation YSFirstPageAddVirtualCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.contentView.backgroundColor = [UIColor whiteColor];

        _leftBtn = [UIButton new];
        _leftBtn.userInteractionEnabled = NO;
        [_leftBtn setImage:[UIImage imageNamed:@"add_virtual_per"] forState:UIControlStateNormal];
        [self.contentView addSubview:_leftBtn];

        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = YS_Font(18.0);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = [YSLocalizableTool ys_localizedStringWithKey:@"create_virtual"];
        [self.contentView addSubview:_nameLabel];

        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(self.contentView);
        }];

        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(_leftBtn.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];

    }
    return self;
}

@end
