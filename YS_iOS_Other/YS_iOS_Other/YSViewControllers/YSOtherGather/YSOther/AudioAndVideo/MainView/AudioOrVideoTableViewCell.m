//
//  AudioTableViewCell.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "AudioOrVideoTableViewCell.h"
#import "YSSongModel.h"

@implementation AudioOrVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
        [self addConstraintsToSelf];
    }
    
    return self;
}

- (void)addSubViews
{
    _videoImageView = [UIImageView new];
    _videoImageView.image = [UIImage imageNamed:@"cm2_btn_pause"];
    [self.contentView addSubview:_videoImageView];
    
    _audioNameLabel = [UILabel new];
    [self.contentView addSubview:_audioNameLabel];
}

- (void)addConstraintsToSelf
{
    MASAttachKeys(_videoImageView, _audioNameLabel);
    
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5).priorityLow();
    }];
    
    [_audioNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_videoImageView.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [_videoImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setCellContent:(CellType)celltype model:(id)model
{
    if (celltype == CellTypeAudio) {
        
        _videoImageView.hidden = YES;
        NSArray * consArr = [MASViewConstraint installedConstraintsForView:_videoImageView];
        for (MASConstraint * cons in consArr) {
            [cons uninstall];
        }
        
        [_audioNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
        }];
        
        YSSongModel * songModel = (YSSongModel *)model;
        _audioNameLabel.text = songModel.name;
        
    }
    else if (celltype == CellTypeVideo) {
    
        _videoImageView.hidden = NO;
        
        _videoImageView.image = [UIImage imageNamed:@"btn1"];
        
    }
}

@end
