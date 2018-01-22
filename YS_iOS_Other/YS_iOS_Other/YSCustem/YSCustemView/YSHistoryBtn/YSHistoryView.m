//
//  YSHistoryView.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSHistoryView.h"
#import "NSString+YSStringDo.h"


static CGFloat paddingX = 10;
static CGFloat paddingY = 10;
static CGFloat HistoryBtnHeight = 30;

@interface YSHistoryView() <YSHistoryBtnDelegate>

@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSMutableArray * historyBtnArr;

@end

@implementation YSHistoryView

+ (instancetype)historyViewShowWithFrame:(CGRect)frame stringArr:(NSArray *)stringArr
{
    YSHistoryView * historyView = [[YSHistoryView alloc] initWithFrame:frame];
    historyView.stringArr = stringArr;
    return historyView;
}

+ (void)historyViewHide
{

}

+ (void)historyViewShow
{

}

+ (void)historyViewUpdate
{
    
}

#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initData];
        [self initUI:frame];
    }
    return self;
}

- (void)initUI:(CGRect)frame
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
    [self addSubview:_headerView];
    
    _headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 100, 44)];
    _headerTitleLabel.text = @"历史记录";
    _headerTitleLabel.textColor = [UIColor blackColor];
    _headerTitleLabel.font = [UIFont systemFontOfSize:16.0];
    [_headerView addSubview:_headerTitleLabel];
    
    _headerEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerEditBtn.frame = CGRectMake(frame.size.width - 10 - 30 - 20, 0, 44, 44);
    [_headerEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_headerEditBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_headerEditBtn addTarget:self action:@selector(clickToEdit:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_headerEditBtn];
    
    _headerDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerDeleteBtn.frame = CGRectMake(frame.size.width - 10 - 44, 0, 30, 30);
    [_headerDeleteBtn setBackgroundImage:[UIImage imageNamed:@"editBtn"] forState:UIControlStateNormal];
    [_headerDeleteBtn addTarget:self action:@selector(clickToDelete:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_headerDeleteBtn];
}

- (void)initData
{
    _isShowDelete = NO;
    _stringArr = [NSArray array];
    _historyBtnArr = [NSMutableArray array];
}

#pragma mark - hide / show / update
- (void)showHistoryView
{
    for (int i = 0; i < [_stringArr count]; i++) {

        if (i == 0)
        {
            NSString * str = [_stringArr objectAtIndex:i];
            CGFloat btnWidth = [str calculateWidthWithMaxHeight:44 font:[UIFont systemFontOfSize:16.0] miniWidth:0];
            CGRect frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), btnWidth, HistoryBtnHeight);
            YSHistoryBtn * historyBtn = [[YSHistoryBtn alloc] initWithFrame:frame];
            historyBtn.historyStr = str;
            historyBtn.delegate = self;
            [_historyBtnArr addObject:historyBtn];
        }
        else
        {
            YSHistoryBtn * frontHistoryBtn = [_historyBtnArr objectAtIndex:i-1];
            CGRect frontBtnFrame = frontHistoryBtn.frame;
            
            NSString * str = [_stringArr objectAtIndex:i];
            CGFloat btnWidth = [str calculateWidthWithMaxHeight:HistoryBtnHeight font:[UIFont systemFontOfSize:16.0] miniWidth:0];
            
            CGRect frame = CGRectZero;
            if (frontBtnFrame.origin.x + frontBtnFrame.size.width + paddingX + btnWidth > kScreenWidth)
            {
                frame = CGRectMake(0, frontBtnFrame.origin.y + HistoryBtnHeight + paddingY, btnWidth, HistoryBtnHeight);
            }
            else
            {
                frame = CGRectMake(frontBtnFrame.origin.x + frontBtnFrame.size.width + paddingX, frontBtnFrame.origin.y, btnWidth, HistoryBtnHeight);
            }

            YSHistoryBtn * historyBtn = [[YSHistoryBtn alloc] initWithFrame:frame];
            historyBtn.historyStr = str;
            historyBtn.delegate = self;
            [_historyBtnArr addObject:historyBtn];
        }
    }
}

- (void)updateHistoryViewWithEdit:(BOOL)canEdit
{
    
}

- (void)hideHistoryView
{

}

#pragma mark - edit
- (void)clickToEdit:(UIButton *)btn
{
    _isShowDelete = !_isShowDelete;
    
}

- (void)clickToDelete:(UIButton *)btn
{

}

#pragma mark - YSHistoryBtnDeleggate
- (void)deleteThisHistory:(YSHistoryBtn *)btn
{
    
}

- (void)clickThisHistoryBtn:(YSHistoryBtn *)btn
{

}

@end


#pragma mark - YSHistoryBtn -
@interface YSHistoryBtn()

@property (nonatomic, strong) UIButton * historyBtn;
@property (nonatomic, strong) UIButton * deleteBtn;

@end

@implementation YSHistoryBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initData];
        [self createUI:frame];
    }
    return self;
}

- (void)createUI:(CGRect)frame
{
    _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _historyBtn.frame = CGRectMake(0, 10, frame.size.width, frame.size.height - 20);
    _historyBtn.layer.borderWidth = _borderWidth;
    _historyBtn.layer.borderColor = _borderColor.CGColor;
    _historyBtn.layer.cornerRadius = _corderRadus;
    _historyBtn.backgroundColor = _btnTintColor;
    [_historyBtn addTarget:self action:@selector(clickToHistoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_historyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_historyBtn];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.hidden = YES;
    _deleteBtn.frame = CGRectMake(frame.size.width - 30, 0, 20, 20);
    [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"deleteBtnImage"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(clickToDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteBtn];
    
    [self bringSubviewToFront:_deleteBtn];
}

- (void)initData
{
    _isDelete = NO;
    _btnTintColor = [UIColor clearColor];
    _borderColor = [UIColor clearColor];
    _borderWidth = 0.0;
    _corderRadus = 0.0;
}

- (void)setIsDelete:(BOOL)isDelete
{
    if (isDelete != _isDelete) {
        _isDelete = isDelete;
        _historyBtn.hidden = !_isDelete;
    }
}

- (void)setBtnTintColor:(UIColor *)btnTintColor
{
    if (![btnTintColor isEqual:_btnTintColor]) {
        _btnTintColor = btnTintColor;
        _historyBtn.backgroundColor = _btnTintColor;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (![borderColor isEqual:_borderColor]) {
        borderColor = _borderColor;
        _historyBtn.layer.borderColor = _borderColor.CGColor;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (borderWidth != _borderWidth) {
        _borderWidth = borderWidth;
        _historyBtn.layer.borderWidth = _borderWidth;
    }
}

- (void)setCorderRadus:(CGFloat)corderRadus
{
    if (corderRadus != _corderRadus) {
        _corderRadus = corderRadus;
        _historyBtn.layer.cornerRadius = _corderRadus;
    }
}

- (void)setHistoryStr:(NSString *)historyStr
{
    if (![historyStr isBlank]) {
        [_historyBtn setTitle:historyStr forState:UIControlStateNormal];
    }
}

- (void)clickToHistoryBtn:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickThisHistoryBtn:)]) {
        [_delegate clickThisHistoryBtn:self];
    }
}

- (void)clickToDeleteBtn:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(deleteThisHistory:)]) {
        [_delegate deleteThisHistory:self];
    }
}

@end

