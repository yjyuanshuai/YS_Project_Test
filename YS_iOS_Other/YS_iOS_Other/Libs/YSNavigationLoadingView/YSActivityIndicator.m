//
//  YSActivityIndicator.m
//  加载动画Test
//
//  Created by YJ on 16/4/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSActivityIndicator.h"
#import "YSHudView.h"

@implementation YSActivityIndicator
{
    UILabel * _titleLabel;
    UILabel * _descLabel;
    NSTimer * _loadingTimer;
}

#pragma mark - class method -

+ (instancetype)showInViewController:(UIViewController *)viewController
{
    YSActivityIndicator * loadingView = [[YSActivityIndicator alloc] init];
    loadingView.blongToViewController = viewController;
    [loadingView initTimer];
    viewController.navigationItem.titleView = loadingView;
    return loadingView;
}

+ (void)hideInViewController:(UIViewController *)viewController
{
    [YSActivityIndicator hideInViewController:viewController
                                  msgHUDTitle:nil
                                  finishBlock:nil];
}

+ (void)hideInViewController:(UIViewController *)viewController
                 finishBlock:(void (^)(void))block
{
    [YSActivityIndicator hideInViewController:viewController
                                  msgHUDTitle:nil
                                  finishBlock:block];
}

+ (void)hideInViewController:(UIViewController *)viewController
                 msgHUDTitle:(NSString *)msg
{
    [YSActivityIndicator hideInViewController:viewController
                                  msgHUDTitle:msg
                                  finishBlock:nil];
}

+ (void)hideInViewController:(UIViewController *)viewController
                 msgHUDTitle:(NSString *)msg
                 finishBlock:(void (^)(void))block
{
    UIView * viewTitle = viewController.navigationItem.titleView;
    if (viewTitle != nil && [viewTitle isKindOfClass:[YSActivityIndicator class]]) {
        
        YSActivityIndicator * indicator = (YSActivityIndicator *)viewTitle;
        
        [indicator invalidTimer];
        [indicator setBlongViewNil];
        
        if (!([msg isEqualToString:@""] || [msg isEqual:NULL] || msg == nil)) {
            indicator.msgText = msg;
            [indicator showHUD:msg];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            viewController.navigationItem.titleView = nil;
            
            if (block) {
                block();
            }
            
        });
    }
}

#pragma mark - init/dealloc
- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, 200, 44)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.ysType = YSLoadViewTypeSystemActIndicatorDetail;
        self.ysActivityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.titleFont = [UIFont boldSystemFontOfSize:18.0];
        self.titleTextColor = [UIColor blackColor];
        self.titleStr = @"加载中...";
        self.descFont = [UIFont systemFontOfSize:14];
        self.descTextColor = [UIColor blackColor];
        self.descStr = @"数据正在加载，请稍后";
        self.overTimeInterval = 30;
        self.msgText = @"";
        
        [self createLabels];
        [self createSystemActivityIndicator];
        [self updateLoadingView];
        [self registerKVO];
    }
    return self;
}

- (void)dealloc
{
    [self unregisterKVO];
}

#pragma mark - private method
- (void)createLabels
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textAlignment   = NSTextAlignmentCenter;
    _titleLabel.font            = _titleFont;
    _titleLabel.textColor       = _titleTextColor;
    _titleLabel.text            = _titleStr;
    _titleLabel.lineBreakMode   = NSLineBreakByTruncatingMiddle;
    [self addSubview:_titleLabel];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _descLabel.textAlignment    = NSTextAlignmentCenter;
    _descLabel.font             = _descFont;
    _descLabel.textColor        = _descTextColor;
    _descLabel.text             = _descStr;
    _descLabel.lineBreakMode   = NSLineBreakByTruncatingMiddle;
    [self addSubview:_descLabel];
}

- (void)createSystemActivityIndicator
{
    _ysAcitityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    [_ysAcitityIndicator setActivityIndicatorViewStyle:_ysActivityIndicatorStyle];
    [self addSubview:_ysAcitityIndicator];
}

