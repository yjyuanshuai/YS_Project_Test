//
//  ChatBottemView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChatBottemView.h"
#import "NSString+YSStringDo.h"
#import "NSAttributedString+YSAttrStrCategory.h"
#import "YSImageAndTextSort.h"

static CGFloat const ConstHeight = 45;
static CGFloat const TextViewMinHeight = 35;
static CGFloat const TextViewMaxHeight = 100;
static CGFloat const TextViewContentInset = 4;

@implementation ChatBottemView
{
//    NSMutableString * _chatTextViewStr;
    NSMutableAttributedString * _chatTextViewAttrStr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _chatTextViewAttrStr = [[NSMutableAttributedString alloc] init];
        [self checkFrame:frame];
        [self createSubViews];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGFloat)getBottemViewHeight
{
    return self.frame.size.height;
}

- (void)receviceEmoStr:(id)model
{
    if ([model isKindOfClass:[EmotionModel class]]) {
        EmotionModel * emoModel = (EmotionModel *)model;
        _chatTextView.text = [NSString stringWithFormat:@"%@%@", _chatTextView.text, emoModel.cht];
        [self updateUI];
    }
}

- (void)registFirstRespon
{
    [_chatTextView resignFirstResponder];
}

- (void)clearChatText
{
    _chatTextView.text = @"";
    [_chatTextView resignFirstResponder];
    [self updateUI];
}

- (NSString *)getChatText
{
    return _chatTextView.text;
}

#pragma mark -
- (void)checkFrame:(CGRect)frame
{
    if (frame.size.height != ConstHeight + TextViewMinHeight) {
        frame.size.height = ConstHeight + TextViewMinHeight;
    }
    
    if (frame.size.width != kScreenWidth) {
        frame.size.width = kScreenWidth;
    }
    
    if (frame.origin.x != 0) {
        frame.origin.x = 0;
    }
    
    _currentFrame = frame;
    self.frame = frame;
}

- (void)createSubViews
{
    self.chatBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, TextViewMinHeight)];
    [self addSubview:self.chatBgImageView];

    self.chatTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, TextViewMinHeight)];
    self.chatTextView.delegate = self;
    self.chatTextView.font = YSFont_Sys(16);
    self.chatTextView.textContainerInset = UIEdgeInsetsMake(TextViewContentInset, 0, TextViewContentInset, 0);
    self.chatTextView.showsHorizontalScrollIndicator = NO;
    self.chatTextView.showsVerticalScrollIndicator = NO;
    self.chatTextView.alwaysBounceHorizontal = NO;
    self.chatTextView.bounces = NO;
    self.chatTextView.clipsToBounds = YES;
    self.chatTextView.layer.cornerRadius = 3;
    self.chatTextView.autocorrectionType = UITextAutocorrectionTypeNo;  // 设置自动纠错方式
    self.chatTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;    // 设置自动大写方式
    [self addSubview:self.chatTextView];
    
    self.emotionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.emotionBtn.frame = CGRectMake(5, CGRectGetMaxY(self.chatTextView.frame) + 5, 30, 30);
    self.emotionBtn.tag = FunctionBtnTag + FunctionType_Emotion;
    [self.emotionBtn setBackgroundImage:[UIImage imageNamed:@"Expression_1"] forState:UIControlStateNormal];
    [self.emotionBtn addTarget:self action:@selector(clickShowEmotion:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_emotionBtn];
}

#pragma mark - click
- (void)clickShowEmotion:(UIButton *)btn
{
    [self.chatTextView resignFirstResponder];
    NSInteger tag = btn.tag - FunctionBtnTag;
    
    if (_delegate && [_delegate respondsToSelector:@selector(showFunctionViewWithTag:)]) {
        [_delegate showFunctionViewWithTag:tag];
    }
}

- (void)updateUI
{
    CGFloat contentWidth = _chatTextView.frame.size.width;
    CGFloat textHeight = [_chatTextView.text calculateHeightWithMaxWidth:contentWidth font:_chatTextView.font miniHeight:TextViewMinHeight] + 2*TextViewContentInset;
    textHeight = (textHeight > TextViewMaxHeight) ? TextViewMaxHeight: textHeight;

    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.frame = CGRectMake(0, _currentFrame.origin.y - (textHeight - TextViewMinHeight), _currentFrame.size.width, textHeight + ConstHeight);
        weakSelf.chatTextView.frame = CGRectMake(5, 5, kScreenWidth - 10, textHeight);
        weakSelf.emotionBtn.frame = CGRectMake(5, CGRectGetMaxY(weakSelf.chatTextView.frame) + 5, 30, 30);
    });
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self updateUI];
}

/*
 NSRange emotionRange = NSMakeRange(0, 0);
 [_chatTextViewAttrStr deleteCharactersInRange:emotionRange];

 NSMutableAttributedString * textAttrStr = [YSImageAndTextSort textAttach:text attributDic:@{NSFontAttributeName:textView.font} emoArr:[EmotionFileAnalysis sharedEmotionFile].emoArr originY:-8];
 [_chatTextViewAttrStr appendAttributedString:textAttrStr];
 */

@end
