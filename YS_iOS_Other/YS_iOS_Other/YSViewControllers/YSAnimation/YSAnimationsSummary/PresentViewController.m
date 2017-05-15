//
//  PresentViewController.m
//  各种动画Test
//
//  Created by YJ on 16/7/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "PresentViewController.h"
#import "CoreAnimationViewController.h"

@interface PresentViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * presentTableView;

@end

@implementation PresentViewController
{
    NSArray * _titleArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleArr = @[@"向上滑入", @"水平翻转进入", @"交叉溶解", @"翻页"];
    
    [self initUI];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.title = @"模态动画";
}

- (void)createTableView
{
    _presentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_presentTableView];
    _presentTableView.delegate = self;
    _presentTableView.dataSource = self;
    
    [_presentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cell_id = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CoreAnimationViewController * animationVC = [[CoreAnimationViewController alloc] init];
    
    if (indexPath.row) {
        // 向上滑入
        animationVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    else if (indexPath.row == 1) {
        
        // 水平翻转进入
        animationVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    else if (indexPath.row == 2) {
        // 交叉溶解
        animationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    else if (indexPath.row == 3) {
        // 翻页
        animationVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    }
    
    [self presentViewController:animationVC animated:YES completion:nil];
}

@end
