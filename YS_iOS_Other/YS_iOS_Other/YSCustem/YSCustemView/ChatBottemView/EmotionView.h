//
//  EmotionView.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

/**
 
 30 * 30
 3*7
 
 */

#import <UIKit/UIKit.h>
@class EmotionModel;

@protocol EmotionViewDelegate <NSObject>

- (void)selectedEmotion:(EmotionModel *)model;
- (void)sendMessage;

@end

@interface EmotionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray * emotionsArr;
@property (nonatomic, weak) id<EmotionViewDelegate> delegate;

@property (nonatomic, strong) UICollectionView * emotionCollectionView;

@property (nonatomic, strong) UIView * selectEmotionView;
@property (nonatomic, strong) UIButton * sendBtn;
@property (nonatomic, strong) UIButton * deleteBtn;

+ (instancetype)shareEmotionView;
- (CGFloat)getEmotionViewHeight;

@end
