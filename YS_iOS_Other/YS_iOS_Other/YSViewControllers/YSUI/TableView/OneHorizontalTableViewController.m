//
//  OneHorizontalTableViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/14.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "OneHorizontalTableViewController.h"
#import "OneHorizontalTableViewCell.h"
#import "CollectionTestModel.h"

static NSString * cell_id = @"one_horizontal_tableView_cell_id";

@interface OneHorizontalTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * horizontalTableView;

@end

@implementation OneHorizontalTableViewController
{
    NSMutableArray * _modelsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self initHorizonTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"横向Tableview";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _modelsArr = [NSMutableArray arrayWithArray:@[[self getCollectionModle:@"1" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"2" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"3" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"4" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"5" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"6" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"7" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"8" title:@"主题" desc:@"详情"],
                                                  [self getCollectionModle:@"9" title:@"主题" desc:@"详情"]]];
}

- (void)initHorizonTableView
{
    _horizontalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 130, kScreenWidth) style:UITableViewStylePlain];
    _horizontalTableView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 130/2);
    _horizontalTableView.backgroundColor = [UIColor yellowColor];
    _horizontalTableView.delegate = self;
    _horizontalTableView.dataSource = self;
    _horizontalTableView.showsHorizontalScrollIndicator = NO;
    _horizontalTableView.showsVerticalScrollIndicator = NO;
    _horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_horizontalTableView];
    [_horizontalTableView registerClass:[OneHorizontalTableViewCell class] forCellReuseIdentifier:cell_id];
    
    // 转向
    _horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    
    // 添加拖动手势
//    UIPanGestureRecognizer * longGesure = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesure:)];
//    [_horizontalTableView addGestureRecognizer:longGesure];
//    
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

#pragma mark - 
- (void)longPressGesure:(UIPanGestureRecognizer *)longGesure
{
    CGPoint point = [longGesure locationInView:self.view];
    NSIndexPath * indexPath = [_horizontalTableView indexPathForRowAtPoint:point];      // 当前手指所在indexPath
    
    NSInteger state = longGesure.state;
    
    NSIndexPath * sourceIndexPath = nil;
    UIView * movingView = nil;
    
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            if (indexPath) {
                OneHorizontalTableViewCell * cell = [_horizontalTableView cellForRowAtIndexPath:indexPath];
                movingView = [self movingViewWithCell:cell];
                
                [self.view addSubview:movingView];
                
                sourceIndexPath = indexPath;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
        default:
            break;
    }
}

- (UIView *)movingViewWithCell:(UIView *)cellView
{
    UIView * movingView = [cellView snapshotViewAfterScreenUpdates:YES];
    movingView.layer.masksToBounds = NO;
    movingView.layer.cornerRadius = 0.0;
    movingView.layer.shadowOffset = CGSizeMake(-0.5, 0);
    movingView.layer.shadowRadius = 5.0;
    movingView.layer.shadowOpacity = 0.4;
    return movingView;
}

#pragma mark - 
- (CollectionTestModel *)getCollectionModle:(NSString *)imageName title:(NSString *)title desc:(NSString *)desc
{
    CollectionTestModel * model = [[CollectionTestModel alloc] initWithImageName:imageName title:title desc:desc];
    return model;
}


#pragma mark - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_modelsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneHorizontalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    CollectionTestModel * model = [_modelsArr objectAtIndex:indexPath.row];
    [cell setCellContent:model indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 15)];
    headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    footView.backgroundColor = [UIColor yellowColor];
    return footView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/**********
#pragma mark - 
// 1、设置可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 2、允许拖动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 3、移动风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

// 4、交换数据
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{

}
*/


@end
