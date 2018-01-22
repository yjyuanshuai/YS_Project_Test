//
//  YSHistoryView.h
//  YS_iOS_Other
//
//  Created by YJ on 16/6/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSHistoryBtn;


#pragma mark - YSHistoryView
@interface YSHistoryView : UIView

@property (nonatomic, assign) BOOL isShowDelete;
@property (nonatomic, strong) NSArray * stringArr;          // 历史记录数组

@property (nonatomic, strong) UILabel * headerTitleLabel;
@property (nonatomic, strong) UIButton * headerEditBtn;
@property (nonatomic, strong) UIButton * headerDeleteBtn;

+ (instancetype)historyViewShowWithFrame:(CGRect)frame stringArr:(NSArray *)stringArr;
+ (void)historyViewHide;
+ (void)historyViewUpdate;

@end





#pragma mark - YSHistoryBtn

@protocol YSHistoryBtnDelegate <NSObject>

- (void)deleteThisHistory:(YSHistoryBtn *)btn;
- (void)clickThisHistoryBtn:(YSHistoryBtn *)btn;

@end

@interface YSHistoryBtn : UIView

@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, strong) UIColor * borderColor;    // 边框颜色
@property (nonatomic, assign) CGFloat borderWidth;    // 边框宽度
@property (nonatomic, assign) CGFloat corderRadus;    // 边框角度
@property (nonatomic, strong) UIColor * btnTintColor;   //内容颜色
@property (nonatomic, strong) NSString * historyStr;


@property (nonatomic, strong) UIImage * deleteBtnImage;     // 右上脚 删除按钮
@property (nonatomic, weak) id<YSHistoryBtnDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end