- (void)showHUD:(NSString *)msg
{
    /*
    if (!([msg isEqualToString:@""] || [msg isEqual:NULL] || msg == nil)) {
        _msgHud                  = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        _msgHud.mode             = MBProgressHUDModeText;
        _msgHud.detailsLabel.text = msg;
        
        if (msg.length > 12) {
            _msgHud.detailsLabel.font = SYS_FONT(14);
        } else {
            _msgHud.detailsLabel.font = SYS_FONT(16);
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_msgHud hideAnimated:YES];
            [_msgHud removeFromSuperview];
        });
        
    } else {
        [_msgHud hideAnimated:YES];
        [_msgHud removeFromSuperview];
    }
     */
    
    [YSHudView yiBaoHUDStopOrShowWithMsg:msg finsh:nil];
}

- (void)initTimer
{
    [self invalidTimer];
    
    _loadingTimer = [NSTimer scheduledTimerWithTimeInterval:_overTimeInterval
                                                     target:self
                                                   selector:@selector(overTime)
                                                   userInfo:nil
                                                    repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_loadingTimer forMode:NSRunLoopCommonModes];
}

- (void)invalidTimer
{
    if (_loadingTimer != nil) {
        [_loadingTimer invalidate];
        _loadingTimer = nil;
    }
}

#pragma mark - 超时
- (void)overTime
{
    [YSActivityIndicator hideInViewController:_blongToViewController msgHUDTitle:@"操作超时，请重试!"];
}

#pragma mark - 置空
- (void)setBlongViewNil
{
    _blongToViewController = nil;
}

#pragma mark - layout
- (void)layoutSubviews
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.autoresizesSubviews = YES;
    
    CGFloat maxWidth    = self.frame.size.width;
    CGFloat maxHeight   = self.frame.size.height;
    
    if (_ysType == YSLoadViewTypeSystemActIndicatorDefault) {
        
        CGSize titleSize = [_titleStr sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        CGFloat titleHeight = MIN(titleSize.height, 30);
        CGFloat titleWidth = MIN(titleSize.width, maxWidth-35);
        CGFloat space_left = (maxWidth - 30 - 5 - titleWidth)/2;
        _ysAcitityIndicator.frame = CGRectMake(space_left, (maxHeight - 30)/2, 30, 30);
        _titleLabel.frame = CGRectMake(space_left+30+5, (maxHeight - titleHeight)/2, titleWidth, titleHeight);
        
    } else if (_ysType == YSLoadViewTypeSystemActIndicatorDetail) {
        
        CGSize titleSize    = [_titleStr sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        CGSize descSize     = [_descStr sizeWithAttributes:@{NSFontAttributeName:_descFont}];
        
        CGFloat titleHeight = MIN(titleSize.height, 30);
        CGFloat descHeight  = MIN(descSize.height, maxHeight - titleHeight);
        
        CGFloat labelWidth  = MAX(titleSize.width, descSize.width);
        labelWidth = MIN(labelWidth, maxWidth-35);
        
        CGFloat space_left = (maxWidth - 30 - 5 - labelWidth)/2;
        
        _ysAcitityIndicator.frame = CGRectMake(space_left, (maxHeight - 30)/2, 30, 30);
        _titleLabel.frame = CGRectMake(space_left+30+5, (maxHeight - titleHeight - descHeight)/2, labelWidth, titleHeight);
        _descLabel.frame = CGRectMake(space_left+30+5, CGRectGetMaxY(_titleLabel.frame), labelWidth, descHeight);
        
    } else if (_ysType == YSLoadViewTypeTextDefault) {
        
        CGSize titleSize = [_titleStr sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        
        CGFloat titleHeight = MIN(titleSize.height, 30);
        _titleLabel.frame = CGRectMake(0, (maxHeight - titleHeight)/2, maxWidth, titleHeight);
    
    } else if (_ysType == YSLoadViewTypeTextDetail) {
        
        CGSize titleSize    = [_titleStr sizeWithAttributes:@{NSFontAttributeName:_titleFont}];
        CGSize descSize     = [_descStr sizeWithAttributes:@{NSFontAttributeName:_descFont}];
        
        CGFloat titleHeight = MIN(titleSize.height, 30);
        CGFloat descHeight  = MIN(descSize.height, maxHeight - titleHeight);
        
        _titleLabel.frame = CGRectMake(0, (maxHeight - titleHeight - descHeight)/2, maxWidth, titleHeight);
        
        _descLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), maxWidth, descHeight);
        
    } else if (_ysType == YSLoadViewTypeCustom) {
        
        //自定义的
        
    }
}

