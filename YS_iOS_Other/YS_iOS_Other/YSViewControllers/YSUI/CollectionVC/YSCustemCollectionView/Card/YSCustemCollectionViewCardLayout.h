//
//  YSCustemCollectionViewCardLayout.h
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const YSCardLayout_SectionHeaderKind;
UIKIT_EXTERN NSString * const YSCardLayout_SectionFooterKind;

@protocol YSCustemCollectionViewCardLayoutDelegate;

@interface YSCustemCollectionViewCardLayout : UICollectionViewLayout

@property (nonatomic, strong)  NSMutableArray * ysSectionHeadHeightArr;
@property (nonatomic, strong)  NSMutableArray * ysSectionFootHeightArr;

@property (nonatomic, assign) UIEdgeInsets ysSectionEdgeInsets;
@property (nonatomic, assign)  CGFloat ysItemSpace;     // item 间间隙
@property (nonatomic, assign)  CGFloat ysItemScale;     // 缩放比例，仅当只有一个完整的 item 在屏幕可见区域时才有效

@property (nonatomic, assign)  CGSize ysItemSize;       // item size

@property (nonatomic, weak) id<YSCustemCollectionViewCardLayoutDelegate> delegate;


@end

@protocol YSCustemCollectionViewCardLayoutDelegate <NSObject>

// item size
- (CGSize)ysCollectionView:(UICollectionView *)collectionView
                    layout:(YSCustemCollectionViewCardLayout *)layout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

// section header height
- (CGFloat)ysCollectionView:(UICollectionView *)collectionView
                    layout:(YSCustemCollectionViewCardLayout *)layout
  heightForHeaderInSection:(NSInteger)section;

// section footer height
- (CGFloat)ysCollectionView:(UICollectionView *)collectionView
                    layout:(YSCustemCollectionViewCardLayout *)layout
  heightForFooterInSection:(NSInteger)section;

// section edge insets
- (UIEdgeInsets)ysCollectionView:(UICollectionView *)collectionView
                          layout:(YSCustemCollectionViewCardLayout *)layout
             edgeInsetsInSection:(NSInteger)section;

@end

