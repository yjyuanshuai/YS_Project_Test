//
//  SevenBaiduViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "SevenBaiduViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

static NSString * cell_id = @"cell_id";

@interface SevenBaiduViewController () <BMKMapViewDelegate, BMKLocationServiceDelegate, BMKPoiSearchDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BMKMapView * mapView;
@property (nonatomic, strong) UITableView * modeDoTableView;

@end

@implementation SevenBaiduViewController
{
    BOOL _isShowRightBtn;
    BOOL _isStandard;
    BOOL _isShowTraffic;
    BOOL _isShowHeat;
    
    int _currentPage;
    
    BMKLocationService * _locService;
    BMKPoiSearch * _searcher;
    
    NSArray * _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _mapView.mapType = BMKMapTypeStandard;
    self.view = _mapView;
    
    _modeDoTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 0, 100, kScreenHeight - 64) style:UITableViewStylePlain];
    _modeDoTableView.hidden = YES;
    _modeDoTableView.delegate = self;
    _modeDoTableView.dataSource = self;
    [self.view addSubview:_modeDoTableView];
    [_modeDoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
    
    
    BMKPointAnnotation * annation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annation.coordinate = coor;
    annation.title = @"北京北京";
    [_mapView addAnnotation:annation];
    
    
    // 定位
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];     // 启动LocationService
    _mapView.showsUserLocation = YES;
    
    
    // POI检索
    _searcher = [[BMKPoiSearch alloc] init];
    _searcher.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;  // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _searcher.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"百度地图";
    
    _titleArr = @[@"切换type", @"实时交通", @"热力图", @"POI检索", @"路线规划"];
    _isShowRightBtn = NO;
    _isStandard = YES;
    _isShowTraffic = NO;
    _isShowHeat = NO;
    
    _currentPage = 0;
    
    UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"操作" style:UIBarButtonItemStylePlain target:self action:@selector(MoreDoAction)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView * newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnation"];
        newAnnotation.pinColor = BMKPinAnnotationColorGreen;
        newAnnotation.animatesDrop = NO;// 设置该标注点动画显示
        return newAnnotation;
    }
    return nil;
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    // 处理方向变更信息
    [_mapView updateLocationData:userLocation];

}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    // 处理位置坐标更新
    
    [_mapView updateLocationData:userLocation];

}

#pragma mark - PoiSearchDeleage
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
        
    }
    else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedIndex = (int)indexPath.row;
    switch (selectedIndex) {
        case 0:
        {
            // 地图类型
            if (_isStandard) {
                [_mapView setMapType:BMKMapTypeStandard];
            } else {
                [_mapView setMapType:BMKMapTypeSatellite];
            }
            _isStandard = !_isStandard;
        }
            break;
            
        case 1:
        {
            // 实时交通
            if (_isShowTraffic) {
                [_mapView setTrafficEnabled:YES];
            } else {
                [_mapView setTrafficEnabled:NO];
            }
            _isShowTraffic = !_isShowTraffic;
        }
            break;
            
        case 2:
        {
            // 热力图
            if (_isShowHeat) {
                [_mapView setBaiduHeatMapEnabled:YES];
            } else {
                [_mapView setBaiduHeatMapEnabled:NO];
            }
            _isShowHeat = !_isShowHeat;

        }
            break;
            
        case 3:
        {
            // 发起检索（当前位置）
            BMKNearbySearchOption * option = [[BMKNearbySearchOption alloc] init];
            option.pageIndex = _currentPage;
            option.pageCapacity = 10;
            option.location = (CLLocationCoordinate2D){39.915, 116.404};
            option.keyword = @"小吃";
            BOOL flag = [_searcher poiSearchNearBy:option];
            if(flag)
            {
                NSLog(@"周边检索发送成功");
            }
            else
            {
                NSLog(@"周边检索发送失败");
            }
            
            /*
             //POI详情检索
             BMKPoiDetailSearchOption* option = [[BMKPoiDetailSearchOption alloc] init];
             option.poiUid = @”此处为POI的uid”;//POI搜索结果中获取的uid
             BOOL flag = [_poisearch poiDetailSearch:option];
             */
            
            /*
             BMKBusLineSearchOption *buslineSearchOption = [[BMKBusLineSearchOption alloc]init];
             buslineSearchOption.city= @"北京";
             buslineSearchOption.busLineUid= @"your bus line UID";
             BOOL flag = [_searcher busLineSearch:buslineSearchOption];
             */
            
        }
            break;
        case 4:
        {
        
        }
            break;

        default:
            break;
    }
}

#pragma mark - 
- (void)MoreDoAction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _modeDoTableView.hidden = _isShowRightBtn;
        _isShowRightBtn = !_isShowRightBtn;
    });
}

@end
