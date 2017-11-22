//
//  YSCustemCollectionStackLayout.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/21.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionStackLayout.h"

@implementation YSCustemCollectionStackLayout

//重写 shouldInvalidateLayoutForBoundsChange ,每次重写布局内部都会自动调用
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

//重写 layoutAttributesForItemAtIndexPath ,返回每一个item的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建布局实例
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置布局属性
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(self.collectionView.frame.size.width*0.5, self.collectionView.frame.size.height*0.5);
    
    //设置旋转方向
    //int direction = (i % 2 ==0)? 1: -1;
    
    NSArray *directions = @[@0.0, @1.0, @(0.05), @(-1.0), @(-0.05)];
    
    //只显示5张
    if (indexPath.item >= 5)
    {
        attrs.hidden = YES;
    }
    else
    {
        //开始旋转
        attrs.transform = CGAffineTransformMakeRotation([directions[indexPath.item]floatValue]);
        
        //zIndex值越大,图片越在上面
        attrs.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
    }
    
    return attrs;
}

//重写layoutAttributesForElementsInRect,设置所有cell的布局属性（包括item、header、footer）
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    //给每一个item创建并设置布局属性
    for (int i = 0; i < count; i++)
    {
        //创建item的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [arrayM addObject:attrs];
    }
    return arrayM;
}

@end
