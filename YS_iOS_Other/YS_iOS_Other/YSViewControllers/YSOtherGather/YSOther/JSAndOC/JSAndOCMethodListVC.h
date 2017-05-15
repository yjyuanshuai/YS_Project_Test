//
//  JSAndVCMethodListVC.h
//  YS_iOS_Other
//
//  Created by YJ on 16/12/21.
//  Copyright © 2016年 YJ. All rights reserved.
//



/*********************************************
 
 
 JS 调用 OC：
 
 1、方式一（ 拦截 ）
 用JS发起一个假的URL请求，然后利用UIWebView的代理方法拦截这次请求，然后再做相应的处理。
 
 2、方式二（ JavaScriptCore ）
 在iOS 7之后，apple添加了一个新的库JavaScriptCore，用来做JS交互
 
 
 
 
 
 
 OC 调用 JS：
 
 1、方式一（String）
 2、方式二（JavaScriptCore）
 
 
 ***********************************************/

#import "YSRootViewController.h"

@interface JSAndOCMethodListVC : YSRootViewController

@end
