//
//  ImagePickerManager.h
//  YS_iOS_Other
//
//  Created by YJ on 17/2/10.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QBImagePickerController/QBImagePickerController.h>
#import "TZImagePickerController.h"

typedef NS_ENUM(NSInteger, PickType){
    PickTypeSystemImageLibrary,
    PickTypeSystemCamera,
    PickTypeQBImagePickerImageLibrary,
    PickTypeQBImagePickerCamera,
    PickTypeTZImagePickerImageLibrary
};

//typedef void(^MediaBackBlock)(id mediaSet, UIViewController * viewControl);


@interface ImagePickerManager : NSObject

@property (nonatomic, strong) UIImagePickerController * imagePickerCon;
@property (nonatomic, strong) QBImagePickerController * QBImagePC;
@property (nonatomic, strong) TZImagePickerController * TZImagePC;

- (instancetype)initWithPickerType:(PickType)type
                  selectedImageArr:(NSMutableArray *)selectedImageArr
                listViewController:(UIViewController *)viewController;

@end