#pragma mark - KVO

- (NSArray *)propertyArr
{
    NSArray * propertyArr = @[@"ysActivityIndicatorStyle", @"ysType", @"titleStr", @"titleFont", @"titleTextColor",  @"descStr", @"descFont", @"descTextColor", @"ysCustomView", @"msgText"];
    return propertyArr;
}

- (void)registerKVO
{
    NSArray * propertyArr = [self propertyArr];
    
    for (NSString * propertyStr in propertyArr) {
        [self addObserver:self
               forKeyPath:propertyStr
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
}

- (void)unregisterKVO
{
    NSArray * propertyArr = [self propertyArr];
    
    for (NSString * propertyStr in propertyArr) {
        [self removeObserver:self forKeyPath:propertyStr];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIWithKeyPath:) withObject:keyPath waitUntilDone:NO];
    }else {
        [self updateUIWithKeyPath:keyPath];
    }
}

- (void)updateUIWithKeyPath:(NSString *)keyPath
{
    if ([keyPath isEqualToString:@"ysType"] || [keyPath isEqualToString:@"ysCustomView"]) {
        
        [self updateLoadingView];
        
    } else if ([keyPath isEqualToString:@"titleStr"]) {
        
        _titleLabel.text = self.titleStr;
    
    } else if ([keyPath isEqualToString:@"titleFont"]) {
        
        _titleLabel.font = self.titleFont;
    
    } else if ([keyPath isEqualToString:@"titleTextColor"]) {
        
        _titleLabel.textColor = self.titleTextColor;
    
    } else if ([keyPath isEqualToString:@"descStr"]) {
        
        _descLabel.text = self.descStr;
        
    } else if ([keyPath isEqualToString:@"descFont"]) {
        
        _descLabel.font = self.descFont;
        
    } else if ([keyPath isEqualToString:@"descTextColor"]) {
        
        _descLabel.textColor = self.descTextColor;
        
    } else if ([keyPath isEqualToString:@"ysActivityIndicatorStyle"]) {
        
        if (_ysAcitityIndicator != nil) {
            
            [_ysAcitityIndicator setActivityIndicatorViewStyle:self.ysActivityIndicatorStyle];
            
        }
    }
    
    [self setNeedsLayout];
}

- (void)updateLoadingView
{
    if (_ysType == YSLoadViewTypeSystemActIndicatorDefault) {
        
        if (!_ysAcitityIndicator.isAnimating) {
            [_ysAcitityIndicator startAnimating];
        }
        
        [_descLabel removeFromSuperview];
        
    } else if (_ysType == YSLoadViewTypeSystemActIndicatorDetail) {
        
        if (!_ysAcitityIndicator.isAnimating) {
            [_ysAcitityIndicator startAnimating];
        }
    
    } else if (_ysType == YSLoadViewTypeCustom) {
        
        [_ysAcitityIndicator removeFromSuperview];
        [_descLabel removeFromSuperview];
        [_titleLabel removeFromSuperview];
        
    } else if (_ysType == YSLoadViewTypeTextDefault) {
    
        [_ysAcitityIndicator removeFromSuperview];
        [_descLabel removeFromSuperview];
        
    } else if (_ysType == YSLoadViewTypeTextDetail) {
        
        [_ysAcitityIndicator removeFromSuperview];
    
    }
}

@end
