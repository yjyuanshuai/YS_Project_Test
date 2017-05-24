//
//  YSFirstPageTableViewCell.h
//  YS_LightBlue
//
//  Created by YJ on 17/5/23.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSPeripheralModel;

@protocol YSFirstPageCellDelegate;

@interface YSFirstPageTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * servicesLabel;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, weak) id <YSFirstPageCellDelegate> delegate;

- (void)setFirstPageCell:(YSPeripheralModel *)model indexPath:(NSIndexPath *)indexPath;

@end



@protocol YSFirstPageCellDelegate <NSObject>

@optional
- (void)openOrCloseVirtualPer:(NSIndexPath *)indexPath;

@end
