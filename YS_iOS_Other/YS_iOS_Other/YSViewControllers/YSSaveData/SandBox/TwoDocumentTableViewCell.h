//
//  TwoDocumentTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class sectionDetailModel;

@interface TwoDocumentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

- (void)setCellContent:(sectionDetailModel *)model;
+ (CGFloat)getDocumentCellHeight:(NSString *)str;

@end
