//
//  YSCustemSearchController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSCustemSearchController.h"
#import "YSCustemSearchBar.h"

@interface YSCustemSearchController ()

@property (nonatomic, strong) UIViewController * currentCustemRootVC;

@end

@implementation YSCustemSearchController

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController
                                 searchBarFrame:(CGRect)frame
                                       textFont:(UIFont *)font
                                      textColor:(UIColor *)color
{
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        
        _ysSearchBar = [[YSCustemSearchBar alloc] initWithFrame:frame font:font color:color];
        _ysSearchBar.delegate = self;
        
        _ysSearchBar.defaultLineColor = [UIColor redColor];
        _ysSearchBar.defaultLineWidth = 5;
        _ysSearchBar.placeholder = @"搜索占位提示语";
        
        _ysSearchBar.showsCancelButton = NO;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)dealloc
{
    _currentCustemRootVC = nil;
}

#pragma mark - 
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_searchBarDelegate && [_searchBarDelegate respondsToSelector:@selector(searchButtonClicked:)]) {
        [_ysSearchBar resignFirstResponder];
        [_ysSearchBar setShowsCancelButton:NO animated:YES];
        [_searchBarDelegate searchButtonClicked:searchBar];
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    if (_searchBarDelegate && [_searchBarDelegate respondsToSelector:@selector(cancleButtonClicked:)]) {
        [_ysSearchBar resignFirstResponder];
        [_ysSearchBar setShowsCancelButton:NO animated:YES];
        [_searchBarDelegate cancleButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (_searchBarDelegate && [_searchBarDelegate respondsToSelector:@selector(didChangeSearchText:searchBar:)]) {
        [_searchBarDelegate didChangeSearchText:searchText searchBar:searchBar];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (_searchBarDelegate && [_searchBarDelegate respondsToSelector:@selector(searchBegin:)]) {
        [_ysSearchBar setShowsCancelButton:YES animated:YES];
        [_searchBarDelegate searchBegin:searchBar];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (_searchBarDelegate && [_searchBarDelegate respondsToSelector:@selector(searchEnd:)]) {
        [_searchBarDelegate searchEnd:searchBar];
    }
}

@end
