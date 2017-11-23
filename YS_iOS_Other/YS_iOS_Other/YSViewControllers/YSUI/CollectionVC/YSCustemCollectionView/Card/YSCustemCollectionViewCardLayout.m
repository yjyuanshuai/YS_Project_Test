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

@property (nonatomic, strong) UICollectionViewLayoutAttributes * sectionHeaderAttr;
@property (nonatomic, strong) UICollectionViewLayoutAttributes * sectionFooterAttr;
@property (nonatomic, strong) NSMutableDictionary * itemAttrsDic;

// 当前 maxX
@property (nonatomic, assign) CGFloat currentMaxX;
@property (nonatomic, assign) CGFloat currentMaxY;

@end

@implementation YSCustemCollectionViewCardLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ysSectionHeaderHeight = 0;
        self.ysSectionFooterHeight = 0;
        self.ysSectionEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.ysItemSpace = 10;
        self.ysItemScale = 0;
        self.ysItemSize = CGSizeZero;
        
        self.itemAttrsDic = [NSMutableDictionary dictionary];
        
        self.currentMaxX = 0;
        self.currentMaxY = 0;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.itemAttrsDic removeAllObjects];
    
    NSInteger section = 0;
    
    // 段头
    NSIndexPath * sectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    if (self.delegate && [self.delegate respondsToSelector:@selector(ysCollectionView:layout:heightForHeaderInSection:)]) {
        CGFloat sectionHeaderHeight = [self.delegate ysCollectionView:self.collectionView layout:self heightForHeaderInSection:section];
        if (sectionHeaderHeight != self.ysSectionHeaderHeight) {
            self.ysSectionHeaderHeight = sectionHeaderHeight;
        }
    }
    UICollectionViewLayoutAttributes * sectionHeadAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:YSCardLayout_SectionHeaderKind withIndexPath:sectionIndexPath];
    sectionHeadAttr.frame = CGRectMake(0, 0, kScreenWidth, self.ysSectionHeaderHeight);
    self.sectionHeaderAttr = sectionHeadAttr;
    
    
    
    
    // cell
    if (self.delegate && [self.delegate respondsToSelector:@selector(ysCollectionView:layout:edgeInsetsInSection:)]) {
        UIEdgeInsets sectionEdgeInsets = [self.delegate ysCollectionView:self.collectionView layout:self edgeInsetsInSection:section];
        self.ysSectionEdgeInsets = UIEdgeInsetsMake(sectionEdgeInsets.top, sectionEdgeInsets.left, sectionEdgeInsets.bottom, sectionEdgeInsets.right);
    }
    self.currentMaxX = self.ysSectionEdgeInsets.left;
    
    NSInteger sectionItemNum = [self.collectionView numberOfItemsInSection:section];
    for (int j = 0; j < sectionItemNum; j++) {
        NSIndexPath * itemIndexPath = [NSIndexPath indexPathForRow:j inSection:section];
        CGSize itemSize = self.ysItemSize;
        if (self.delegate && [self.delegate respondsToSelector:@selector(ysCollectionView:layout:sizeForItemAtIndexPath:)]) {
            itemSize = [self.delegate ysCollectionView:self.collectionView layout:self sizeForItemAtIndexPath:itemIndexPath];
        }
        UICollectionViewLayoutAttributes * itemAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        itemAttr.frame = CGRectMake(self.currentMaxY, self.ysSectionHeaderHeight+self.ysSectionEdgeInsets.top, itemSize.width, itemSize.height);
        [self.itemAttrsDic setObject:itemAttr forKey:itemIndexPath];
        
        if (j == sectionItemNum-1) {
            self.currentMaxX += (itemSize.width + self.ysSectionEdgeInsets.right);
        }
        else {
            self.currentMaxX += (itemSize.width + self.ysItemSpace);
        }
        
        CGFloat itemMaxY = self.ysSectionHeaderHeight + self.ysSectionEdgeInsets.top + itemSize.height;
        if (self.currentMaxY < itemMaxY) {
            self.currentMaxY = itemMaxY;
        }
    }
    
    // 段尾
    if (self.delegate && [self.delegate respondsToSelector:@selector(ysCollectionView:layout:heightForFooterInSection:)]) {
        self.ysSectionFooterHeight = [self.delegate ysCollectionView:self.collectionView layout:self heightForFooterInSection:section];
    }
    UICollectionViewLayoutAttributes * sectionFootAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:YSCardLayout_SectionFooterKind withIndexPath:sectionIndexPath];
    sectionHeadAttr.frame = CGRectMake(0, self.currentMaxY+self.ysSectionEdgeInsets.bottom, kScreenWidth, self.ysSectionFooterHeight);
    self.sectionFooterAttr = sectionFootAttr;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.currentMaxX, self.collectionView.frame.size.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * arr = [NSMutableArray array];
    // 头
    if (CGRectIntersectsRect(rect, self.sectionHeaderAttr.frame)) {
        [arr addObject:self.sectionHeaderAttr];
    }
    
    // cell
    [self.itemAttrsDic enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * key, UICollectionViewLayoutAttributes * obj, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(rect, obj.frame)) {
            [arr addObject:obj];
        }
    }];
    
    // 尾
    if (CGRectIntersectsRect(rect, self.sectionFooterAttr.frame)) {
        [arr addObject:self.sectionFooterAttr];
    }
    return arr;
}

//是否重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
}

#pragma mark - private


@end
