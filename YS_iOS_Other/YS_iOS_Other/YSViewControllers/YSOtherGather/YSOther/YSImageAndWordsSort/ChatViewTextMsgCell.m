//
//  ChatViewTextMsgCell.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/6/13.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ChatViewTextMsgCell.h"
#import "ChatMsgModel.h"
#import "NSString+YSStringDo.h"
#import "YSImageAndTextSort.h"

@implementation ChatViewTextMsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _msgContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 80 - 45 - 10 - 25, 0)];
        _msgContentLabel.font = YSFont_Sys(16);
        _msgContentLabel.textColor = [UIColor blackColor];
        _msgContentLabel.numberOfLines = 0;
        [self.msgBgBtn addSubview:_msgContentLabel];
    }
    return self;
}

- (void)setChatMsgCell:(ChatMsgModel *)model
{
    self.msgTimeLabel.text = model.msgTime;
    self.userNameLabel.text = model.userName;
    [self.userHeadBtn setBackgroundImage:[UIImage imageNamed:@"Expression_57"] forState:UIControlStateNormal];

    if (model.msgType == ChatMsgTypeText) {
        NSString * msgContentStr = [[NSString alloc] initWithData:model.msgContentData encoding:NSUTF8StringEncoding];
        if (![msgContentStr isBlank]) {
            _msgContentLabel.attributedText = [YSImageAndTextSort textAttach:msgContentStr attributDic:@{NSFontAttributeName:_msgContentLabel.font} emoArr:[EmotionFileAnalysis sharedEmotionFile].emoArr originY:-8];
        }

        if (model.isSelfSend) {
            // frame
            CGSize size = [ChatViewTextMsgCell getChatViewTextCellHeight:model];
            self.msgBgBtn.frame = CGRectMake(kScreenWidth - 10 - 45 - size.width - 25, CGRectGetMaxY(self.userNameLabel.frame), size.width + 25, size.height + 23);
            _msgContentLabel.frame = CGRectMake(10, 10, size.width, size.height);
        }
        else {

        }
    }
}

+ (CGFloat)getChatViewTableViewHeight:(ChatMsgModel *)model
{
    CGFloat contentHeight = 0;
    if (model.msgType == ChatMsgTypeText) {
        contentHeight = [ChatViewTextMsgCell getChatViewTextCellHeight:model].height;
    }
    CGFloat height = 10 + 20 + 10 + 20 + contentHeight + 23;
    return height;
}

+ (CGSize)getChatViewTextCellHeight:(ChatMsgModel *)model
{
    NSString * msgContentStr = [[NSString alloc] initWithData:model.msgContentData encoding:NSUTF8StringEncoding];
    CGSize size = [msgContentStr calculateSizeWithMaxSize:CGSizeMake(kScreenWidth - 80 - 45 - 10 - 25, CGFLOAT_MAX) minSize:CGSizeMake(0, 0) font:YSFont_Sys(16)];
    return CGSizeMake(size.width, size.height + 4);
}


@end
