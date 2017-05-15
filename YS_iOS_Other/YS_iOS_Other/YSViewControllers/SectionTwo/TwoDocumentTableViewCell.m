//
//  TwoDocumentTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "TwoDocumentTableViewCell.h"
#import "docModel.h"
#import "NSString+YSStringDo.h"

@implementation TwoDocumentTableViewCell
{
    sectionDetailModel * _model;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellContent:(sectionDetailModel *)model
{
    _model = model;
    _titleLabel.text = _model.title;
    _detailLabel.text = _model.detail;

    _titleLabel.frame = CGRectMake(10, 10, kScreenWidth - 20, 20);
    
    UIFont * font = [UIFont systemFontOfSize:14.0];
    _titleLabel.font = font;
    CGFloat height = [_model.detail calculateHeightWithMaxWidth:kScreenWidth - 50 font:font miniHeight:20];
    _detailLabel.frame = CGRectMake(40, CGRectGetMaxY(_titleLabel.frame), kScreenWidth - 40 - 10, height);
}

+ (CGFloat)getDocumentCellHeight:(NSString *)str
{
    UIFont * font = [UIFont systemFontOfSize:14.0];
    CGFloat height = [str calculateHeightWithMaxWidth:kScreenWidth - 50 font:font miniHeight:20];
    return 10 + 20 + height + 10 + 20;
}




@end
