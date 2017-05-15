//
//  ApplicationSettingViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ApplicationSettingViewController.h"
#import "YSButton.h"

static NSString * const cell_id = @"cell_id";
static NSString * const cell_id_openurl = @"cell_id_openurl";

@interface ApplicationSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * appSettingTableView;
@property (nonatomic, strong) UITableView * openUrlTableView;

@end

@implementation ApplicationSettingViewController
{
    NSArray * _dataArr;
    NSArray * _openUrlDataArr;
    
    BOOL _isShowNetWorkIndicator;
    BOOL _isShowAPPNumber;
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
    self.title = @"一些设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = @[@"应用程序未读数", @"网络指示器", @"OpenUrl方法"];
    _openUrlDataArr = @[@"打电话 10086", @"发短信 10086", @"发邮件", @"打开网页", @"打开app"];
    
    _isShowAPPNumber = NO;
    _isShowNetWorkIndicator = NO;
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)createTableView
{
    _appSettingTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth - 120, 0, 120, kScreenHeightNo113) style:UITableViewStylePlain];
    _appSettingTableView.delegate = self;
    _appSettingTableView.dataSource = self;
    _appSettingTableView.showsVerticalScrollIndicator = NO;
    _appSettingTableView.hidden = YES;
    [self.view addSubview:_appSettingTableView];
    
    [_appSettingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
    
    
    _openUrlTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 120, kScreenHeight - 64) style:UITableViewStylePlain];
    _openUrlTableView.delegate = self;
    _openUrlTableView.dataSource = self;
    _openUrlTableView.hidden = YES;
    [self.view addSubview:_openUrlTableView];
    
    [_openUrlTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id_openurl];
}

- (void)clickRightBtn
{
    BOOL isShowTableView = _appSettingTableView.hidden;
    dispatch_async(dispatch_get_main_queue(), ^{
       _appSettingTableView.hidden = !isShowTableView;
    });
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _appSettingTableView) {
        return [_dataArr count];
    }
    
    return [_openUrlDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _appSettingTableView) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        cell.textLabel.text = [_dataArr objectAtIndex:indexPath.row];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        return cell;
        
    } else {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id_openurl];
        cell.textLabel.text = [_openUrlDataArr objectAtIndex:indexPath.row];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIApplication * app = [UIApplication sharedApplication];
    
    if (tableView == _appSettingTableView) {
        if (indexPath.row == 0) {
            
            NSInteger num = (_isShowAPPNumber == YES) ? 12 : 0;
            app.applicationIconBadgeNumber = num;
            _isShowAPPNumber = !_isShowAPPNumber;
            
        } else if (indexPath.row == 1) {
            
            _isShowNetWorkIndicator = !_isShowNetWorkIndicator;
            app.networkActivityIndicatorVisible = _isShowNetWorkIndicator;
            
        } else if (indexPath.row == 2) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                BOOL isShow = _openUrlTableView.hidden;
                _openUrlTableView.hidden = !isShow;
            });
        }

    } else {
        
        if (indexPath.row == 0) {
            
            [app openURL:[NSURL URLWithString:@"tel://10086"]];
            
        } else if (indexPath.row == 1) {
            
            [app openURL:[NSURL URLWithString:@"sms://10086"]];
        
        } else if (indexPath.row == 2) {
            
            [app openURL:[NSURL URLWithString:@"mailto://2046934644@qq.com"]];
            
        } else if (indexPath.row == 3) {
            
            [app openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
            
        } else if (indexPath.row == 4) {
            
        }
    
    }
}

@end
