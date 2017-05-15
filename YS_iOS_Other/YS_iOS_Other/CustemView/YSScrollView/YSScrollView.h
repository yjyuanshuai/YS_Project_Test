//
//  YSScrollView.h
//  YS_iOS_Other
//
//  Created by YJ on 16/7/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSScrollView : UIView

@property (nonatomic, strong) UIScrollView * ysScrollView;
@property (nonatomic, strong) UIPageControl * ysPageControl;

// 循环轮播
@property (nonatomic, assign, getter=isCircle) BOOL circle;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSTimeInterval circleTimer;

@property (nonatomic, strong) NSArray * imagesArr;

// pageControl
@property (nonatomic, assign, getter=isImage) BOOL pageConImage;
@property (nonatomic, strong) UIImage * selectedTintImage;
@property (nonatomic, strong) UIImage * tintImage;
@property (nonatomic, strong) UIColor * ysSelectedColor;
@property (nonatomic, strong) UIColor * ysTintColor;

// scrollView
@property (nonatomic, assign) CGSize ysContentSize;
@property (nonatomic, assign) CGPoint ysContentOffSet;

- (instancetype)initWithFrame:(CGRect)frame;

@end
