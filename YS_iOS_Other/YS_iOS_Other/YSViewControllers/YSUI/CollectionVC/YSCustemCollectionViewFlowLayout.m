//
//  YSCustemCollectionViewFlowLayout.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/2.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionViewFlowLayout.h"

@interface YSCustemCollectionViewFlowLayout()

@property (nonatomic, strong) NSMutableDictionary * itemsMaxYDic;
@property (nonatomic, strong) NSMutableArray * attrsArr;

@end

@implementation YSCustemCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark -
- (void)prepareLayout
{

}

- (CGSize)collectionViewContentSize
{

    return CGSizeZero;
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * itemAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    return itemAttr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * supplementAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];

    return supplementAttr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * decorationAttr = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];

    return decorationAttr;
}

@end
