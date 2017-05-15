//
//  JSAndVCMethodListVC.m
//  YS_iOS_Other
//
//  Created by YJ on 16/12/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "JSAndOCMethodListVC.h"
#import "JSAndOCVC.h"

static NSString * const MethodListCellID = @"MethodListCellID";

@interface JSAndOCMethodListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * methodListTableView;

@end

@implementation JSAndOCMethodListVC
{
    NSMutableArray * _listDataArr;
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
    self.title = @"JS与OC交互";
    _listDataArr = [@[@"JS调OC（拦截）", @"JS调OC（JavaScriptCore）", @"OC调JS（String）", @"OC调JS（JavaScriptCore）"] mutableCopy];
}

- (void)createTableView
{
    _methodListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _methodListTableView.delegate = self;
    _methodListTableView.dataSource = self;
    [self.view addSubview:_methodListTableView];
    
    [_methodListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_methodListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MethodListCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MethodListCellID];
    cell.textLabel.text = _listDataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MethodType clickType = -1;
    NSString * clickTitle = _listDataArr[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
        {
            clickType = MethodTypeJSToOCIntercept;
        }
            break;
        case 1:
        {
            clickType = MethodTypeJSToOCJavaScriptCore;
        }
            break;
        case 2:
        {
            clickType = MethodTypeOCToJSString;
        }
            break;
        case 3:
        {
            clickType = MethodTypeOCToJSJavaScriptCore;
        }
            break;
        default:
            break;
    }
    
    JSAndOCVC * jsandocVC = [[JSAndOCVC alloc] initWithMethodType:clickType title:clickTitle];
    [self.navigationController pushViewController:jsandocVC animated:YES];
}

@end
