//
//  YSSearchBar.h
//  YS_iOS_Other
//
//  Created by YJ on 16/9/3.
//  Copyright © 2016年 YJ. All rights reserved.
//



/**
 *  默认的 SearchBar 中
 *  UISearchBarTextField.frame.origin = (8, 6)
 *                             height = 28
 *
 *  更改 searchBar 的高度不会不会影响 textFeild 高度
 *
 *
 */

#import <UIKit/UIKit.h>

@interface YSSearchBar : UISearchBar

@property (nonatomic, assign) UIEdgeInsets textFeildContentInset;

@end


