//
//  CameraOrImageListVC.m
//  YS_iOS_Other
//
//  Created by YJ on 17/2/10.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "CameraOrImageListVC.h"
#import "ImagePickerManager.h"
#import "AssetSaveInPlist.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import "ImagesShowViewController.h"

#import "ImagesShowViewController.h"

@interface CameraOrImageListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * listTableView;

@end

@implementation CameraOrImageListVC
{
    NSArray *_listTitleArr;
    NSMutableArray * _photosArr;
    NSMutableArray * _assetsArr;
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
    self.title = @"相机 / 相册";
    
    _listTitleArr = @[@"相册 - 系统", @"相册 - QBImage", @"相册 - TZImage", @"相机 - 系统", @"相机 - QBImage"];
    _photosArr = [@[] mutableCopy];
    _assetsArr = [@[] mutableCopy];
    
    _listTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listTitleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"CELL_ID";
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    cell.textLabel.text = _listTitleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PickType type;
    
    if (indexPath.row == 0) {
        type = PickTypeSystemImageLibrary;
    }
    else if (indexPath.row == 1) {
        type = PickTypeQBImagePickerImageLibrary;
    }
    else if (indexPath.row == 2) {
        type = PickTypeTZImagePickerImageLibrary;
    }
    else if (indexPath.row == 3) {
        type = PickTypeSystemCamera;
    }
    else {
        type = PickTypeQBImagePickerCamera;
    }
    
    typeof(self) weakSelf = self;
    
    ImagePickerManager * imageManager = [[ImagePickerManager alloc] initWithPickerType:type selectedImageArr:nil listViewController:weakSelf];
}

#pragma mark - UINavigationControllerDelegate, UIImagePickerControllerDelegate
// 完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    /*
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 根据资源类型处理
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // 图片
        UIImage * selectedImage = info[UIImagePickerControllerEditedImage];
        
    }
    else {
        // 视频
    }
     */
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    _photosArr = [photos mutableCopy];
    _assetsArr = [assets mutableCopy];
    
    for (int i = 0; i < [_assetsArr count]; i++) {
        AssetSaveInPlist * imageModel = [[AssetSaveInPlist alloc] initWithAsset:_assetsArr[i] sort:[NSString stringWithFormat:@"%d", i]];
        
    }
    
    ImagesShowViewController * imageShowVC = [[ImagesShowViewController alloc] initWithPhoto:_photosArr imageAsset:_assetsArr];
    [self.navigationController pushViewController:imageShowVC animated:YES];
}

#pragma mark - QBImagePickerControllerDelegate
/** 完成选择 */
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    // 完成选择
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
    ImagesShowViewController * imageShowCon = [[ImagesShowViewController alloc] init];
}

/** 取消 */
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)qb_imagePickerController:(QBImagePickerController *)imagePickerController shouldSelectAsset:(PHAsset *)asset
{
    return YES;
}

/** 选中图片 */
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset
{
    
}

/** 取消选中图片 */
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset
{
    
}

@end
