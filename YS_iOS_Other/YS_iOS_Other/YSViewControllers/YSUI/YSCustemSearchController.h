//
//  YSCustemSearchController.h
//  YS_iOS_Other
//
//  Created by YJ on 16/9/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSCustemSearchBar;

@protocol YSCustemSearchControllerDelegate <NSObject>

@optional
- (void)searchBegin:(UISearchBar *)searchBar;
- (void)searchEnd:(UISearchBar *)searchBar;
- (void)searchButtonClicked:(UISearchBar *)searchBar;
- (void)cancleButtonClicked:(UISearchBar *)searchBar;
- (void)didChangeSearchText:(NSString *)searchText searchBar:(UISearchBar *)searchBar;

@end

@interface YSCustemSearchController : UISearchController <UISearchBarDelegate>

@property (nonatomic, strong, readonly) YSCustemSearchBar * ysSearchBar;

@property (nonatomic, weak) id <YSCustemSearchControllerDelegate> searchBarDelegate;

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController
                                 searchBarFrame:(CGRect)frame
                                       textFont:(UIFont *)font
                                      textColor:(UIColor *)color;

@end
