//
//  ShowImageWordSortViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/9/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ShowImageWordSortViewController.h"

@interface ShowImageWordSortViewController ()

@property (nonatomic, strong) Class viewClass;

@end

@implementation ShowImageWordSortViewController

- (instancetype)initWithView:(Class)contentViewClass
                       title:(NSString *)title
{
    if (self = [super init]) {
        
        self.title = title;
        _viewClass = contentViewClass;
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view = [_viewClass new];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
