//
//  YSButton.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/18.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSButton.h"

@implementation YSButton

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame imagePostion:ImagePostionLeft];
}

- (instancetype)initWithFrame:(CGRect)frame imagePostion:(ImagePostion)postion
{
    if (self = [super initWithFrame:frame]) {
        
        [self initData:postion];
        [self createSubView];
        [self addOrUpdateConstraintForSubViewWithEdge:_marginEdge space:_space];
        
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

#pragma mark - set
- (void)setSpace:(NSInteger)space
{
    if (_imagePostion == ImagePostionTop ||
        _imagePostion == ImagePostionLeft ||
        _imagePostion == ImagePostionBottem ||
        _imagePostion == ImagePostionRight) {
        
        _space = space;
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
}

- (void)setMarginEdge:(UIEdgeInsets)marginEdge
{
    _marginEdge = marginEdge;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setYsBtnTintColor:(UIColor *)ysBtnTintColor
{
    _ysBtnTintColor = ysBtnTintColor;
    self.backgroundColor = _ysBtnTintColor;
}

- (void)setYsTintColor:(UIColor *)ysTintColor
{
    _ysTintColor = ysTintColor;
    _btnTitle.textColor = ysTintColor;
}

- (void)setTintColor:(UIColor *)tintColor
{
    _ysTintColor = tintColor;
    _btnTitle.textColor = tintColor;
}

- (void)setImagePostion:(ImagePostion)postion
{
    _imagePostion = postion;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setConstraintsArr:(NSMutableArray *)constraintsArr
{
    if (constraintsArr == nil || [constraintsArr count] == 0) {
        // 废弃所有约束
        [self removeSelfAllContraints];
    }
}

#pragma mark - private
- (void)initData:(ImagePostion)postion
{
    _imagePostion = postion;
    _marginEdge = UIEdgeInsetsMake(5, 5, 5, 5);
    _space = 5;
    _constraintsArr = [NSMutableArray array];
    
    _ysBtnTintColor = [UIColor clearColor];
    self.backgroundColor = _ysBtnTintColor;
    
    _ysTintColor = [UIColor blackColor];
    _btnTitle.textColor = _ysTintColor;
}

- (void)createSubView
{
    _btnTitle = [UILabel new];
    _btnTitle.adjustsFontSizeToFitWidth = YES;
    _btnTitle.numberOfLines = 0;
    _btnTitle.font = [UIFont systemFontOfSize:16];
    _btnTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_btnTitle];
    
    _btnImageView = [UIImageView new];
    _btnImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_btnImageView];
}

- (void)addOrUpdateConstraintForSubViewWithEdge:(UIEdgeInsets)insert space:(NSInteger)ySpace
{
    NSDictionary * metricDic = @{@"marginLeft":@(insert.left),
                                 @"marginRight":@(insert.right),
                                 @"marginTop":@(insert.top),
                                 @"marginBottem":@(insert.bottom),
                                 @"space":@(ySpace)};
    
    NSDictionary * viewsDic= @{@"_btnTitle":_btnTitle,
                               @"_btnImageView":_btnImageView};
    
    [self removeSelfAllContraints];
    
    if (_imagePostion == ImagePostionTop ||
        _imagePostion == ImagePostionRight ||
        _imagePostion == ImagePostionBottem ||
        _imagePostion == ImagePostionLeft) {
        
        NSString * t_h_vfl_1 = @"";
        NSString * i_h_vfl_1 = @"";
        NSString * t_v_vfl_2 = @"";
        
        switch (_imagePostion) {
            case ImagePostionTop:
            {
                t_h_vfl_1 = @"H:|-marginLeft-[_btnImageView]-marginRight-|";
                i_h_vfl_1 = @"H:|-marginLeft-[_btnTitle]-marginRight-|";
                t_v_vfl_2 = @"V:|-marginTop-[_btnImageView]-space-[_btnTitle]-marginBottem-|";
            }
                break;
            case ImagePostionRight:
            {
                t_h_vfl_1 = @"V:|-marginTop-[_btnImageView]-marginBottem-|";
                i_h_vfl_1 = @"V:|-marginTop-[_btnTitle]-marginBottem-|";
                t_v_vfl_2 = @"H:|-marginLeft-[_btnTitle]-space-[_btnImageView]-marginRight-|";
            }
                break;
            case ImagePostionBottem:
            {
                t_h_vfl_1 = @"H:|-marginLeft-[_btnTitle]-marginRight-|";
                i_h_vfl_1 = @"H:|-marginLeft-[_btnImageView]-marginRight-|";
                t_v_vfl_2 = @"V:|-marginTop-[_btnTitle]-space-[_btnImageView]-marginBottem-|";
            }
                break;
            case ImagePostionLeft:
            {
                t_h_vfl_1 = @"V:|-marginTop-[_btnImageView]-marginBottem-|";
                i_h_vfl_1 = @"V:|-marginTop-[_btnTitle]-marginBottem-|";
                t_v_vfl_2 = @"H:|-marginLeft-[_btnImageView]-space-[_btnTitle]-marginRight-|";
            }
                break;
        }
        
        NSArray * c_1 = [NSLayoutConstraint constraintsWithVisualFormat:t_h_vfl_1
                                                                options:0
                                                                metrics:metricDic
                                                                  views:viewsDic];
        
        NSArray * c_2 = [NSLayoutConstraint constraintsWithVisualFormat:i_h_vfl_1
                                                                options:0
                                                                metrics:metricDic
                                                                  views:viewsDic];
        
        NSArray * c_3 = [NSLayoutConstraint constraintsWithVisualFormat:t_v_vfl_2
                                                                options:0
                                                                metrics:metricDic
                                                                  views:viewsDic];
        [self addConstraints:c_1];
        [self addConstraints:c_2];
        [self addConstraints:c_3];
        
        [_constraintsArr addObjectsFromArray:@[c_1, c_2, c_3]];
        
    }
    else if (_imagePostion == ImagePostionDown) {
        
        [self bringSubviewToFront:_btnTitle];
    
        NSString * t_vfl_1 = @"H:|-marginLeft-[_btnTitle]-marginRight-|";
        NSString * t_vfl_2 = @"V:|-marginTop-[_btnTitle]-marginBottem-|";
        NSString * i_vfl_1 = @"H:|-0-[_btnImageView]-0-|";
        NSString * i_vfl_2 = @"V:|-0-[_btnImageView]-0-|";
        
        if (insert.left == 0 && insert.right != 0) {
            t_vfl_1 = @"H:[_btnTitle]-marginRight-|";
        }
        else if (insert.left != 0 && insert.right == 0) {
            t_vfl_1 = @"H:|-marginLeft-[_btnTitle]";
        }
        
        NSArray * c_1 = [NSLayoutConstraint constraintsWithVisualFormat:i_vfl_1
                                                                options:0
                                                                metrics:metricDic
                                                                  views:viewsDic];
        
        NSArray * c_2 = [NSLayoutConstraint constraintsWithVisualFormat:i_vfl_2
                                                                options:0
                                                                metrics:metricDic
                                                                  views:viewsDic];
        
        NSArray * c_3 = [NSLayoutConstraint constraintsWithVisualFormat:t_vfl_1
                                                                options:0
                                                                metrics:metricDic
                                                                  views:viewsDic];
        
        NSArray * c_4 = [NSLayoutConstraint constraintsWithVisualFormat:t_vfl_2
                                                                options:0
                                                                metrics:metricDic
                                                                  views:viewsDic];
        
        [self addConstraints:c_1];
        [self addConstraints:c_2];
        [self addConstraints:c_3];
        [self addConstraints:c_4];
        
        [_constraintsArr addObjectsFromArray:@[c_1, c_2, c_3, c_4]];
    }
}

- (void)removeSelfAllContraints
{
    if (_constraintsArr && [_constraintsArr count] > 0) {
        for (NSArray * arr in _constraintsArr) {
            [self removeConstraints:arr];
        }
        [_constraintsArr removeAllObjects];
    }
}

- (void)updateConstraints
{
    [self addOrUpdateConstraintForSubViewWithEdge:_marginEdge space:_space];
    [super updateConstraints];
}

@end
