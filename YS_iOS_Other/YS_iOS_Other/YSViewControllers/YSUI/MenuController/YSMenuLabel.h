//
//  YSMenuLabel.h
//  YS_iOS_Other
//
//  Created by YJ on 17/6/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSMenuLabelDelegate <NSObject>

- (void)showMenu;

@end

@interface YSMenuLabel : UILabel

@property (nonatomic, weak) id<YSMenuLabelDelegate>delegate;

@end
