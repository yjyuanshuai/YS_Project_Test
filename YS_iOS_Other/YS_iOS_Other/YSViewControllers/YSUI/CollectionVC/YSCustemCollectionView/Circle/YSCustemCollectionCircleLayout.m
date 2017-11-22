//
//  YSCustemCollectionCircleLayout.m
//  YS_iOS_Other
//
//  Created by YJ on 2017/11/22.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSCustemCollectionCircleLayout.h"

@implementation YSCustemCollectionCircleLayout

//重写shouldInvalidateLayoutForBoundsChange,每次重写布局内部都会自动调用
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//重写layoutAttributesForItemAtIndexPath,返回每一个item的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建布局实例
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //设置item的大小
    attrs.size = CGSizeMake(100, 100);
    
    //设置圆的半径
    CGFloat circleRadius = 100;
    
    //设置圆的中心点
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width*0.5, self.collectionView.frame.size.height *0.5);
    
    //计算每一个item之间的角度
    CGFloat angleDelta = M_PI *2 /[self.collectionView numberOfItemsInSection:indexPath.section];
    
    //计算当前item的角度
    CGFloat angle = indexPath.item * angleDelta;
    
    //计算当前item的中心
    CGFloat x = circleCenter.x + cos(angle)*circleRadius;
    CGFloat y = circleCenter.y - sin(angle)*circleRadius;
    
    //定位当前item的位置
    attrs.center = CGPointMake(x, y);
    
    //设置item的顺序,越后面的显示在前面
    attrs.zIndex = indexPath.item;
    
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

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

@end
