//
//  TextAttachmentViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "TextAttachmentViewController.h"
#import "ChatViewController.h"
#import "ImageTextVC.h"
#import "FriendCircleVC.h"

@interface TextAttachmentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * selectTableView;

@end

@implementation TextAttachmentViewController
{
    NSArray * _dataArr;
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

/*****
 1、组装表情和文字对应的 plist 文件
 2、解析转化为 数组
 3、创建 NSMutableAttributedString
 4、通过正则表达式匹配字符串，NSRegularExpression
 5、将特殊字符与对应表情关联
 6、将特殊字符替换成图片
 
 ****/

- (void)initUIAndData
{
    self.title = @"图文混排 - TextAttach";
    
    _dataArr = @[@"聊天", @"图文混排", @"朋友圈"];
}

- (void)createTableView
{
    _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _selectTableView.delegate = self;
    _selectTableView.dataSource = self;
    [self.view addSubview:_selectTableView];
    
    [_selectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        // 聊天
        ChatViewController * chatVC = [[ChatViewController alloc] init];
        [self.navigationController pushViewController:chatVC animated:YES];
    }
    else if (indexPath.row == 1) {
        // 图文混排
        ImageTextVC * imageTextVC = [[ImageTextVC alloc] init];
        [self.navigationController pushViewController:imageTextVC animated:YES];
    }
    else if (indexPath.row == 2) {
        // 朋友圈
    }
}

@end
