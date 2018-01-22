//
//  YSButton.h
//  YS_iOS_Other
//
//  Created by YJ on 16/8/18.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImagePostion)
{
    ImagePostionTop,    // 图片上 文字下
    ImagePostionLeft,   // 图片左 文字右
    ImagePostionBottem, // 图片下 文字上
    ImagePostionRight,  // 图片右 文字左
    
    ImagePostionDown     // 图片在文字之下
};

@interface YSButton : UIControl

@property (nonatomic, strong) UILabel * btnTitle;
@property (nonatomic, strong) UIImageView * btnImageView;


@property (nonatomic, assign) ImagePostion imagePostion;


@property (nonatomic, strong) UIColor * ysBtnTintColor;
@property (nonatomic, strong) UIColor * ysTintColor;


@property (nonatomic, assign) UIEdgeInsets marginEdge;      // 上下左右的距离
@property (nonatomic, assign) NSInteger space;              // title 和 imageview 距离

@property (nonatomic, strong) NSMutableArray * constraintsArr;


- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame imagePostion:(ImagePostion)postion;

@end
