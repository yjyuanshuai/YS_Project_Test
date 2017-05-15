//
//  FriendCircleVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "FriendCircleVC.h"
#import "FriendCircleTableViewCell.h"
#import "FriendCircleModel.h"
#import "UITableView+FDTemplateLayoutCell.h"

static NSString * const FCTableViewCellId = @"FCTableViewCellId";

@interface FriendCircleVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * FCTableView;

@end

@implementation FriendCircleVC
{
    NSMutableArray * _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"图文混排";
    
    _dataArr = [@[] mutableCopy];
}

- (void)createTableView
{
    _FCTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _FCTableView.delegate = self;
    _FCTableView.dataSource = self;
    _FCTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_FCTableView];
    
    [_FCTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_FCTableView registerClass:[FriendCircleTableViewCell class] forCellReuseIdentifier:FCTableViewCellId];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCircleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:FCTableViewCellId];
    [cell setCellContent:_dataArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:FCTableViewCellId cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell setCellContent:_dataArr[indexPath.row]];
    }];
}

@end
