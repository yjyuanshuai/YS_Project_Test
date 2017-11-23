//
//  YSCustemCollectionViewCardLayout.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionViewCardLayout.h"

NSString * const YSCardLayout_SectionHeaderKind = @"YSCardLayout_SectionHeaderKind";
NSString * const YSCardLayout_SectionFooterKind = @"YSCardLayout_SectionFooterKind";

@interface YSCustemCollectionViewCardLayout()

@property (nonatomic, strong) NSMutableDictionary * sectionHeadAttrsDic;
@property (nonatomic, strong) NSMutableDictionary * sectiomFootAttrsDic;
@property (nonatomic, strong) NSMutableDictionary * itemAttrsDic;

// 记录每段的 maxY
@property (nonatomic, strong) NSMutableDictionary * sectionMaxYDic;
// 记录每段的 maxX
@property (nonatomic, strong) NSMutableDictionary * sectionMaxXDic;

@end

@implementation YSCustemCollectionViewCardLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ysSectionHeadHeightArr = [NSMutableArray array];
        self.ysSectionFootHeightArr = [NSMutableArray array];
        self.ysSectionEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.ysItemSpace = 10;
        self.ysItemScale = 0;
        self.ysItemSize = CGSizeZero;
        
        self.sectionHeadAttrsDic = [NSMutableDictionary dictionary];
        self.sectiomFootAttrsDic = [NSMutableDictionary dictionary];
        self.itemAttrsDic = [NSMutableDictionary dictionary];
        
        self.sectionMaxYDic = [NSMutableDictionary dictionary];
        self.sectionMaxXDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.sectionHeadAttrsDic removeAllObjects];
    [self.sectiomFootAttrsDic removeAllObjects];
    [self.itemAttrsDic removeAllObjects];
    
    NSInteger sectionNum = self.collectionView.numberOfSections;
    for (int i = 0; i < sectionNum; i++) {
        // 段头
        NSIndexPath * sectionHeaderIndexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        CGFloat sectionHeaderHeight = 0;
        if (i <  [self.ysSectionHeadHeightArr count]) {
            sectionHeaderHeight = [self.ysSectionHeadHeightArr[i] floatValue];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(ysCollectionView:layout:heightForHeaderInSection:)]) {
            sectionHeaderHeight = [self.delegate ysCollectionView:self.collectionView layout:self heightForHeaderInSection:i];
        }
        CGFloat sectionMaxY = [self getCurrentSectionMaxY:sectionHeaderIndexPath];
        UICollectionViewLayoutAttributes * sectionHeadAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:YSCardLayout_SectionHeaderKind withIndexPath:sectionHeaderIndexPath];
        sectionHeadAttr.frame = CGRectMake(0, sectionMaxY, kScreenWidth, sectionHeaderHeight);
        [self.sectionHeadAttrsDic setObject:sectionHeadAttr forKey:sectionHeaderIndexPath];
        // 设置 sectionMaxY
        [self.sectionMaxYDic setObject:@(sectionMaxY + sectionHeaderHeight) forKey:sectionHeaderIndexPath] ;
        
        
        
        
        // cell
        UIEdgeInsets sectionEdgeInsets = self.ysSectionEdgeInsets;
        if (self.delegate && [self.delegate respondsToSelector:@selector(ysCollectionView:layout:edgeInsetsInSection:)]) {
            sectionEdgeInsets = [self.delegate ysCollectionView:self.collectionView layout:self edgeInsetsInSection:i];
        }
        CGFloat sectionMaxY2 = [self getCurrentSectionMaxY:sectionHeaderIndexPath];
        
        NSInteger sectionItemNum = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < sectionItemNum; j++) {
            NSIndexPath * itemIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
            CGSize itemSize = self.ysItemSize;
            if (self.delegate && [self.delegate respondsToSelector:@selector(ysCollectionView:layout:sizeForItemAtIndexPath:)]) {
                itemSize = [self.delegate ysCollectionView:self.collectionView layout:self sizeForItemAtIndexPath:itemIndexPath];
            }
            
            UICollectionViewLayoutAttributes * itemAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
            itemAttr.frame = CGRectMake(sectionEdgeInsets.left, sectionMaxY2+sectionEdgeInsets.top, itemSize.width, itemSize.height);
            [self.itemAttrsDic setObject:itemAttr forKey:itemIndexPath];
            
            CGFloat currentItemMaxY = sectionMaxY2 + sectionEdgeInsets.top + itemSize.height;
            
        }
        
        // 段尾
        NSIndexPath * sectionFooterIndexPath = [NSIndexPath indexPathWithIndex:i];
        UICollectionViewLayoutAttributes * sectionFootAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:YSCardLayout_SectionFooterKind withIndexPath:sectionFooterIndexPath];
    }
}

- (CGFloat)getCurrentSectionMaxY:(NSIndexPath *)sectionIndexPath
{
    CGFloat sectionMaxY = [self.sectionMaxYDic objectForKey:sectionIndexPath];
    if (sectionMaxY <= 0) {
        sectionMaxY = 0;
    }
    return sectionMaxY;
}

@end
