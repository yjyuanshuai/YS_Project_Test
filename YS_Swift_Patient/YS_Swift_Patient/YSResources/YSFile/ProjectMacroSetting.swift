//
//  ProjectMacroSetting.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 尺寸
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenHeightNoStatusAndNav = UIScreen.main.bounds.size.height - 64

// MARK: - 设备信息
let kSystemVersion = (UIDevice.current.systemVersion as NSString).floatValue


// MARK: - 颜色
func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {

    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}

func kRGBColorFromRGB(redValue: Int, greenValue: Int, blueValue: Int) -> (UIColor) {
    return UIColor(red: CGFloat(redValue) / 255.0,
                   green: CGFloat(greenValue) / 255.0,
                   blue: CGFloat(blueValue) / 255.0,
                   alpha: 1.0)
}

let kDefaultBackgroundColor = kRGBColorFromHex(rgbValue: 0xf7f7f7)  // 背景色，浅灰
let kMainColor = kRGBColorFromHex(rgbValue: 0x05b89b)               // 主题色



// MARK: - 字体
func kSystemFontWithSize(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}


let kDefaultSystemFont = kSystemFontWithSize(14.0)


// MARK: - 用户定义宏
let kUserHasLoginKey = "ys_kUserHasLoginKey"







