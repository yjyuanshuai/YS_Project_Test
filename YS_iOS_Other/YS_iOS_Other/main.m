//
//  main.m
//  YS_iOS_Other
//
//  Created by YJ on 16/6/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

/**
 *  intUIApplicationMain(int argc, char *argv[], NSString * principalClassName, NSString * delegateClassName);
 *
 *
 *  principalClassName：指定应用程序类名（app的象征），该类必须是UIApplication(或子类)。如果为nil,则用UIApplication类作为默认值
 *
 *  delegateClassName：指定应用程序的代理类，该类必须遵守UIApplicationDelegate协议
 *
 *
 *  UIApplicationMain函数会根据principalClassName创建UIApplication对象，根据delegateClassName创建一个delegate对象，并将该delegate对象赋值给UIApplication对象中的delegate属性
 *
 *
 *  接着会建立应用程序的Main Runloop（事件循环），进行事件的处理(首先会在程序完毕后调用delegate对象的application:didFinishLaunchingWithOptions:方法)
 *
 *
 *  程序正常退出时UIApplicationMain函数才返回
 *
 *
 *
 *
 *  系统入口的代码和参数说明：
 
 *      argc:系统或者用户传入的参数
 *      argv:系统或用户传入的实际参数
 *      1.根据传入的第三个参数，创建UIApplication对象
 *      2.根据传入的第四个产生创建UIApplication对象的代理
 *      3.设置刚刚创建出来的代理对象为UIApplication的代理
 *      4.开启一个事件循环（可以理解为里面是一个死循环）这个时间循环是一个队列（先进先出）先添加进去的先处理
 *
 *
 *
 *
 *
 *
 *
 *
 *
 */


