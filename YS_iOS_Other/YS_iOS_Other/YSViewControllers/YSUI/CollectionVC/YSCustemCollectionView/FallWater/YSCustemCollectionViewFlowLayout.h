//
//  YSCustemCollectionViewFlowLayout.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/2.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const YSCustemCollectionView_SectionHeadKind;
UIKIT_EXTERN NSString * const YSCustemCollectionView_SectionFootKind;
UIKIT_EXTERN NSString * const YSCustemCollectionView_SectionDecorationKind;

@protocol YSCustemCollectionViewFlowLayoutDelegate;

@interface YSCustemCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger ysColumntCount;   // 列数
@property (nonatomic, assign) CGFloat ysSpaceHor;         // item 横向间距
@property (nonatomic, assign) CGFloat ysSpaceVer;         // item 竖向间距
@property (nonatomic, assign) UIEdgeInsets ysSectionInset;// 段边距

@property (nonatomic, strong) NSMutableArray * ysSectionHeadHeightArr;
@property (nonatomic, strong) NSMutableArray * ysSectionFootHeightArr;

@property (nonatomic, strong) NSMutableArray * needAnimationIndexPaths;

@property (nonatomic, weak) id<YSCustemCollectionViewFlowLayoutDelegate> delegate;

@end

@protocol YSCustemCollectionViewFlowLayoutDelegate <NSObject>

// item 高度
- (CGFloat)ysCustemCollectionView:(UICollectionView *)collectionView
          itemHeightWithIndexPath:(NSIndexPath *)indexPath
                        itemWidth:(CGFloat)itemWidth;

// 移动时
- (void)ysCustemCollectionView:(UICollectionView *)collectionView
                beginIndexPath:(NSIndexPath *)beginIndexPath
                  endIndexPath:(NSIndexPath *)endIndexPath;

@end
