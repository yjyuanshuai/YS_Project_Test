//
//  AlertControllerTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/11/9.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertControllerTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * showLabel;

- (void)setAlertConCellContent:(NSString *)str;

@end
