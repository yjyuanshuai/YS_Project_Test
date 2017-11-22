//
//  YSCustemCollectionViewFlowLayout.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/8/2.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionViewFlowLayout.h"

NSString * const YSCustemCollectionView_SectionHeadKind = @"YSCustemCollectionView_SectionHeadID";
NSString * const YSCustemCollectionView_SectionFootKind = @"YSCustemCollectionView_SectionFootID";
NSString * const YSCustemCollectionView_SectionDecorationKind = @"YSCustemCollectionView_SectionDecorationID";

@interface YSCustemCollectionViewFlowLayout()

//记录瀑布流每列最下面那个cell的底部y值
@property (nonatomic, strong) NSMutableDictionary * itemsMaxYDic;

@property (nonatomic, strong) NSMutableDictionary * itemAttrsDic;
@property (nonatomic, strong) NSMutableDictionary * sectionHeadAttrsDic;
@property (nonatomic, strong) NSMutableDictionary * sectionFootAttrsDic;
@property (nonatomic, strong) NSMutableDictionary * sectionDecorationDic;

@end

@implementation YSCustemCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ysColumntCount = 3;
        self.ysSpaceHor = 10;
        self.ysSpaceVer = 20;
        self.ysSectionInset = UIEdgeInsetsMake(30, 20, 30, 20);

        self.itemsMaxYDic = [NSMutableDictionary dictionary];
        self.itemAttrsDic = [NSMutableDictionary dictionary];
        self.sectionHeadAttrsDic = [NSMutableDictionary dictionary];
        self.sectionFootAttrsDic = [NSMutableDictionary dictionary];
        self.sectionDecorationDic = [NSMutableDictionary dictionary];

        self.ysSectionHeadHeightArr = [NSMutableArray array];
        self.ysSectionFootHeightArr = [NSMutableArray array];

        self.needAnimationIndexPaths = [NSMutableArray array];
    }
    return self;
}

