//
//  YSOperationDetailUserVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/3/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSOperationDetailUserVC.h"
#import "YSOperation.h"
#import "YSOperationDetailCollectionViewCell.h"

#import "AFNetworking.h"

static NSString * const OperationCollectionCellID = @"OperationCollectionCellID";
static dispatch_queue_t addtaskqueue;

@interface YSOperationDetailUserVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collecionView;

@end

@implementation YSOperationDetailUserVC
{
    YS_OperationType _type;
    NSMutableArray * _imagesArr;
    NSMutableArray * _failImagesArr;
    
    NSOperationQueue * _currentOperationQueue;
}

- (instancetype)initWithType:(YS_OperationType)type title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (_type == YS_OperationTypeCustem) {
        _imagesArr = [@[] mutableCopy];
        _failImagesArr = [@[] mutableCopy];
        
        [self createCollectionView];
        [self testWithOperationQueue];
        
        UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelRequestData)];
        self.navigationItem.rightBarButtonItem = rightBtn;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((kScreenWidth - 5*10)/4, (kScreenWidth - 5*10)/4);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    _collecionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collecionView.delegate = self;
    _collecionView.dataSource = self;
    _collecionView.backgroundColor = [UIColor whiteColor];
    _collecionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:_collecionView];
    
    [_collecionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_collecionView registerClass:[YSOperationDetailCollectionViewCell class] forCellWithReuseIdentifier:OperationCollectionCellID];
}

- (void)testWithOperationQueue
{
    NSInteger requestNum = 100;
    
    _currentOperationQueue = [[NSOperationQueue alloc] init];
    _currentOperationQueue.maxConcurrentOperationCount = 3;
    
    for (int i = 0; i < requestNum; i++) {
        /**/
        YSOperation * operation = [[YSOperation alloc] initWithUrl:@"https://httpbin.org/image/png" successBlock:^(NSString *retCode, id response, NSString *retMessage, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_imagesArr addObject:response];
                [_collecionView reloadData];
            });
            
        } failBlock:^(NSString *retCode, id response, NSString *retMessage, NSError *error) {
            
            DDLogInfo(@"------- request error");
            
        }];
        [_currentOperationQueue addOperation:operation];
        
        /*
        [_currentOperationQueue addOperationWithBlock:^{
            NSURL * url = [NSURL URLWithString:@"https://httpbin.org/image/png"];
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            
            NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                DDLogInfo(@"------- current thread: %@", [NSThread currentThread]);
                
                if (!error && [data length] > 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_imagesArr addObject:data];
                        [_collecionView reloadData];
                    });
                }
                else {
                    DDLogInfo(@"---------- error !");
                }
            }];
            
            [task resume];
        }];
         */
    }
}

- (void)cancelRequestData
{
    [_currentOperationQueue cancelAllOperations];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_imagesArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSOperationDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:OperationCollectionCellID forIndexPath:indexPath];
    if (indexPath.row < [_imagesArr count]) {
        [cell setCollectionCell:_imagesArr[indexPath.row]];
    }
    return cell;
}

@end
