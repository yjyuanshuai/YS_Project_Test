//
//  YSCustemCollectionViewFlowLayout.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/2.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSCustemCollectionViewFlowLayoutDelegate;

@interface YSCustemCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger ysColumntCount;   // 列数
@property (nonatomic, assign) CGFloat ysSpaceHor;         // item 横向间距
@property (nonatomic, assign) CGFloat ysSpaceVer;         // item 竖向间距
@property (nonatomic, assign) UIEdgeInsets ysSectionInset;// 段边距

@property (nonatomic, weak) id<YSCustemCollectionViewFlowLayoutDelegate> delegate;

@end

@protocol YSCustemCollectionViewFlowLayoutDelegate <NSObject>



@end
