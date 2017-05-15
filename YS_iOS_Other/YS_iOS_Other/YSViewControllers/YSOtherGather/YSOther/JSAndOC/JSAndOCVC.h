//
//  JSAndOCVC.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YSRootViewController.h"

typedef NS_ENUM(NSInteger, MethodType)
{
    MethodTypeJSToOCIntercept,          // JS调OC，方法一拦截
    MethodTypeJSToOCJavaScriptCore,     // JS调OC，方法二JavaScriptCore
    MethodTypeOCToJSString,             // OC调JS，方法一
    MethodTypeOCToJSJavaScriptCore      // OC调JS，方法二JavaScriptCore
};

@interface JSAndOCVC : YSRootViewController

- (instancetype)initWithMethodType:(MethodType)type title:(NSString *)titleStr;

@end
