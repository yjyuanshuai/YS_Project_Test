//
//  CameraOrImageListVC.h
//  YS_iOS_Other
//
//  Created by YJ on 17/2/10.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YSRootViewController.h"
#import <QBImagePickerController/QBImagePickerController.h>
#import "TZImagePickerController.h"

@interface CameraOrImageListVC : YSRootViewController <QBImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TZImagePickerControllerDelegate>

@end
