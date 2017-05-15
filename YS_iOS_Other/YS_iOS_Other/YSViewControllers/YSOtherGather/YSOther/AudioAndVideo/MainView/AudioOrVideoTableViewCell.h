//
//  AudioTableViewCell.h
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellType)
{
    CellTypeAudio,
    CellTypeVideo
};

@interface AudioOrVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * videoImageView;       // 视屏缩略图
@property (nonatomic, strong) UILabel * audioNameLabel;           // 名称
@property (nonatomic, strong) UITableView * audioTimeLabel;       // 时长

- (void)setCellContent:(CellType)celltype model:(id)model;

@end