#pragma mark - 自定义布局
//预布局方法 所有的布局应该写在这里面
- (void)prepareLayout
{
    [super prepareLayout];

    [self.itemsMaxYDic removeAllObjects];
    [self.itemAttrsDic removeAllObjects];
    [self.sectionHeadAttrsDic removeAllObjects];
    [self.sectionFootAttrsDic removeAllObjects];
    [self.sectionDecorationDic removeAllObjects];

    // item 宽度
    CGFloat itemWidth = (self.collectionView.frame.size.width - self.ysSectionInset.left - self.ysSectionInset.right - (self.ysColumntCount-1)*self.ysSpaceHor)/self.ysColumntCount;

    NSInteger sectionNum = self.collectionView.numberOfSections;
    for (int i = 0; i < sectionNum; i++) {

        NSIndexPath * currentSectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        // 段头
        CGFloat currentSectionHeadHeight = 0;
        if (i < [self.ysSectionHeadHeightArr count]) {
            currentSectionHeadHeight = [self.ysSectionHeadHeightArr[i] floatValue];
        }
        if (currentSectionHeadHeight > 0 && [self.collectionView.delegate respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {

            UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:YSCustemCollectionView_SectionHeadKind withIndexPath:currentSectionIndexPath];
            attr.frame = CGRectMake(0, [self currentMaxY], kScreenWidth, currentSectionHeadHeight);
            // 保存段头
            self.sectionHeadAttrsDic[currentSectionIndexPath] = attr;
            [self setCurrentMaxY:[self currentMaxY] + self.ysSectionInset.top + currentSectionHeadHeight row:nil];
        }
        else {
            // 没有段头时，加上段边距
            [self setCurrentMaxY:[self currentMaxY] + self.ysSectionInset.top row:nil];
        }

        // cell
        NSInteger itemNum = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemNum; j++) {
            NSIndexPath * currentItemIndexPath = [NSIndexPath indexPathForRow:j inSection:i];

            // 下一个 item 是接在当前 最短的 item 下面的
            __block CGFloat currentMinY = [self.itemsMaxYDic[@(0)] floatValue];
            __block NSInteger currentRow = 0;   // 列号
            [self.itemsMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber * row, NSNumber * rowMaxY, BOOL * _Nonnull stop) {
                if (currentMinY > [rowMaxY floatValue]) {
                    currentMinY = [rowMaxY floatValue];
                    currentRow = [row integerValue];
                }
            }];

            CGFloat currentItemX = self.ysSectionInset.left + (itemWidth + self.ysSpaceHor)*currentRow;
            CGFloat currentItemY = currentMinY;
            CGFloat currentItemHeight = 0;
            if (self.delegate && [self.delegate respondsToSelector:@selector(ysCustemCollectionView:itemHeightWithIndexPath: itemWidth:)]) {
                currentItemHeight = [self.delegate ysCustemCollectionView:self.collectionView itemHeightWithIndexPath:currentItemIndexPath itemWidth:itemWidth];
            }

            UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:currentItemIndexPath];
            attr.frame = CGRectMake(currentItemX, currentItemY, itemWidth, currentItemHeight);
            self.itemAttrsDic[currentItemIndexPath] = attr;
            [self setCurrentMaxY:currentMinY + currentItemHeight + self.ysSpaceVer row:@(currentRow)];
        }

        // 最后一排 与 段尾 距离为 self.ysSectionInset.bottom
        [self setCurrentMaxY:[self currentMaxY] - self.ysSpaceVer + self.ysSectionInset.bottom row:nil];

        // 段尾
        CGFloat currentSectionFootHeight = 0;
        if (i < [self.ysSectionFootHeightArr count]) {
            currentSectionFootHeight = [self.ysSectionFootHeightArr[i] floatValue];
        }
        if (currentSectionFootHeight > 0 && [self.collectionView.delegate respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {

            UICollectionViewLayoutAttributes * attr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:YSCustemCollectionView_SectionFootKind withIndexPath:currentSectionIndexPath];
            attr.frame = CGRectMake(0, [self currentMaxY], kScreenWidth, currentSectionFootHeight);
            // 保存段尾
            self.sectionFootAttrsDic[currentSectionIndexPath] = attr;
            [self setCurrentMaxY:[self currentMaxY] + currentSectionFootHeight row:nil];
        }

    }
}

//返回当前的ContentSize
- (CGSize)collectionViewContentSize
{
    CGFloat maxY = [self currentMaxY];

    return CGSizeMake(self.collectionView.frame.size.width, MAX(maxY, self.collectionView.frame.size.height));
}


//此方法应该返回当前屏幕正在显示的视图（cell 头尾视图）的布局属性集合（UICollectionViewLayoutAttributes 对象集合）
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 添加当前屏幕可见的 cell / 头 / 尾 视图
    NSMutableArray * allAttrsArr = [NSMutableArray array];

    // cell
    [_itemAttrsDic enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * indexPath, UICollectionViewLayoutAttributes * attr, BOOL * _Nonnull stop) {

        if (CGRectIntersectsRect(rect, attr.frame)) {
            [allAttrsArr addObject:attr];
        }
    }];

    // 头
    [_sectionHeadAttrsDic enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * indexPath, UICollectionViewLayoutAttributes * attr, BOOL * _Nonnull stop) {

        if (CGRectIntersectsRect(rect, attr.frame)) {
            [allAttrsArr addObject:attr];
        }
    }];

    // 尾
    [_sectionFootAttrsDic enumerateKeysAndObjectsUsingBlock:^(NSIndexPath * indexPath, UICollectionViewLayoutAttributes * attr, BOOL * _Nonnull stop) {

        if (CGRectIntersectsRect(rect, attr.frame)) {
            [allAttrsArr addObject:attr];
        }
    }];

    return allAttrsArr;
}

