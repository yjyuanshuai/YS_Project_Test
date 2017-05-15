//
//  SQLDetailViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/7/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SQLDetailViewController.h"
#import "NSString+YSStringDo.h"

@implementation SQLDetailModel

- (instancetype)initWithData:(NSIndexPath *)indexPath
{
    if (self = [super init]) {
        
        NSInteger sectionIndex = indexPath.section;
        NSInteger rowIndex = indexPath.row;
        
        NSArray * keyArr = @[];
        if (sectionIndex == 0) {
            keyArr = @[@"feild", @"create", @"drop"];
        }
        else if (sectionIndex == 1){
            keyArr = @[@"insert", @"update", @"delete"];
        }
        else if (sectionIndex == 2){
            keyArr = @[@"select", @"where", @"order", @"group", @"having", @"limit", @"byname", @"count"];
        }
        else if (sectionIndex == 3){
            keyArr = @[@"simple", @"primary", @"foreign"];
        }
        else if (sectionIndex == 4){
            keyArr = @[@"inlink", @"outlink"];
        }
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"sqlKnowledge" ofType:@"plist"];
        NSArray * sectionsArr = [NSArray arrayWithContentsOfFile:path];
        NSArray * sectionArr = sectionsArr[sectionIndex];
        NSDictionary * contentDic = sectionArr[rowIndex];
        NSString * keyStr = keyArr[rowIndex];
        _strArr = contentDic[keyStr];
        
    }
    return self;
}

@end










@interface SQLDetailViewController ()

@end

@implementation SQLDetailViewController
{
    NSIndexPath * _indexPath;
    NSString * _titleStr;
    UILabel * _yslabel;
}
- (instancetype)initWithIndex:(NSIndexPath *)indexPath titleStr:(NSString *)titleStr
{
    if (self = [super init]) {
        _indexPath = indexPath;
        _titleStr = titleStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = _titleStr;
    
    if (_indexPath.section != 5) {
        _yslabel = [UILabel new];
        _yslabel.numberOfLines = 0;
        _yslabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        [self.view addSubview:_yslabel];
        
        [self setupUI];
    }
    
}

- (void)setupUI
{
    _yslabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    SQLDetailModel * model = [[SQLDetailModel alloc] initWithData:_indexPath];
    NSMutableString * contentStr = [NSMutableString string];
    for (NSString * str in model.strArr) {
        [contentStr appendFormat:@"%@\n\n", str];
    }
    contentStr = [contentStr analyseBreakLine];
    _yslabel.text = contentStr;
    
    CGFloat padding_x = 10;
    CGFloat padding_y = 10;
    CGFloat height = [contentStr calculateHeightWithMaxWidth:kScreenWidth - 2*padding_x font:nil miniHeight:40];
    
    NSDictionary * metricsDic = @{@"padding_x":@(padding_x), @"padding_y":@(padding_y), @"height":@(height)};
    NSDictionary * viewsDic = @{@"_yslabel":_yslabel};
    
    NSString * vfl1 = @"H:|-padding_x-[_yslabel]-padding_x-|";
    NSString * vfl2 = @"V:|-padding_y-[_yslabel(==height)]";
    
    NSArray * c1 = [NSLayoutConstraint constraintsWithVisualFormat:vfl1
                                                           options:0
                                                           metrics:metricsDic
                                                             views:viewsDic];
    NSArray * c2 = [NSLayoutConstraint constraintsWithVisualFormat:vfl2
                                                           options:0
                                                           metrics:metricsDic
                                                             views:viewsDic];
    [self.view addConstraints:c1];
    [self.view addConstraints:c2];
}

@end
