//
//  ImagesShowViewController.m
//  YS_iOS_Other
//
//  Created by YJ on 16/8/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ImagesShowViewController.h"
#import <Photos/Photos.h>
#import "PhotoCollectionViewCell.h"
#import "TZImagePickerController.h"

static NSString * const PhotoCollectionCellID = @"PhotoCollectionCellID";

@interface ImagesShowViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PhotoCollectionDelegate>

@property (nonatomic, strong) UICollectionView * ysImageCollectionView;

@end

@implementation ImagesShowViewController
{
    NSMutableArray * _photosArr;
    NSMutableArray * _assetsArr;
}

- (instancetype)initWithPhoto:(NSMutableArray *)photos imageAsset:(NSMutableArray *)assets
{
    if (self = [super init]) {
        _photosArr = [NSMutableArray arrayWithArray:photos];
        _assetsArr = [NSMutableArray arrayWithArray:assets];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUIAndData];
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUIAndData
{
    self.title = @"已选图片";
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc] init];
    
    _ysImageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowayout];
    _ysImageCollectionView.backgroundColor = [UIColor whiteColor];
    _ysImageCollectionView.delegate = self;
    _ysImageCollectionView.dataSource = self;
    [self.view addSubview:_ysImageCollectionView];
    
    [_ysImageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_ysImageCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:PhotoCollectionCellID];
}

#pragma mark - PhotoCollectionDelegate
- (void)clickToCheckDetailCurrentIndex:(NSInteger)index
{
    TZImagePickerController * imagePC = [[TZImagePickerController alloc] initWithSelectedAssets:_assetsArr selectedPhotos:_photosArr index:index];
    
    [self presentViewController:imagePC animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击图片，阅览
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_photosArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionCellID forIndexPath:indexPath];
    
    [cell setPhotoCellWithImage:_photosArr[indexPath.row] currentIndex:indexPath.row];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - PHAssert 转 UIImage
- (UIImage *)getImageWithBaseAsset:(PHAsset *)asset {
    
    __block UIImage *resultImage = nil;
    
    　if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *tempAsset = asset;
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        
        // 下面的回调会返回多次 该属性设置YES 只返回一次，返回的是原图
        options.synchronous = YES;
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(tempAsset.pixelWidth, tempAsset.pixelHeight);
        CGFloat scale_width = kScreenWidth * scale;
        CGFloat scale_height = kScreenHeight * scale;
        
        if (tempAsset.pixelWidth > scale_width && tempAsset.pixelHeight > scale_height) {
            
            if (tempAsset.pixelWidth >= tempAsset.pixelHeight) {
                
                size = CGSizeMake(scale_height, (NSInteger)(scale_height/tempAsset.pixelWidth*tempAsset.pixelHeight));
                
            } else {
                
                size = CGSizeMake((NSInteger)(scale_height/tempAsset.pixelHeight*tempAsset.pixelWidth), scale_height);
                
            }
            
        }
        
        __weak typeof(self) weakSelf = self;
        
        [[PHImageManager defaultManager] requestImageForAsset:tempAsset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            NSLog(@"### index");
            
            UIImage *temp_img = result;
            // 该方法是调整图片方向，因为直接取原图的原因，可能取出来的图片信息是：图片不是正常方向
            resultImage = [weakSelf fixOrientation:temp_img];
            
        }];
        
    }
    return resultImage;
}

    
    
    // 修正图片方向
    
    - (UIImage *)fixOrientation:(UIImage *)aImage {
        
        
        
        if (aImage.imageOrientation == UIImageOrientationUp)
            
            return aImage;
        
        CGAffineTransform transform = CGAffineTransformIdentity;
        
        
        
        switch (aImage.imageOrientation) {
                
            case UIImageOrientationDown:
                
            case UIImageOrientationDownMirrored:
                
                transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
                
                transform = CGAffineTransformRotate(transform, M_PI);
                
                break;
                
                
                
            case UIImageOrientationLeft:
                
            case UIImageOrientationLeftMirrored:
                
                transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
                
                transform = CGAffineTransformRotate(transform, M_PI_2);
                
                break;
                
                
                
            case UIImageOrientationRight:
                
            case UIImageOrientationRightMirrored:
                
                transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
                
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                
                break;
                
            default:
                
                break;
                
        }
        
        
        
        switch (aImage.imageOrientation) {
                
            case UIImageOrientationUpMirrored:
                
            case UIImageOrientationDownMirrored:
                
                transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
                
                transform = CGAffineTransformScale(transform, -1, 1);
                
                break;
                
                
                
            case UIImageOrientationLeftMirrored:
                
            case UIImageOrientationRightMirrored:
                
                transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
                
                transform = CGAffineTransformScale(transform, -1, 1);
                
                break;
                
            default:
                
                break;
                
        }
        
        
        
        CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                                 
                                                 CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                                 
                                                 CGImageGetColorSpace(aImage.CGImage),
                                                 
                                                 CGImageGetBitmapInfo(aImage.CGImage));
        
        CGContextConcatCTM(ctx, transform);
        
        switch (aImage.imageOrientation) {
                
            case UIImageOrientationLeft:
                
            case UIImageOrientationLeftMirrored:
                
            case UIImageOrientationRight:
                
            case UIImageOrientationRightMirrored:
                
                CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
                
                break;
                
                
                
            default:
                
                CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
                
                break;
                
        }
        
        
        
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
        
        UIImage *img = [UIImage imageWithCGImage:cgimg];
        
        CGContextRelease(ctx);
        
        CGImageRelease(cgimg);
        
        return img;
        
    }

@end