//根据indexPath去对应的UICollectionViewLayoutAttributes  这个是取值的，要重写，在移动删除的时候系统会调用改方法重新去UICollectionViewLayoutAttributes然后布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * itemAttr = _itemAttrsDic[indexPath];
    return itemAttr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * supplementAttr = nil;
    if ([elementKind isEqualToString:YSCustemCollectionView_SectionHeadKind]) {
        supplementAttr = _sectionHeadAttrsDic[indexPath];
    }
    else if ([elementKind isEqualToString:YSCustemCollectionView_SectionFootKind]) {
        supplementAttr = _sectionFootAttrsDic[indexPath];
    }
    return supplementAttr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * decorationAttr = _sectionDecorationDic[indexPath];
    return decorationAttr;
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

#pragma mark - 插入、删除、移动
- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];

    NSMutableArray * needAnimations = [NSMutableArray array];

    for (UICollectionViewUpdateItem * updateItem in updateItems) {
        switch (updateItem.updateAction) {
            case UICollectionUpdateActionInsert:
            {
                [needAnimations addObject:updateItem.indexPathAfterUpdate];
            }
                break;
            case UICollectionUpdateActionDelete:
            {
                [needAnimations addObject:updateItem.indexPathBeforeUpdate];
            }
                break;
            case UICollectionUpdateActionMove:
            {

            }
                break;
                
            default:
                break;
        }
    }

    self.needAnimationIndexPaths = needAnimations;
}

//对应UICollectionViewUpdateItem 的indexPathBeforeUpdate 设置调用
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    if ([self.needAnimationIndexPaths containsObject:itemIndexPath]) {
        UICollectionViewLayoutAttributes *attr = self.itemAttrsDic[itemIndexPath];

        attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
        attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
        attr.alpha = 1;
        [self.needAnimationIndexPaths removeObject:itemIndexPath];
        return attr;
    }
    return nil;
}

//对应UICollectionViewUpdateItem 的indexPathAfterUpdate 设置调用
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    if ([self.needAnimationIndexPaths containsObject:itemIndexPath]) {
        UICollectionViewLayoutAttributes *attr = self.itemAttrsDic[itemIndexPath];
        attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(2, 2), 0);
        attr.alpha = 0;
        [self.needAnimationIndexPaths removeObject:itemIndexPath];
        return attr;
    }
    return nil;

}

- (void)finalizeCollectionViewUpdates
{
    self.needAnimationIndexPaths = nil;
}

#pragma mark - 9.0后移动相关
- (UICollectionViewLayoutInvalidationContext *)invalidationContextForInteractivelyMovingItems:(NSArray<NSIndexPath *> *)targetIndexPaths withTargetPosition:(CGPoint)targetPosition previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths previousPosition:(CGPoint)previousPosition
{
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForInteractivelyMovingItems:targetIndexPaths withTargetPosition:targetPosition previousIndexPaths:previousIndexPaths previousPosition:previousPosition];

    if([self.delegate respondsToSelector:@selector(ysCustemCollectionView:beginIndexPath:endIndexPath:)]){
        [self.delegate ysCustemCollectionView:self.collectionView beginIndexPath:previousIndexPaths[0] endIndexPath:targetIndexPaths[0]];
    }
    return context;
}

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:(NSArray<NSIndexPath *> *)indexPaths previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths movementCancelled:(BOOL)movementCancelled
{
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:indexPaths previousIndexPaths:previousIndexPaths movementCancelled:movementCancelled];

    if(!movementCancelled){

    }
    return context;
}

#pragma mark - custem method
- (CGFloat)currentMaxY
{
    __block CGFloat lastRowMaxY = 0;
    [self.itemsMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber * columnt, NSNumber * columntMaxY, BOOL * _Nonnull stop) {
        if (lastRowMaxY < [columntMaxY floatValue]) {
            lastRowMaxY = [columntMaxY floatValue];
        }
    }];
    return lastRowMaxY;
}

- (void)setCurrentMaxY:(CGFloat)currentMaxY row:(NSNumber *)rowNum
{
    if (rowNum == nil) {
        for (int i = 0; i < self.ysColumntCount; i++) {
            self.itemsMaxYDic[@(i)] = @(currentMaxY);
        }
    }
    else {
        self.itemsMaxYDic[rowNum] = @(currentMaxY);
    }
}

@end
