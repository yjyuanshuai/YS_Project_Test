//
//  ChatBottemView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ChatBottemView.h"
#import "NSString+YSStringDo.h"
#import "YSImageAndTextSort.h"

static CGFloat const ConstHeight = 45;
static CGFloat const TextViewMinHeight = 40;
static CGFloat const TextViewMaxHeight = 100;

@implementation ChatBottemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
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
    self.chatTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, TextViewMinHeight)];
    self.chatTextView.delegate = self;
    self.chatTextView.contentInset = UIEdgeInsetsMake(3, 3, 3, 3);
    self.chatTextView.font = YSFont_Sys(16);
    self.chatTextView.showsHorizontalScrollIndicator = NO;
    self.chatTextView.alwaysBounceHorizontal = NO;
    self.chatTextView.bounces = NO;
    self.chatTextView.clipsToBounds = YES;
    self.chatTextView.layer.cornerRadius = 3;
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
    NSString * currentText = _chatTextView.text;
    
    CGFloat currentHeight = [currentText calculateHeightWithMaxWidth:_chatTextView.frame.size.width font:_chatTextView.font miniHeight:TextViewMinHeight];
    if (currentHeight > TextViewMaxHeight) {
        currentHeight = TextViewMaxHeight;
    }
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.frame = CGRectMake(0, _currentFrame.origin.y - (currentHeight - TextViewMinHeight), _currentFrame.size.width, currentHeight + ConstHeight);
        weakSelf.chatTextView.frame = CGRectMake(5, 5, kScreenWidth - 10, currentHeight);
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
//    NSAttributedString * imageAttrStr = [YSImageAndTextSort textAttach:text attributDic:@{NSFontAttributeName:} emoArr:[EmotionFileAnalysis sharedEmotionFile].emoArr originY:-8];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self updateUI];
}

@end
